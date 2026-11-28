#!/usr/bin/env python3
"""Reads the rewards of the series' quests from Blizzard's Game Data API into a local cache,
to check the rewards CSV against (quest-rewards.mjs check).

    python3 _Dev/tools/blizzard-quest-rewards.py <cache.json> [root]

Reads _Dev/forever-quest-series.csv and writes the cache file, which must be outside
every repo:
    {"namespace": ..., "quests": {questID: {"xp", "money", "items", "choices", "reputation", "spell"}}}
items and choices are [itemID, count] pairs (count 1 when the API gives none), reputation
[factionID, amount] pairs. A quest the API doesn't know is kept as {"missing": true}.
Quests already in the cache aren't asked again; delete the file to read them all again.

The cache stays on this machine, outside every repo: Blizzard's API terms don't allow
passing its data on. It is a check only; nothing of it goes into the rewards CSV.
The API gives no item counts, and for level 60 quests its XP is not what the game pays.

The API client and its credentials are AuctionFuturePrices' (tools/blizzard_api.py);
BLIZZARD_API_TOOLS points at another copy of that folder.
"""
import concurrent.futures
import csv
import json
import os
import re
import sys
import urllib.error

if len(sys.argv) < 2:
    sys.exit("Usage: blizzard-quest-rewards.py <cache.json> [root]")
CACHE_FILE = os.path.abspath(sys.argv[1])
ROOT = os.path.abspath(sys.argv[2] if len(sys.argv) > 2 else os.getcwd())
SERIES_FILE = os.path.join(ROOT, "_Dev", "forever-quest-series.csv")
ADDONS_FOLDER = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", "..")
API_TOOLS = os.environ.get("BLIZZARD_API_TOOLS") or os.path.join(ADDONS_FOLDER, "AuctionFuturePrices", "tools")
REGION = "eu"
NAMESPACE = f"static-forever-{REGION}"
PARALLEL_REQUESTS = 8
SAVE_EVERY = 200


def series_quest_ids(series_file):
    with open(series_file, newline="", encoding="utf8") as file:
        return sorted({int(quest_id) for row in csv.DictReader(file) for quest_id in re.split(r"[ /]", row["quest_ids"]) if quest_id})


def item_pairs(entries):
    return [[entry["item"]["id"], entry.get("quantity", 1)] for entry in entries or []]


def quest_rewards(answer):
    """The reward fields of one /data/wow/quest/{id} answer."""
    rewards = answer.get("rewards") or {}
    items = rewards.get("items") or {}
    return {
        "xp": rewards.get("experience", 0),
        "money": (rewards.get("money") or {}).get("value", 0),
        "items": item_pairs(items.get("items")),
        "choices": item_pairs(items.get("choice_of")),
        "reputation": [[entry["reward"]["id"], entry["value"]] for entry in rewards.get("reputations") or []],
        "spell": (rewards.get("spell") or {}).get("id", 0),
    }


def read_quest(api, quest_id):
    try:
        answer, _ = api.get(f"/data/wow/quest/{quest_id}")
    except urllib.error.HTTPError as error:
        if error.code == 404:
            return {"missing": True}
        raise
    return quest_rewards(answer)


def save(cache):
    os.makedirs(os.path.dirname(CACHE_FILE), exist_ok=True)
    with open(CACHE_FILE, "w", encoding="utf8") as file:
        json.dump(cache, file, separators=(",", ":"), sort_keys=True)


def main():
    sys.path.insert(0, API_TOOLS)
    import blizzard_api

    cache = {"namespace": NAMESPACE, "quests": {}}
    if os.path.exists(CACHE_FILE):
        with open(CACHE_FILE, encoding="utf8") as file:
            cache = json.load(file)
    wanted = [quest_id for quest_id in series_quest_ids(SERIES_FILE) if str(quest_id) not in cache["quests"]]
    if not wanted:
        print(f"Nothing to read: all the series' quests are in {CACHE_FILE}.")
        return

    api = blizzard_api.BlizzardApi(REGION)
    api.namespace = NAMESPACE
    api._token()  # one token before the parallel requests, so they don't each ask for one
    done = 0
    with concurrent.futures.ThreadPoolExecutor(PARALLEL_REQUESTS) as pool:
        for quest_id, rewards in zip(wanted, pool.map(lambda quest_id: read_quest(api, quest_id), wanted)):
            cache["quests"][str(quest_id)] = rewards
            done += 1
            if done % SAVE_EVERY == 0:
                save(cache)
                print(f"{done}/{len(wanted)}", flush=True)
    save(cache)
    missing = sum(1 for rewards in cache["quests"].values() if rewards.get("missing"))
    print(f"Read {done} quests; {len(cache['quests'])} in {CACHE_FILE}, {missing} of them unknown to the API.")


if __name__ == "__main__":
    main()
