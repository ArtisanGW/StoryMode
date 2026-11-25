#!/bin/bash
# Runs every test file in tests/ on LuaJIT, from the repo root. Exits non-zero on the first failure.
set -eo pipefail
cd "$(dirname "$0")/.."
for test_file in tests/*.lua; do
    [ "$test_file" = "tests/StoryMarksFakes.lua" ] && continue
    luajit "$test_file"
done
