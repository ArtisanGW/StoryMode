# Draws Art/Decor/settings_controls.tga: the start page's settings controls,
# inked by hand, 128 x 256: four 64 x 64 cells, then a 128 x 32 one.
#   top left: the check box, off (a rough double frame, empty inside)
#   top right: the check box, on (the frame filled dark brown)
#   second row, left: the check mark, a tan brush stroke
#   second row, right: the dropdown's chevron, a tan brush stroke
#   third row: an inked rectangle in white, for the switch's bar (tinted there)
#   python3 _Dev/art/settings-controls.py <dir with PIL, or ""> Art/Decor/settings_controls.tga
import sys, math, random
if sys.argv[1]: sys.path.insert(0, sys.argv[1])
from PIL import Image, ImageDraw, ImageFilter, ImageChops
OUT = sys.argv[2]
S = 8                      # drawn at 8x, scaled down
C = 64 * S
rnd = random.Random(21)
INK = (66, 36, 18)
FILL_ON = (92, 50, 28)
TAN = (232, 204, 158)

def jitter(pts, amp):
    out = []
    for i in range(len(pts) - 1):
        (x0, y0), (x1, y1) = pts[i], pts[i + 1]
        n = max(2, int(math.hypot(x1 - x0, y1 - y0) / (3 * S)))
        for k in range(n):
            t = k / n
            out.append((x0 + (x1 - x0) * t + rnd.uniform(-amp, amp), y0 + (y1 - y0) * t + rnd.uniform(-amp, amp)))
    return out

def rect(x0, y0, x1, y1):
    return [(x0, y0), (x1, y0), (x1, y1), (x0, y1), (x0, y0)]

def frame(cell, filled):
    d = ImageDraw.Draw(cell)
    m, w = 10 * S, 5 * S            # margin, outer stroke
    o = rect(m, m, C - m, C - m)
    i = rect(m + w, m + w, C - m - w, C - m - w)
    # the fill, then the outer stroke as a ragged band, then the thin inner line
    if filled:
        d.polygon(jitter(rect(m + w, m + w, C - m - w, C - m - w), 0.6 * S)[:-1], fill=FILL_ON + (255,))
    outer = jitter(o, 1.1 * S); inner = jitter(i, 0.9 * S)
    band = Image.new("L", (C, C)); bd = ImageDraw.Draw(band)
    bd.polygon(outer, fill=255); bd.polygon(inner, fill=0)
    cell.paste(INK + (255,), (0, 0), band)
    g = 2.6 * S
    d.line(jitter(rect(m + w + g, m + w + g, C - m - w - g, C - m - w - g), 0.5 * S), fill=INK + (235,), width=int(1.4 * S), joint="curve")

def brush(cell, path, w0, w1, color):
    # a stroke along path, w0 wide at its start and w1 at its end, ragged
    pts = []
    for i in range(len(path) - 1):
        (x0, y0), (x1, y1) = path[i], path[i + 1]
        n = 24
        for k in range(n + (1 if i == len(path) - 2 else 0)):
            t = k / n
            pts.append((x0 + (x1 - x0) * t, y0 + (y1 - y0) * t))
    left, right = [], []
    for j, (x, y) in enumerate(pts):
        a = pts[max(0, j - 1)]; b = pts[min(len(pts) - 1, j + 1)]
        dx, dy = b[0] - a[0], b[1] - a[1]; L = math.hypot(dx, dy) or 1
        nx, ny = -dy / L, dx / L
        t = j / (len(pts) - 1)
        wd = (w0 + (w1 - w0) * t) * (0.5 + 0.5 * math.sin(math.pi * min(1, t * 1.15 + 0.08))) / 2 + rnd.uniform(-0.25, 0.25) * S
        left.append((x + nx * wd, y + ny * wd)); right.append((x - nx * wd, y - ny * wd))
    ImageDraw.Draw(cell).polygon(left + right[::-1], fill=color + (255,))

cells = []
for filled in (False, True):
    c = Image.new("RGBA", (C, C), (0, 0, 0, 0)); frame(c, filled); cells.append(c)
check = Image.new("RGBA", (C, C), (0, 0, 0, 0))
brush(check, [(13 * S, 33 * S), (19 * S, 41 * S), (26 * S, 50 * S), (36 * S, 32 * S), (53 * S, 11 * S)], 8.5 * S, 5 * S, TAN)
cells.append(check)
chev = Image.new("RGBA", (C, C), (0, 0, 0, 0))
brush(chev, [(14 * S, 22 * S), (32 * S, 42 * S)], 7 * S, 9 * S, TAN)
brush(chev, [(31 * S, 42 * S), (50 * S, 22 * S)], 9 * S, 7 * S, TAN)
cells.append(chev)

sheet = Image.new("RGBA", (128, 256), (0, 0, 0, 0))
for k, c in enumerate(cells):
    c = c.filter(ImageFilter.GaussianBlur(0.6 * S)).resize((64, 64), Image.LANCZOS)
    sheet.paste(c, ((k % 2) * 64, (k // 2) * 64))

# The switch's bar: a plain rectangle filling its cell, its edges barely
# rough, with a little grain and a few faint streaks along it, as if inked.
# White, to be tinted.
LW, LH = 128 * S, 32 * S
line = Image.new("L", (LW, LH), 0)
ld = ImageDraw.Draw(line)
top = [(x * S, rnd.uniform(0, 1.2) * S) for x in range(0, 129, 4)]
bot = [(x * S, LH - rnd.uniform(0, 1.2) * S) for x in range(128, -1, -4)]
ld.polygon(top + bot, fill=235)
for k in range(14):
    y = rnd.uniform(3, 29) * S
    x0 = rnd.uniform(0, 90) * S; x1 = x0 + rnd.uniform(20, 70) * S
    ld.line([(x0, y), (x1, y)], fill=rnd.choice((190, 205, 255)), width=int(rnd.uniform(1.5, 3) * S))
line = line.filter(ImageFilter.GaussianBlur(0.8 * S)).resize((128, 32), Image.LANCZOS)
grain = Image.new("L", (128, 32)); grain.putdata([rnd.randrange(215, 256) for _ in range(128 * 32)])
line = ImageChops.multiply(line, grain.filter(ImageFilter.GaussianBlur(0.6)))
white = Image.new("RGBA", (128, 32), (255, 255, 255, 0)); white.putalpha(line)
sheet.paste(white, (0, 128))
if OUT.endswith(".tga"):
    W, H = sheet.size
    r, g, b, a = sheet.split()
    with open(OUT, "wb") as f:
        f.write(bytes([0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, W & 255, W >> 8, H & 255, H >> 8, 32, 40]))   # 32-bit, first row at the top
        f.write(Image.merge("RGBA", (b, g, r, a)).tobytes())                        # TGA stores BGRA
else:
    sheet.save(OUT)
print("saved", OUT)
