# /// script
# requires-python = ">=3.11"
# dependencies = ["fonttools"]
# ///
"""到達カウントダウン用フォント EQCountdown.ttf を Google Sans Code と Noto Sans JP から作る。

Live Activity のタイマー文字はシステムが描くため、文字列も字ごとの大きさもアプリからは変えられない。
フォントの文脈依存の置き換え（calt）で、システムが描く「0:08.5」を「8.5秒」に見せる。

- 分が 0 のとき「0:」と秒の十の位の 0 を幅 0 の空の字形にし、後ろに小さい「秒」を足す（1分以上は「1:15.3」）
- 小数点とその後ろの数字を小さい字形にする
- 「0:00.0」は「0秒」にする

リポジトリの根元で実行する:

    uv run utils/live_activity_fonts/build_countdown_font.py
"""
import sys
from pathlib import Path

from fontTools import subset
from fontTools.feaLib.builder import addOpenTypeFeaturesFromString
from fontTools.pens.boundsPen import BoundsPen
from fontTools.pens.transformPen import TransformPen
from fontTools.pens.ttGlyphPen import TTGlyphPen
from fontTools.ttLib import TTFont
from fontTools.varLib import instancer

ROOT = Path(__file__).resolve().parents[2]
SRC = str(ROOT / "app/assets/fonts/GoogleSansCode/GoogleSansCode[MONO,wght].ttf")
# 「秒」の字形の取得元
BYOU_SRC = str(ROOT / "app/assets/fonts/NotoSansJP/NotoSansJP-Bold.ttf")
DST = sys.argv[1] if len(sys.argv) > 1 else str(
    ROOT / "app/ios/Widget/LiveActivity/Common/EQCountdown.ttf"
)
FAMILY = "EQ Countdown"
# 小数点以下の字の大きさ（整数部に対する比）
SMALL_SCALE = 0.62
# 小さい小数点の左右に残す余白（フォント単位）
SEPARATOR_BEARING = 70
# 「秒」の全角幅（整数部の文字サイズに対する比）
BYOU_SCALE = 0.56
BYOU = 0x79D2
DIGITS = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
SEPARATORS = ["period", "comma"]
KEEP = DIGITS + SEPARATORS + ["colon", "space", "hyphen"]


def instance(weight):
    font = TTFont(SRC)
    font = instancer.instantiateVariableFont(font, {"wght": weight, "MONO": 1})
    options = subset.Options()
    options.layout_features = []
    # 著作権表示とライセンス（OFL）の記載は残す
    options.name_IDs = [0, 1, 2, 3, 4, 5, 6, 13, 14]
    options.notdef_outline = True
    options.glyph_names = True
    subsetter = subset.Subsetter(options)
    subsetter.populate(glyphs=KEEP)
    subsetter.subset(font)
    return font


font = instance(700)
# 小さい字は細く見えるため、いちばん太い字形を縮める
heavy = instance(800)
heavy_glyphs = heavy.getGlyphSet()

order = font.getGlyphOrder()
glyf, hmtx = font["glyf"], font["hmtx"]


def add_glyph(name, glyph, advance):
    order.append(name)
    glyf.glyphs[name] = glyph
    glyph.recalcBounds(glyf)
    hmtx.metrics[name] = (advance, glyph.xMin if glyph.numberOfContours else 0)


for name in DIGITS:
    pen = TTGlyphPen(None)
    heavy_glyphs[name].draw(TransformPen(pen, (SMALL_SCALE, 0, 0, SMALL_SCALE, 0, 0)))
    add_glyph(name + ".small", pen.glyph(), round(heavy["hmtx"][name][0] * SMALL_SCALE))

# 小数点は等幅のままだと左右が空きすぎるため、字形の左右に SEPARATOR_BEARING だけ残して詰める
for name in SEPARATORS:
    bounds = BoundsPen(heavy_glyphs)
    heavy_glyphs[name].draw(bounds)
    x_min, _, x_max, _ = bounds.bounds
    pen = TTGlyphPen(None)
    shift = SEPARATOR_BEARING - x_min * SMALL_SCALE
    heavy_glyphs[name].draw(TransformPen(pen, (SMALL_SCALE, 0, 0, SMALL_SCALE, shift, 0)))
    add_glyph(name + ".small", pen.glyph(), round((x_max - x_min) * SMALL_SCALE + SEPARATOR_BEARING * 2))

