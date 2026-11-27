# Draws the quest area art in the story colours, Art/Minimap and
# Art/WorldMap: the game's own textures, each pixel in the story's colour at
# the brightness of its strongest channel, alpha kept.
# The game's files, saved as <file ID>.blp (wago.tools/api/casc/<file ID>?download):
#   533895 Interface/Minimap/UI-QuestBlobMinimap-Outside
#   533893 Interface/Minimap/UI-QuestBlob-MinimapRing
#   334387 Interface/WorldMap/UI-QuestBlob-Inside
#   334388 Interface/WorldMap/UI-QuestBlob-Outside
#   python3 _Dev/art/quest-areas.py <dir with PIL, or ""> <dir with the .blp files> Art
import sys
if sys.argv[1]: sys.path.insert(0, sys.argv[1])
from PIL import Image
GAME, ART = sys.argv[2], sys.argv[3]
# Code/UI/StoryQuestMarks.lua: FOLLOWED_STORY_COLOR, OTHER_STORY_COLOR
STORIES = {"Followed": (0.3, 1, 0.3), "Other": (0.75, 1, 0.1)}
FILES = [
    (533895, "Minimap/QuestAreaOutside"),
    (533893, "Minimap/QuestAreaRing"),
    (334387, "WorldMap/QuestAreaInside"),
    (334388, "WorldMap/QuestAreaOutside"),
]
for file_id, name in FILES:
    game = Image.open(f"{GAME}/{file_id}.blp").convert("RGBA")
    for story, colour in STORIES.items():
        art = Image.new("RGBA", game.size)
        art.putdata([tuple(round(channel * max(red, green, blue)) for channel in colour) + (alpha,)
                     for red, green, blue, alpha in game.getdata()])
        art.save(f"{ART}/{name}{story}.tga")
