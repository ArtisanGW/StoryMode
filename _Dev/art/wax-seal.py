# Makes Art/Decor/wax_seal.tga, the seal under the start page's letter
# (ForeverWindow.lua): red wax, a little dirty, catching a warm light,
# pressed by hand with the Story Mode rune, spread thin at its edge, with
# drops and specks around it.
# The rune comes out of the avatar icon (darker than the parchment around it).
# The wax is a height map (the thin skirt, the dome, the rim the stamp pushed
# up, its flat face, the rune pressed in, lumps and a paper-like grain) lit
# from the top left (see Light below), mottled and smudged, pressed into
# the paper rather than lying on it.
#   python3 _Dev/art/wax-seal.py <dir with PIL, or ""> Art/Icons/storymode_avatar.tga Art/Decor/wax_seal.tga 128
import sys, math, random
if sys.argv[1]: sys.path.insert(0, sys.argv[1])
from PIL import Image, ImageFilter, ImageDraw, ImageChops
AVATAR, OUT, SIZE = sys.argv[2], sys.argv[3], int(sys.argv[4])
N = 512
rnd = random.Random(7)
cx = cy = N / 2
R = N * 0.30

def noise(scale, seed):
    # smooth value noise, 0..255: random cells scaled up
    r = random.Random(seed)
    n = max(2, N // scale)
    im = Image.new("L", (n, n)); im.putdata([r.randrange(256) for _ in range(n * n)])
    return im.resize((N, N), Image.BICUBIC)

def fractal(seed, scales=(64, 24, 8, 3), weights=(0.45, 0.3, 0.17, 0.08)):
    acc = Image.new("F", (N, N))
    out = None
    for k, (s, w) in enumerate(zip(scales, weights)):
        layer = noise(s, seed * 10 + k).convert("F")
        out = layer.point(lambda v, w=w: v * w) if out is None else ImageChops.add(out.convert("L"), layer.point(lambda v, w=w: v * w).convert("L")).convert("F")
    return out.convert("L")

def blob_poly(rx, ry, r0, wobble, splats, seed, n=900):
    r = random.Random(seed)
    ph = [r.random() * 6.3 for _ in range(5)]
    lobes = [(r.uniform(0, 6.3), r.uniform(*splats[0]), r.uniform(*splats[1])) for _ in range(splats[2])]
    pts = []
    for i in range(n):
        t = i * 2 * math.pi / n
        k = 1 + wobble * (0.5 * math.sin(4 * t + ph[0]) + 0.35 * math.sin(7 * t + ph[1]) + 0.25 * math.sin(13 * t + ph[2]) + 0.15 * math.sin(23 * t + ph[3]))
        for a, amp, wd in lobes:
            dd = math.atan2(math.sin(t - a), math.cos(t - a))
            k += amp * math.exp(-(dd / wd) ** 2)
        pts.append((rx + r0 * k * math.cos(t), ry + r0 * k * math.sin(t)))
    return pts

def mask(polys, blur=1.2):
    m = Image.new("L", (N, N)); d = ImageDraw.Draw(m)
    for p in polys: d.polygon(p, fill=255)
    return m.filter(ImageFilter.GaussianBlur(blur))

# The wax: the pressed blob, the thin skirt it spread into, and drops around.
main = mask([blob_poly(cx, cy, R, 0.035, ((0.04, 0.12), (0.06, 0.16), 9), 1)])
skirt = mask([blob_poly(cx + 3, cy + 2, R * 1.13, 0.06, ((0.04, 0.15), (0.05, 0.12), 12), 2)], 1.0)
drops = []
for k in range(5):
    a = rnd.uniform(0, 6.3); dist = R * rnd.uniform(1.3, 1.5); rr = R * rnd.uniform(0.035, 0.085)
    drops.append(blob_poly(cx + dist * math.cos(a), cy + dist * math.sin(a), rr, 0.12, ((0.05, 0.2), (0.3, 0.6), 2), 10 + k, 120))
for k in range(6):
    a = rnd.uniform(0, 6.3); dist = R * rnd.uniform(1.25, 1.55); rr = R * rnd.uniform(0.012, 0.025)
    drops.append(blob_poly(cx + dist * math.cos(a), cy + dist * math.sin(a), rr, 0.1, ((0.0, 0.1), (0.3, 0.6), 1), 30 + k, 60))
dropm = mask(drops, 0.8)
alpha = ImageChops.lighter(ImageChops.lighter(main, skirt), dropm)

# The rune, cropped to itself and a little bolder.
av = Image.open(AVATAR).convert("L")
bg = av.filter(ImageFilter.MaxFilter(15)).filter(ImageFilter.GaussianBlur(12))
rune = ImageChops.subtract(bg, av).point(lambda d: max(0, min(255, int((d - 45) * 4))))
rune = rune.filter(ImageFilter.MedianFilter(5)).point(lambda v: 255 if v > 70 else 0)
rune = rune.crop(rune.getbbox()).filter(ImageFilter.MaxFilter(7)).filter(ImageFilter.GaussianBlur(1.2))
Rs = R * 0.74
rh = Rs * 1.56; rw = rh * rune.size[0] / rune.size[1]
runeimg = Image.new("L", (N, N)); runeimg.paste(rune.resize((int(rw), int(rh)), Image.LANCZOS), (int(cx - rw / 2 + 3), int(cy - rh / 2)))
# The stamp went in by hand: its outline wobbles, a little oval and off
# centre, and the rim it pushed up is high on one side and almost flat on
# another.
def disc(r, soft, seed, wob, squash=0.95, dx=-2.0, dy=1.5):
    pts = [(cx + dx + (x - cx) * 1.0, cy + dy + (y - cy) * squash) for x, y in blob_poly(cx, cy, r, wob, ((0.0, 0.025), (0.3, 0.7), 3), seed, 400)]
    m = Image.new("L", (N, N)); ImageDraw.Draw(m).polygon(pts, fill=255)
    return m.filter(ImageFilter.GaussianBlur(soft))
face = disc(Rs, 3, 41, 0.022)
rim = ImageChops.subtract(disc(Rs + R * 0.09, 7, 42, 0.05, 0.93, 0.0, 2.5), disc(Rs - R * 0.02, 4, 41, 0.022))
rimvar = Image.new("L", (N, N)); rv = rimvar.load()
rr = random.Random(43); rph = [rr.random() * 6.3 for _ in range(3)]
for y in range(N):
    for x in range(N):
        t = math.atan2(y - cy, x - cx)
        rv[x, y] = int(255 * max(0.15, min(1, 0.62 + 0.3 * math.sin(t + rph[0]) + 0.18 * math.sin(3 * t + rph[1]) + 0.1 * math.sin(5 * t + rph[2]))))
rim = ImageChops.multiply(rim, rimvar)
dome = main.filter(ImageFilter.GaussianBlur(R * 0.2))
dropdome = dropm.filter(ImageFilter.GaussianBlur(3))
skirtsoft = skirt.filter(ImageFilter.GaussianBlur(4))
bumps = fractal(5, (40, 14, 5), (0.5, 0.33, 0.17))          # the wax's own lumps
grain = fractal(9, (6, 2), (0.6, 0.4))                      # fine grain, like the paper's
mottle = fractal(3, (90, 30, 10), (0.5, 0.3, 0.2))          # darker and lighter patches

H = Image.new("F", (N, N)); hp = H.load()
dp, fp, rp, up, sp, ddp, bp, gp = dome.load(), face.load(), rim.load(), runeimg.load(), skirtsoft.load(), dropdome.load(), bumps.load(), grain.load()
for y in range(N):
    for x in range(N):
        f = fp[x, y] / 255
        tilt = 0.74 + 0.035 * (x - cx) / Rs - 0.02 * (y - cy) / Rs   # pressed deeper on one side
        h = sp[x, y] / 255 * 0.16 + max(dp[x, y] / 255 * 0.95 * (1 - f) + f * tilt, 0) * (dp[x, y] > 8) + ddp[x, y] / 255 * 0.22
        h += rp[x, y] / 255 * 0.2 - up[x, y] / 255 * 0.22
        h += ((bp[x, y] - 128) / 255 * 0.05 + (gp[x, y] - 128) / 255 * 0.006) * (1 - f * 0.75)
        hp[x, y] = h

# ── Light ─────────────────────────────────────────────────────────────────
# As a wax seal is drawn in a photo editor (a soft bevel, an inner shadow,
# warm highlights, a contact shadow and a soft one under it) but worked out
# from the height map: shadows traced toward the light (parallax occlusion
# mapping's self-shadowing, soft where a ray only grazes), ambient occlusion
# in the hollows, and wax's translucency: thin wax glows brighter and redder,
# thick wax goes deep, and light wraps a little round its curves.
ap, mp = alpha.load(), mottle.load()
TH = R * 0.20                          # the wax's thickness in pixels at height 1: low, pressed flat
AZ = math.radians(225)                 # the light comes from the top left...
EL = math.radians(36)                  # ...36 degrees above the paper
ldx, ldy = math.cos(AZ), math.sin(AZ)  # toward the light, on the page (y down)
lx, ly, lz = ldx * math.cos(EL), ldy * math.cos(EL), math.sin(EL)
hx, hy, hz = lx, ly, lz + 1; hl = math.sqrt(hx * hx + hy * hy + hz * hz); hx, hy, hz = hx / hl, hy / hl, hz / hl
TAN = math.tan(EL)
def hpx(x, y):
    x = 0 if x < 0 else N - 1 if x >= N else int(x)
    y = 0 if y < 0 else N - 1 if y >= N else int(y)
    return hp[x, y] * TH
HMAX = max(hp[x, y] for y in range(0, N, 4) for x in range(0, N, 4)) * TH

# Soft shadows, traced at half size: march toward the light; a ray that
# passes under the wax is in shadow, one that grazes it is half lit.
half = N // 2
shade_small = Image.new("L", (half, half)); sp_ = shade_small.load()
for y in range(half):
    for x in range(half):
        X, Y = x * 2, y * 2
        h0 = hpx(X, Y)
        if h0 <= 0.01 and ap[X, Y] == 0:
            sp_[x, y] = 255; continue
        res, d = 1.0, 1.5
        while d < 90:
            rayh = h0 + d * TAN
            if rayh > HMAX: break
            th = hpx(X + ldx * d, Y + ldy * d)
            if th >= rayh:
                res = 0.0; break
            res = min(res, 5.0 * (rayh - th) / d)
            d += 1.5
        sp_[x, y] = int(255 * max(0.0, res))
selfshadow = shade_small.resize((N, N), Image.BICUBIC).filter(ImageFilter.GaussianBlur(1.2))

# Ambient occlusion: how far a point sits below the wax around it.
hl8 = Image.new("L", (N, N)); h8 = hl8.load()
for y in range(N):
    for x in range(N):
        h8[x, y] = max(0, min(255, int(hp[x, y] * 180)))
near, far = hl8.filter(ImageFilter.GaussianBlur(5)), hl8.filter(ImageFilter.GaussianBlur(16))
np_, fp_ = near.load(), far.load()

out = Image.new("RGBA", (N, N), (0, 0, 0, 0)); op = out.load()
shp = selfshadow.load()
THIN, THICK = (158, 38, 30), (86, 16, 14)      # wax lit through, and deep wax
WARM = (240, 200, 160)                         # the light's colour: warm, not white
for y in range(1, N - 1):
    for x in range(1, N - 1):
        a = ap[x, y]
        if a == 0: continue
        dx = (hp[x + 1, y] - hp[x - 1, y]) * TH / 2; dy = (hp[x, y + 1] - hp[x, y - 1]) * TH / 2
        nl = math.sqrt(dx * dx + dy * dy + 1); nx, ny, nz = -dx / nl, -dy / nl, 1 / nl
        ndl = nx * lx + ny * ly + nz * lz
        wrap = max(0.0, (ndl + 0.35) / 1.35)                  # light wrapping round the wax
        sh = shp[x, y] / 255
        ao = 1 - min(0.55, max(0, (np_[x, y] - h8[x, y]) / 255 * 3.2 + (fp_[x, y] - h8[x, y]) / 255 * 1.2))
        thick = min(1.0, hp[x, y] / 0.95)
        t = thick * thick * (3 - 2 * thick)
        col = [THIN[i] * (1 - t) + THICK[i] * t for i in range(3)]
        rune_in = up[x, y] / 255
        col = [col[i] * (1 - rune_in * 0.25) for i in range(3)]
        m = 0.86 + (mp[x, y] / 255) * 0.24 + (gp[x, y] - 128) / 255 * (0.14 - 0.08 * fp[x, y] / 255)
        light = (0.30 * ao + 0.95 * wrap * (0.25 + 0.75 * sh) * (0.6 + 0.4 * ao)) * m
        nh = max(0.0, nx * hx + ny * hy + nz * hz)
        rough = mp[x, y] / 255                                  # dull patches break the highlights up
        spec = (nh ** 10 * 0.12 + nh ** 70 * (0.6 if rough > 0.45 else 0.18)) * sh * 255
        alpha_px = int(a * (0.72 + 0.28 * min(1.0, thick * 2.5)))  # thin wax lets the paper through
        op[x, y] = tuple(max(0, min(255, int(col[i] * light * 1.25 + spec * WARM[i] / 255))) for i in range(3)) + (alpha_px,)

# dirt: a few darker smudges and specks in the wax
dirt = fractal(17, (20, 6), (0.6, 0.4)).point(lambda v: 255 if v > 168 else 0).filter(ImageFilter.GaussianBlur(1.5))
dl = Image.new("RGBA", (N, N), (40, 8, 6, 0)); dl.putalpha(ImageChops.multiply(dirt.point(lambda v: int(v * 0.3)), alpha))
out.alpha_composite(dl)

# Pressed into the paper, not lying on it: no shadow thrown away from it,
# only the paper darkened right where the wax meets it, and a faint grease
# stain the warm wax left around itself.
def on_paper(color, blur, grow, strength):
    m = alpha.filter(ImageFilter.MaxFilter(grow)) if grow > 1 else alpha
    m = m.filter(ImageFilter.GaussianBlur(blur)).point(lambda v: int(v * strength))
    layer = Image.new("RGBA", (N, N), color + (0,)); layer.putalpha(m)
    return layer
canvas = Image.new("RGBA", (N, N), (0, 0, 0, 0))
canvas.alpha_composite(on_paper((92, 54, 22), 10, 9, 0.16))      # the grease stain
canvas.alpha_composite(on_paper((40, 16, 6), 2.5, 3, 0.5), (1, 2))   # the contact shadow
canvas.alpha_composite(out)
canvas = canvas.resize((SIZE, SIZE), Image.LANCZOS)
if OUT.endswith(".tga"):
    W = SIZE
    r, g, b, a = canvas.split()
    with open(OUT, "wb") as f:
        f.write(bytes([0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, W & 255, W >> 8, W & 255, W >> 8, 32, 40]))
        f.write(Image.merge("RGBA", (b, g, r, a)).tobytes())
else:
    canvas.save(OUT)
print("saved", OUT)
