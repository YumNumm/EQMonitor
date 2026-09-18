# Task 8: map label rendering research

## 1. Design of record

`docs/superpowers/specs/2026-08-02-eqmonitor-map-renderer-design.md` already makes labels a first-class renderer concern, not a MapLibre-style source/style compatibility feature.

Binding requirements:

> ラベルは事前計算済みアンカーを使い、Flutterの`TextPainter`で描画する。

> ラベルの地理anchorはPMTiles生成時に専用Pointレイヤーへ1点だけ格納する。表示位置候補はrendererが実測文字サイズとDPRからscreen上に生成する。

> labelとleader lineは常に`labelForeground` phaseへ解決し、collision用priorityとは別にこのkeyを持つ。geometry、icon、採用済みlabelのhit testは同じkeyの降順、すなわち画面上側から走査する。

> PMTilesの専用Pointレイヤーは、Feature geometryとして1つの地理anchor、安定ID、文字列、優先度、zoom範囲を持つ。alternate geographic anchorやleader line属性はMVTへ持たせない。

> 表示対象tileから候補を収集し、source/layer/安定ID/world wrapで重複を解決した後、地理anchorをscreen座標へ投影する。rendererは`TextPainter`の実測boundsとDPRからright、left、up、downのscreen placement candidateを生成する。

> 候補は優先度、phase内layer order、stable ID、screen placement orderの決定的collision keyで配置し、画面端補正を行う。採用後のlabelとleader lineは`labelForeground`のcanonical `RenderSortKey`だけで描画・hit testする。

> 既定のright以外へ退避したlabelのleader line要否、長さ、stroke、描画閾値はversion付きrenderer policyで決め、asset schemaへは含めない。

> `TextPainter`は文字列、text direction、locale、font family/fallback/load generation、weight/features、letter/word spacing、height、color、`TextScaler`、width、max lines、ellipsis、theme generation、DPRを完全なkeyとして、byte/count上限付きLRUでcacheする。

> カメラ移動時は原則再layoutせず、screen位置とcollisionだけを更新する。

> 直前frameの配置へ限定的なhysteresisを与えてzoom境界のちらつきを抑えるが、priority変更を上書きしない。

> 採用ラベルはFlutter Scene前景の`CustomPainter`で画面正立に描画する。

> 装飾labelと操作・防災上重要なlabelを分類し、後者は`semanticsBuilder`または対応する`Semantics` surfaceで読み上げ、focus、activateを提供する。

Hit testing binding:

> visibility、min/max zoom、filter、fill hole、描画時のline/icon/label boundsを先に解決し、実際に描画したgeometryとscreen-space widthで判定する。

Initial test requirements include:

> ラベル重複排除、決定的優先順、right/left/up/down screen placement、衝突、leader line policy、hysteresis、cache invalidation、semantics

What the design leaves open:

- Product text policy: station name, intensity value, both, or mode-dependent text.
- Density policy for Kyoshin Monitor's roughly thousand-station point set: label min zoom, max label count, viewport culling, priority, and whether low-intensity stations are label-eligible.
- Label priority definitions for observation stations and JMA regions.
- Exact leader line style and threshold.
- Whether observation point labels and region labels are hit-testable/semantic, or decorative only.
- Whether region intensity "icons" should be actual badges anchored at region centers, or whether current polygon fill + separate region name label remains the parity target.

`packages/eqmonitor_map/lib/src/flutter_scene/spike_label_painter.dart` proves only the TextPainter overlay path: it projects one geographic anchor through a matrix, measures text, and centers the text on the anchor. `packages/eqmonitor_map/test/flutter_scene/spike_label_painter_test.dart` verifies the measured centering. It does not implement candidate placement, collision, leader lines, cache keys, or hit testing.

## 2. Current EQMonitor MapLibre behavior

### Kyoshin Monitor observation points

Files checked:

- `app/lib/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart`
- `app/lib/feature/home/data/provider/kyoshin_monitor_points_provider.dart`
- `packages/kyoshin_monitor_image_parser/lib/src/worker/kyoshin_monitor_analyzer_isolate.dart`
- `app/lib/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart`

Current visual behavior:

