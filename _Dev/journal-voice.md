# Journal voice

A chapter's journal entry (`recap`) is the character telling the story
afterward, the way you'd tell it to friends over a drink: "So there's this
apothecary in Brill..." It is not a list of what the quests asked for.

## The voice

- First person. Mostly past tense; a story told aloud may slip into the
  present for the setup ("So there's this apothecary. Hums while he works.").
- Plain words, short sentences, a dry joke where one fits. Understatement
  does the work: "It was not a soup."
- Confident. The character did the job and doesn't agonize over it. No
  guilt, no moralizing, no gloating either. A grim moment can land with one
  flat line and move on.
- Tell the best of it, not all of it. Build the entry around one or two
  moments worth telling (a character, an absurd errand, a close call) and a
  punchline or a flat closing line. The other errands get half a sentence
  or nothing. An entry should not mention every quest in its chapter, and
  never walks through them in order ("Then... Then... Then...").
- At most three named characters per entry. The rest are "the elder", "a
  scout", or left out.
- About 80 to 150 words. Paragraph breaks with `\n\n`.

## What it may not do

- Invent events. What happens is what the quests say happens; the jokes,
  asides and small details of how it felt are the narrator's.
- Say who the narrator is: no name, race or gender. Class only in class
  stories.
- Guess at anyone's gender. Use a name, a title or "the sergeant" unless
  the game says.
- Use modern words that break the setting (okay, Tuesday, dude, guys).
- Speak for a choice the player made. Where the story branches, keep it
  open ("I'll let you guess").

## Factions

When the Alliance and the Horde live a chapter differently, the chapter
gets `recapAlliance` and `recapHorde` instead of `recap`, and each tells
only its own side. A chapter both sides share keeps `recap`. Forever's
version of a chapter goes in `foreverText` the same way.

## Class stories

The narrator talks like the class:

- Rogue: a professional. Money, locks, exits. Cocky, unbothered.
- Warrior: blunt. Says what hit what.
- Paladin: earnest about duty, with a sense of humor about everything else.
- Priest: warm, wry, notices people.
- Mage: clever and knows it.
- Warlock: dark humor, on first-name terms with demons.
- Hunter: practical. The pet gets credit.
- Shaman: listens to the elements and occasionally argues with them.
- Druid: patient, unhurried, a little amused by people.

## Chapter intros

A chapter's intro (`summary`) is what the player reads before playing it,
on the Progress page and the chapter's tooltip. In Explorer mode it is
nearly all they see. It is a hook, like the back of a book: who wants
something, where to find them, and why it's worth going.

- Second person, present tense. Plain words; a dry touch is welcome.
- Only what the player knows when the chapter starts. Never say how it
  turns out, who the villain is, who dies or betrays whom, what something
  turns out to be, or anything from a later chapter. If a fact would land
  as a surprise in the quests, it stays out of the intro.
- Say where to begin: the person and place that start it, or the letter
  or item that does.
- No promises of outcome ("and stop the Syndicate", "to save the village").
- About 20 to 45 words, one paragraph.
- Same rules as the journal on the player's race, gender and name, and on
  NPC genders.
- Where the Alliance and the Horde start a chapter differently, use
  `summaryAlliance` and `summaryHorde` instead of `summary`.
  Forever's version goes in `foreverText` the same way.

## Translations

Keep the register: casual spoken storytelling, not literary prose.
German narrators use "ich"; speaking to listeners, "ihr" (plural, as at a
tavern table), never "Ihr" or "Sie". Names follow the locale's official
names, as everywhere else.

Where a language marks the narrator's gender (Russian past tense, French,
Spanish, Italian and Portuguese participles and adjectives), write both
forms with the game's token, `$Gmale:female;`, as quest text does:
"я $Gпошёл:пошла;". The journal fills it for the player's character. The
forms themselves must not contain `:` or `;`. Rephrase instead where a
sentence would need many tokens.