for name in ["zero.gone", "colon.gone", "sep.gone"]:
    add_glyph(name, TTGlyphPen(None).glyph(), 0)

byou_font = TTFont(BYOU_SRC)
byou_glyphs = byou_font.getGlyphSet()
byou_name = byou_font.getBestCmap()[BYOU]
byou_scale = font["head"].unitsPerEm / byou_font["head"].unitsPerEm * BYOU_SCALE
pen = TTGlyphPen(None)
byou_glyphs[byou_name].draw(TransformPen(pen, (byou_scale, 0, 0, byou_scale, 0, 0)))
# 文字「秒」には割り当てない。漢字を文字として渡すと、描画時にシステムの日本語フォントへ
# 差し替えられて幅が合わなくなる。置き換え規則からだけ出す
add_glyph("byou", pen.glyph(), round(byou_font["hmtx"][byou_name][0] * byou_scale))

font.setGlyphOrder(order)
glyf.glyphOrder = order

for tag in ["GSUB", "GPOS", "GDEF"]:
    if tag in font:
        del font[tag]

digits = " ".join(DIGITS)
small = " ".join(d + ".small" for d in DIGITS)
append_rules = "\n".join(f"    sub {d}.small by {d}.small byou;" for d in DIGITS)
addOpenTypeFeaturesFromString(
    font,
    f"""
languagesystem DFLT dflt;
languagesystem latn dflt;

@digit = [{digits}];
@small = [{small}];
@sep = [period comma];
@sepSmall = [period.small comma.small];

# 分が 0 のとき「0:」と秒の十の位の 0 を幅 0 の空の字形にする（0:08.5 → 8.5、0:12.4 → 12.4）
lookup dropMinutes {{
    ignore sub @digit zero' colon;
    sub zero' colon by zero.gone;
}} dropMinutes;
lookup dropColon {{
    sub zero.gone colon' by colon.gone;
}} dropColon;
lookup dropPad {{
    sub colon.gone zero' @digit by zero.gone;
}} dropPad;
# 0:00.0 は小数を出さず「0秒」にする
lookup zeroSeparator {{
    sub colon.gone zero.gone zero @sep' zero by sep.gone;
}} zeroSeparator;
lookup zeroUnit {{
    sub sep.gone zero' by byou;
}} zeroUnit;
# 小数点とその後ろの数字を小さい字形にする
lookup smallSeparator {{
    sub @sep' @digit by @sepSmall;
}} smallSeparator;
lookup smallFraction {{
    sub @sepSmall @digit' by @small;
}} smallFraction;
lookup appendUnitPairs {{
{append_rules}
}} appendUnitPairs;
# 「1:15.3秒」とは書かないため、分を消したときだけ足す
lookup appendUnit {{
    sub colon.gone [@digit zero.gone] @digit @sepSmall @small' lookup appendUnitPairs;
}} appendUnit;

feature calt {{
    lookup dropMinutes;
    lookup dropColon;
    lookup dropPad;
    lookup zeroSeparator;
    lookup zeroUnit;
    lookup smallSeparator;
    lookup smallFraction;
    lookup appendUnit;
}} calt;
""",
)

# 元の書体名は使わない。著作権表示には「秒」の取得元も足す
byou_copyright = byou_font["name"].getDebugName(0)
name = font["name"]
for record in list(name.names):
    if record.nameID == 0:
        record.string = f"{record.toUnicode()} / {byou_copyright}"
    elif record.nameID in (1, 4):
        record.string = FAMILY
    elif record.nameID == 2:
        record.string = "Regular"
    elif record.nameID == 3:
        record.string = FAMILY + " 1.0"
    elif record.nameID == 6:
        record.string = FAMILY.replace(" ", "") + "-Regular"

font.save(DST)
print("wrote", DST)