- The Home map draws observation points as a single `CircleStyleLayer`, not labels.
- Source: GeoJSON source `kyoshin-monitor-observations`.
- Layer: `kyoshin-monitor-circles`.
- Text: no observation-point text is rendered today.
- Available GeoJSON properties include `color`, `intensity`, and `name`. The worker writes `properties.name` from `NamedObservationPoint.name`, so station names are available for a future label layer.
- Marker size: `circle-radius` interpolates by zoom from `1` at zoom 3 to `10` at zoom 10. The user-configured marker size currently affects stroke width through `radiusScaleFactor`, but the circle radius expression itself is not multiplied by it in the checked code.
- Stroke: `circle-stroke-color` is `#808080`; stroke width interpolates from `0.2 * radiusScaleFactor` at zoom 3 to `radiusScaleFactor` at zoom 10.
- Collision: no collision for circles. MapLibre circle layers draw all visible features.
- Zoom visibility: no `minZoom`/`maxZoom` on the layer. Visibility is controlled by `useKmoni`, source updates, viewport clipping inside MapLibre, and `homeConfiguration.kyoshinMonitor.minRealtimeShindo`.
- Light/dark theming: the circle fill color comes from the parsed Kyoshin Monitor image pixel (`properties.color`); stroke is fixed gray. No explicit light/dark adjustment was found.
- Density: all successfully parsed, filter-eligible stations are pushed to GeoJSON. The code does not pre-cull labels because no labels exist yet.

### Current map label layer

Files checked:

- `app/lib/feature/home/ui/component/map/layer/home_map_label_layer.dart`
- `app/lib/feature/home/data/model/home_map_label_parameter.dart`
- `app/lib/feature/home/ui/component/map/modal/home_map_label_debug_modal.dart`

Current visual behavior:

- The Home map has a debug-configurable MapLibre `SymbolStyleLayer` for region and city labels.
- Defaults are disabled: `showRegionLabel = false`, `showCityLabel = false`.
- Region label:
  - Source: `eqmonitor_map`
  - Source layer: `areaForecastLocalE`
  - Text: `['get', 'name']`
  - `minZoom`: default `5.0`
  - Font: `Noto Sans CJK JP Bold`
  - Size: default `14`
- City label:
  - Source layer: `areaInformationCityQuake`
  - Text: `['get', 'name']`
  - `minZoom`: default `9.0`
  - Font: `Noto Sans CJK JP Regular`
  - Size: default `12`
- Collision:
  - `text-allow-overlap: false`
  - `text-ignore-placement: false`
  - Therefore MapLibre places labels through its SymbolLayer collision system.
- Paint:
  - `text-color: #ffffff`
  - `text-halo-color: #000000`
  - `text-halo-width`: default `1.0`
- Light/dark theming: label paint is hardcoded white with black halo in both themes.
- Leader lines: none.
- Hit testing: no explicit app-level hit test for these labels was found.

### Per-region intensity icons / badges

Files checked:

- `app/lib/feature/home/ui/component/map/layer/eew_estimated_intensity_layer.dart`
- `app/lib/feature/home/ui/component/map/layer/eew_warning_regions_layer.dart`
- broader searches for `IntensityIcon`, `SymbolStyleLayer`, `icon-image`, `areaForecastLocalE`, and `badge`

Current Home map behavior:

- I did not find a Home MapLibre implementation that draws per-region intensity badges/icons.
- EEW estimated intensity is drawn as filled polygons on `areaForecastLocalE`, grouped by max intensity per region.
- Fill color comes from `activeColorSetProvider.estimatedIntensity`.
- Fill opacity is `1`.
- Layers are inserted below `BaseLayer.areaForecastLocalELine`.
- No text label, icon image, badge, or collision behavior exists for per-region intensity in Home.

Related but not the same parity target:

- `app/lib/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart` draws station intensity icons and optional station labels. It uses station GeoJSON, not per-region icons.
- Its label layer uses station `name`, `text-size: 10`, `text-offset: [0, 1.2]`, `text-anchor: top`, `text-allow-overlap: false`, `text-ignore-placement: true`, white text with black halo. Because `text-ignore-placement` is true, labels avoid existing collision boxes but do not reserve space for later symbols in MapLibre terminology.

## 3. KEVi approach

Reference clone:

- Repository: `ingen084/KyoshinEewViewerIngen`
- Path: `/tmp/refs/kevi`
- Checked commit: `3e9d6a01f62e754c9c6da4a413330c4cfcb4afab`
- Existing knowledge doc also records earlier pinned commit `5a2bf513b6b9c93ee06473f70b6d27ee96070b3f`; the files below have the same relevant label structure in the current clone.

### Shared label renderer

File: `/tmp/refs/kevi/src/KyoshinEewViewer.CustomControl/MapLayerLabelRenderer.cs`

Short excerpts:

