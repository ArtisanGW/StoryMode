# Makes Art/Decor/lordaeron.tga, the start page's settings decoration: the
# graveyard gate in the Ruins of Lordaeron (lordaeron-gate.webp), turned into
# ink lines that fade out from the bottom right corner. The ink is white; the
# page tints it brown (ForeverWindow.lua, START.decor).
#   python3 _Dev/art/engrave-lordaeron.py <dir with PIL, or ""> _Dev/art/lordaeron-gate.webp Art/Decor/lordaeron.tga
import sys, math, random
if sys.argv[1]: sys.path.insert(0, sys.argv[1])
from PIL import Image, ImageFilter, ImageOps, ImageChops, ImageMath
SRC, OUT, W = sys.argv[2], sys.argv[3], 512
CROP = (470, 0, 1000, 493)     # the gate, its fence and the spire behind it
BLUR, LO, HI = 4, 22, 90       # the pencil's width; ink below LO is dropped, above HI full

# A pencil sketch (a colour dodge of the picture by its blurred negative):
# flat areas go blank and edges dark. Its darkness is the ink.
g = ImageOps.autocontrast(Image.open(SRC).convert("RGB").crop(CROP).convert("L"), cutoff=1)
inv = ImageOps.invert(g).filter(ImageFilter.GaussianBlur(BLUR))
sketch = ImageMath.lambda_eval(lambda a: a["min"](a["g"] * 255 / (256 - a["inv"]), 255), g=g.convert("F"), inv=inv.convert("F"))
ink = sketch.point(lambda v: 255 - v).convert("L")
ink = ink.point(lambda v: 0 if v < LO else 255 if v > HI else int((v - LO) / (HI - LO) * 255))

# Fades out from the bottom right corner, along a ragged edge.
w, h = ink.size
fade = Image.new("L", (w, h)); px = fade.load()
for y in range(h):
    for x in range(w):
        dx, dy = (w - x) / w, (h - y) / h
        t = (math.sqrt(dx * dx * 0.9 + dy * dy * 1.1) - 0.74) / 0.36
        px[x, y] = 255 if t <= 0 else 0 if t >= 1 else int(255 * (1 - t * t * (3 - 2 * t)))
rnd = random.Random(3)
noise = Image.new("L", (w // 8, h // 8)); noise.putdata([int(rnd.gauss(128, 64)) for _ in range((w // 8) * (h // 8))])
noise = noise.resize((w, h), Image.BICUBIC).filter(ImageFilter.GaussianBlur(6))
fade = ImageChops.multiply(fade, noise.point(lambda v: min(255, int(v * 1.25 + 40)))).filter(ImageFilter.GaussianBlur(4))
ink = ImageChops.multiply(ink, fade)

# 512 wide, at the bottom of a 512 x 512 texture.
ink = ink.resize((W, round(W * h / w)), Image.LANCZOS)
canvas = Image.new("L", (W, W)); canvas.paste(ink, (0, W - ink.size[1]))
# White ink in a 32-bit TGA, its first row at the top, as the other art here.
with open(OUT, "wb") as f:
    f.write(bytes([0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, W & 255, W >> 8, W & 255, W >> 8, 32, 40]))
    f.write(b"".join(bytes([255, 255, 255, a]) for a in canvas.tobytes()))
print("saved", OUT)