```csharp
public const float LabelPadding = 4;
public const float LabelLineHeight = 15;
private const float LeaderLineMinLength = 1.5f;

public static SKFont LabelFont { get; } = new(KyoshinEewViewerFonts.MainRegular, 13)
```

```csharp
public static SKRect[] BuildDirectionalCandidates(SKPoint center, float width, float height, float rightOffset, float otherOffset)
	=>
	[
		SKRect.Create(center.X + rightOffset, center.Y - height / 2, width, height),
		SKRect.Create(center.X - otherOffset - width, center.Y - height / 2, width, height),
		SKRect.Create(center.X - width / 2, center.Y - otherOffset - height, width, height),
		SKRect.Create(center.X - width / 2, center.Y + otherOffset, width, height),
	];
```

```csharp
public static (SKPoint Start, SKPoint End)? ComputeLeaderLine(SKPoint center, SKRect rect, float startOffset = 0)
{
	var end = new SKPoint(
		Math.Clamp(center.X, rect.Left, rect.Right),
		Math.Clamp(center.Y, rect.Top, rect.Bottom));
	// ...
	if (length - startOffset < LeaderLineMinLength)
		return null;
	// ...
}
```

Interpretation:

- KEVi uses one screen-space marker center and generates four candidates in order: right, left, up, down.
- It measures text using Skia font metrics and padding.
- It draws labels with stroke + fill for contrast.
- Leader lines are renderer policy, not data attributes.
- Leader line endpoint is the closest point on the label rectangle to the marker center.

### Observation point rendering

File: `/tmp/refs/kevi/src/KyoshinEewViewer/Series/KyoshinMonitor/KyoshinMonitorLayer.cs`

Short excerpts:

```csharp
private readonly PointLayoutCache<RealtimeObservationPoint> _pointLayoutCache = new(p => p.Location);
```

```csharp
var pixels = _pointLayoutCache.Get(points, zoom).Pixels;
var circleSize = (float)(Math.Max(1, zoom - 4) * 1.75);
```

```csharp
if (point.LatestIntensity != null && point.LatestIntensity < Config.RawIntensityObject.MinShownIntensity)
	continue;
```

```csharp
var ordersRenderedPoints = renderedPoints.OrderByDescending(p => p.Point.LatestIntensity ?? -1000);
```

Observation labels in this file are guarded by `#if DEBUG`:

```csharp
// 観測点名の描画
if (zoom >= Config.RawIntensityObject.ShowNameZoomLevel)
	foreach (var (point, pixelCenter) in ordersRenderedPoints)
```

```csharp
// デフォルトでは右側に
// 文字の被りチェック
if (fixedRect.Any(r => r.IntersectsWith(bound)))
{
	// 左側での描画を試す
	// 上側での描画を試す
	// 下側での描画を試す
	if (fixedRect.Any(r => r.IntersectsWith(bound)))
		continue;
}
```

Interpretation:

- Production KEVi observation points are dense circles, not always-labelled stations.
- Observation point labels exist as debug drawing, gated by zoom and minimum intensity.
- Placement is greedy: higher intensity first, right/left/up/down fallback, skip if all collide.
- Collision list includes marker bounds and accepted label bounds.
- A simple line is drawn from label to marker in debug label mode.
- KEVi explicitly culls points to the pixel viewport before drawing.

### Region/city/station intensity icons and labels

File: `/tmp/refs/kevi/src/KyoshinEewViewer/Series/Earthquake/EarthquakeLayer.cs`

Short excerpts:

```csharp
/// 震度アイコンの点集合。Pointsは震度昇順(=描画順)、LabelOrderは震度降順(=ラベルの場所取り優先順)の添字列
private sealed record IntensityPointSet(IntensityPoint[] Points, int[] LabelOrder);
```

```csharp
private static (IntensityPointSet? Items, bool RenderItemName, bool UseRoundIcon) SelectRenderItems(PointData data, double zoom, bool isAnimating)
{
	if (zoom >= 10 && data.Stations != null)
		return (data.Stations, !isAnimating, true);
	if (zoom >= 8.5 && data.Cities != null)
		return (data.Cities, !isAnimating && zoom >= 9.5, false);
	if (data.Areas == null && data.Cities == null)
		return (data.Stations, !isAnimating && zoom >= 10, true);
	return (data.Areas ?? data.Cities, !isAnimating && zoom >= 7.5, false);
}
```

```csharp
// 震度昇順に並んでいるため、高い震度のアイコンが上に重なる
FixedObjectRenderer.DrawIntensity(
	canvas,
	points[i].Intensity,
	pointCenter.AsSkPoint(),
	(float)(circleSize * 2),
	true,
	useRoundIcon,
	false,
	true,
	true);
```

```csharp
foreach (var i in set.LabelOrder)
{
	// ...
	string[] lines = [points[i].Name];
	var (width, height) = MapLayerLabelRenderer.MeasureLines(lines);
	var candidates = MapLayerLabelRenderer.BuildDirectionalCandidates(center, width, height, circleSize + MarkerGap, circleSize + OffsetLabelGap);
	for (var c = 0; c < candidates.Length; c++)
	{
		if (!placedRects.TrueForAll(p => !p.IntersectsWith(rect)))
			continue;
		placements[i] = new LabelPlacement(lines, rect,
			c == 0 ? null : MapLayerLabelRenderer.ComputeLeaderLine(center, rect, circleSize));
		placedRects.Add(rect);
		break;
	}
}
```

Interpretation:

- KEVi has the closest analogue for per-region intensity icons.
- It converts regions/cities/stations into center-point intensity icons.
- Drawing order is intensity ascending so higher intensity appears on top.
- Label placement priority is intensity descending.
- Zoom controls both data granularity and label visibility:
  - area labels: `zoom >= 7.5`, except while animating
  - city labels: item switch at `zoom >= 8.5`, labels at `zoom >= 9.5`, except while animating
  - station icons: `zoom >= 10`, labels at `zoom >= 10`, except while animating
- Labels are station/area/city names only; hover tooltip adds intensity text.
- Collision is greedy O(N * accepted labels) over visible items. No spatial index for label rectangles.
- Leader lines are drawn only when the label is not in the default right candidate.
- Hit testing checks nearest icon first, then label rectangles if the render-time layout cache matches source and zoom.

Intensity badge drawing:

File: `/tmp/refs/kevi/src/KyoshinEewViewer.CustomControl/FixedObjectRenderer.cs`

```csharp
public static void DrawIntensity(this SKCanvas canvas, JmaIntensity intensity, SKPoint point, float size, bool centerPosition = false, bool circle = false, bool wide = false, bool round = false, bool border = false)
```

- The same renderer draws rectangular, rounded, or circular badges.
- Color paints are cached from the active intensity theme.
- Text is hand-positioned per JMA intensity class, including `5弱/5強/6弱/6強`.

### Point layout and density support

Files:

- `/tmp/refs/kevi/src/KyoshinEewViewer.Map/Layers/PointLayoutCache.cs`
- `/tmp/refs/kevi/src/KyoshinEewViewer.Map/Layers/NormalizedPointSet.cs`
- `/tmp/refs/kevi/src/KyoshinEewViewer.Map/Layers/PointLayout.cs`

Short excerpts:

```csharp
// 1段目: 元配列の参照単位で、ズーム非依存の正規化座標(投影結果)と空間インデックスを保持する
// 2段目: (元配列, ズーム)単位で、絶対ピクセル座標を保持する
```

```csharp
private const int GridPointCountThreshold = 200;
```

```csharp
// 1セルあたり平均1点程度を目安にセルを分割する。
var cells = (int)Math.Ceiling(Math.Sqrt(validCount));
```

Interpretation:

- KEVi separates projection cache from zoom scale.
- For point hit testing it uses a uniform grid once point count reaches 200.
- This maps well to EQMonitor's dense Kyoshin station problem, especially for culling and hit testing. It does not directly solve label rectangle collision.

## 4. MapLibre symbol placement/collision summary

References checked:

- `docs/knowledge/20260805_maplibre_native_renderer_reference.md`
- `maplibre/maplibre-native` commit `f1905c521577f009c70179fac53e3f4f67a3fa53`
- `src/mbgl/renderer/buckets/symbol_bucket.cpp`
- `src/mbgl/renderer/buckets/symbol_bucket.hpp`
- `src/mbgl/text/placement.cpp`
- `src/mbgl/text/collision_index.cpp`
- `src/mbgl/text/cross_tile_symbol_index.cpp`

MapLibre's architecture:

- Layout/precompute phase builds `SymbolBucket`.
  - Stores `SymbolInstance`s, placed glyph/icon quads, collision features, size binders, sort key ranges.
  - For point symbols, collision boxes are generated in tile units around the symbol anchor and its text/icon dimensions.
  - For line labels, collision features may be multiple circles along the line.
  - Vertices are mostly static; placement results update dynamic vertices and opacity vertices.
- Cross-tile indexing assigns stable `crossTileID`s to matching symbols across parent/child/neighboring tiles.
  - Matching uses symbol key plus scaled anchor coordinates rounded to a roughly 4 px grid.
  - This prevents flicker and allows opacity continuity while zooming/panning.
- Placement phase runs over render layers in reverse render order, then buckets, then symbols.
  - `Placement::placeLayers` iterates layers from foreground toward background.
  - Collision grid is populated as symbols are accepted.
  - Later/lower-priority symbols see earlier accepted boxes.
- Collision index:
  - Creates a grid covering viewport plus padding (`100 px`, doubled for pitched views; static tile mode uses larger padding).
  - Point label collision projects the anchor to screen, scales tile-unit collision box to viewport pixels, and tests the rectangle against grid boxes.
  - If `allowOverlap` is false and the grid hit-tests, placement fails.
  - If placement succeeds, accepted boxes are inserted unless `ignorePlacement` directs them to an ignored grid.
  - `avoidEdges` can reject boxes crossing tile boundaries.
  - Query-rendered-symbols reuses both collision and ignored grids, with polygon/box intersection.
- Variable anchors:
  - `text-variable-anchor` produces a list of candidate anchors.
  - If previous placement used one of those anchors, it is moved to the front to reduce flicker.
  - Candidate shift is calculated from anchor alignment, text box width/height, text offset, text box scale, and bearing when map-rotated.
  - Each candidate is tried in order; with `text-allow-overlap`, MapLibre may make a second pass allowing overlap.
  - For `icon-text-fit`, icon collision can be shifted together with the chosen variable text anchor.
- Icon/text coupling:
  - If icon and text are not optional, both must place.
  - If one is optional, the other may place independently according to layout flags.
- Fading:
  - `JointOpacityState` tracks icon and text opacity separately.
  - Current placement copies previous opacity by `crossTileID`, increments toward visible when placed and toward hidden when unplaced.
  - Previous placement entries not in the current placement are retained until opacity reaches zero.
  - `fadeStartTime` updates only when placement changes.
- Per-frame vs precomputed:
  - Precomputed: glyph shaping/quads, icon quads, collision boxes/circles in tile units, symbol instances, sort ranges, cross-tile keys.
  - Per placement update: project anchors/boxes to viewport, resolve variable anchors, run collision grid, update placement/opacity/dynamic vertices.
  - Per render frame during transitions: update opacities and dynamic render shifts; not full glyph layout.

Simplified reimplementation takeaways for EQMonitor:

- We do not need MapLibre's glyph atlas, line labels, pitch/bearing, vertical writing, or icon-text-fit for the initial label work.
- We do need:
  - deterministic ordering;
  - viewport-plus-padding collision space;
  - stable feature IDs;
  - previous-placement hysteresis;
  - rectangle collision and screen-edge clamping;
  - separate "can overlap" and "reserves collision space" concepts if parity with `allow-overlap`/`ignore-placement` matters.
- A flat grid spatial index for accepted label rectangles is enough for dense point labels. It avoids O(N^2) behavior when hundreds of candidates are visible.

## 5. dashmap confirmation

`/home/yumnumm/EQMonitor/.superpowers/sdd/2026-08-07-flutter-scene-map-status/task-5-dashmap-report.md` already confirms:

> 地図ラベルの描画はありません。確認した範囲では text は HUD、settings panel、search panel、attribution、error card など Flutter UI overlay だけです。GPU text も `TextPainter` による map label overlay もありません。

I did not re-investigate dashmap. It has no label placement/collision implementation to adopt.

## 6. Candidate approaches for EQMonitor

### A. Design-of-record full approach

Summary:

- Dedicated PMTiles Point label layers, exactly one geographic anchor per label.
- Runtime TextPainter measurement.
- Runtime right/left/up/down candidates.
- Deterministic collision key: priority, layer order, stable ID, candidate order.
- Collision index over screen rectangles.
- Optional leader lines in `labelForeground`.
- Hysteresis and TextPainter LRU.

Gives:

- Matches the renderer design.
- Works for both static base labels and dynamic hazard labels.
- Handles dense Kyoshin station labels without data-side alternate anchors.
- Can provide stable hit testing and semantics.
- Leaves PMTiles schema clean: data owns text/anchor/priority/zoom range; renderer owns placement policy.

Costs:

- Requires data contracts for observation-station label anchors and region-intensity label anchors.
- Requires collision index, layout cache, invalidation, hysteresis, and tests.
- Requires product policy before priority and zoom rules can be finalized.

Risks:

- Dense Kyoshin labels can still be expensive if every visible station is measured and tested every frame.
- Without a max candidate/label budget, label placement can become a frame-time spike while panning.
- Hysteresis can accidentally preserve labels that product expects to disappear unless priority override rules are strict.

Density controls needed:

- Pre-filter by layer zoom range and viewport plus padding before measuring.
- Reuse text layout by station name/style.
- Use projected point grid to enumerate visible stations.
- Use a rectangle collision grid for accepted labels.
- Set per-layer `maxCandidatesPerFrame` or `maxAdoptedLabels` policy.
- Prioritize station labels by intensity, selected/hovered state, warning relevance, and then stable ID.

### B. Simpler priority-ordered greedy placement

Summary:

- Use the design's one-anchor PMTiles/source contract.
- Generate right/left/up/down candidates.
- Sort labels by priority and stable ID.
- Maintain a list of accepted rectangles and test overlaps linearly, KEVi-style.
- Add a viewport cull and a hard max candidate count for Kyoshin labels.

Gives:

- Much faster to implement.
- Behavior is easy to explain and test.
- Close to KEVi's region intensity label approach.
- Good enough for region intensity icons where visible count is small to moderate.

Costs:

- O(N * accepted) collision can degrade for dense Kyoshin labels.
- Needs strict candidate caps for station labels.
- No MapLibre-style cross-tile/cross-frame opacity continuity unless added separately.

Risks:

- Label popping while panning/zooming.
- Candidate cap may hide important station labels unless priority is well designed.
- If hundreds of station labels are eligible, a linear overlap list can consume too much frame time.

Best fit:

- Initial region-intensity badge labels.
- Debug/opt-in station labels at high zoom.
- A stepping stone before adding a grid collision index.

### C. No collision, zoom/density-only control

Summary:

- Show labels only above a high zoom.
- Optionally show labels only for selected/hovered/high-intensity stations.
- Do not avoid overlaps.

Gives:

- Lowest implementation cost.
- Useful for a debug layer or tap/hover-only tooltip.
- No placement ambiguity.

Costs:

- Does not meet the design's collision and placement requirements.
- Dense Kyoshin station labels will become unreadable if many are visible.
- No leader lines and no deterministic placement policy.

Risks:

- For life-safety UI, overlapping labels can obscure important hazard information.
- Product may mistake this for a shippable label system unless clearly scoped as debug/temporary.

Best fit:

- Not recommended for shipped always-on station labels.
- Acceptable for "show only hovered/selected station name" or a developer-only debug toggle.

## 7. Recommendation

Use approach A as the target architecture, but implement it in two vertical slices:

1. Region-intensity badge labels first:
   - lower density;
   - simpler priority;
   - validates TextPainter measurement, right/left/up/down placement, leader lines, `labelForeground`, and hit testing.
2. Kyoshin station labels second:
   - add dense point culling;
   - add rectangle grid collision;
   - add product-driven priority and max label budget.

Do not ship "all station names at all zooms". The Kyoshin network is a dense label problem. Labels should be high-zoom, high-priority, selected/hovered, or capped by a deterministic policy.

## 8. Open product questions

- Should Kyoshin observation labels show station name, realtime intensity value, both, or a mode-dependent string?
- Should station labels be always visible, visible only above a high zoom, visible only for high-intensity stations, or visible only on selection/hover?
- What is the maximum number of station labels allowed on screen at once?
- How should station label priority be ordered: observed intensity, alert relevance, network type, proximity to viewport center, selected/hovered state, or stable station ID?
- Should region intensity be represented as a filled polygon only, a badge/icon at one region anchor, or both?
- For region intensity labels, should the text be region name, intensity, arrival status, or a two-line label?
- Should labels be hit-testable and exposed to semantics, or treated as decorative?
- Should leader lines be shown for all displaced labels, only for selected/hovered labels, or never?
- Should labels disappear during active pan/zoom like KEVi does for some labels, or remain stable with hysteresis?
- Are debug MapLibre labels currently considered user-facing parity, or just a debug aid?

## 9. Unknowns and checked scope

- I did not find a current Home MapLibre per-region intensity badge/icon implementation. The Home implementation checked is polygon fill only.
- I did not find current Home Kyoshin station labels. Station names are present in the Kyoshin GeoJSON properties, but no MapLibre label layer uses them today.
- I did not re-investigate dashmap, per instruction; I used the existing task-5 report.
- I did not run app tests because this task was read-only research plus a report file.
