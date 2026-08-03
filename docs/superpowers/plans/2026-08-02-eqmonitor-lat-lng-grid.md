# EQMonitor Latitude/Longitude Grid Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Pin EQMonitor to the completed YumNumm/flutter-maplibre computed-source stack and add an opt-in latitude/longitude grid to home and live-monitor maps on iOS and Android.

**Architecture:** A deterministic map-domain builder generates bounded GeoJSON from native tile bounds and integer zoom. A thin provider binds it to `ComputedGeoJsonSource`; a reusable layer widget owns source/layer lifecycle through the existing map operation queue. Grid settings are stored separately from `HomeMapSettings`, so toggling the grid rebuilds only the overlay and never changes map instance identity.

**Tech Stack:** Flutter 3.44.4, Dart 3.12, Riverpod 3 mutations, flutter_hooks, Freezed/json_serializable, MapLibre fork computed-source API, Talker, Flutter unit/widget tests.

## Global Constraints

- Pin all six MapLibre dependency overrides to one immutable commit SHA from the completed F3 fork branch; never use a mutable branch ref.
- Use only `https://github.com/YumNumm/flutter-maplibre.git`; never push to or open a PR against `maplibre/flutter-maplibre`.
- Run every Flutter/Dart command through `mise exec --`.
- The computed provider is exactly synchronous `String Function({required LngLatBounds bounds, required int zoomLevel})`.
- The grid is disabled by default and appears only on home and live-monitor maps.
- The grid is not mounted on Web or desktop, and EQMonitor has no Flutter canvas/camera-event fallback.
- The first release draws lines only: no coordinate labels and no user-configurable interval/style controls.
- Use `ColorScheme.outlineVariant`, width `1.0`, and opacity `0.30`.
- Place the grid below `BaseLayer.areaForecastLocalELine.name` and therefore below all safety-related overlays.
- Valid zoom is `0...30`; valid longitude is `-180...180`; valid latitude is `-90...90`.
- Intersect valid latitude with Web Mercator `-85.0511287798066...85.0511287798066`.
- Select the smallest approved interval greater than or equal to one eighth of `360 / 2^zoomLevel`, floor at `0.01`, and emit at most 20 features per request.
- Invalid inputs throw; the plugin reports the error and supplies an empty tile. Never substitute a fixed region.
- The provider callback body performs no Riverpod read/watch, I/O, logging, network, storage, UI operation, or `compute()`; its typed `onError` handler may report through Talker.
- Use Talker instead of `print()`; do not show raw callback errors to users.
- Do not introduce `dynamic`, unconstrained `Object`, null assertions, or hard-coded preference keys.
- Record the native callback/lifecycle knowledge in `docs/knowledge/20260802_maplibre_computed_geojson_source.md`.

---

## Stack Setup

The EQMonitor stack includes the already committed design/plan branch:

```text
develop
 └─ codex/computed-geojson-grid-design   (EQ0 docs)
     └─ codex/maplibre-computed-source-pin  (E1)
         └─ codex/lat-lng-grid              (E2)
```

EQ0 targets `develop`. E1 targets EQ0 until EQ0 merges, then is retargeted to
`develop`. E2 targets E1. E1 is created only after the plugin F3 branch has
an immutable pushed commit.

## File Responsibility Map

- `app/lib/feature/map/data/logic/lat_lng_grid_interval_selector.dart`: zoom-to-degree interval selection.
- `app/lib/feature/map/data/logic/lat_lng_grid_geo_json_builder.dart`: bounds validation, snapping, antimeridian splitting, FeatureCollection generation.
- `app/lib/feature/map/data/provider/lat_lng_grid_geo_json_provider.dart`: exact plugin callback adapter.
- `app/lib/feature/map/data/logic/lat_lng_grid_platform_support.dart`: pure mobile-support decision.
- `app/lib/feature/map/ui/layer/lat_lng_grid_style.dart`: source/layer add/remove operations.
- `app/lib/feature/map/ui/layer/lat_lng_grid_layer.dart`: Hook lifecycle and map-operation queue integration.
- `app/lib/feature/map/ui/layer/lat_lng_grid_layer_visibility.dart`: reusable enabled/platform gate for home/live.
- `app/lib/feature/home/data/model/home_configuration_model.dart`: persisted `HomeMapGridSettings`.
- `app/lib/feature/home/data/notifier/home_configuration_notifier.dart`: dedicated `updateMapGrid` mutation target.
- `app/lib/feature/home/ui/component/map/home_map_grid_setting_tile.dart`: one switch bound to Riverpod mutation.
- `app/lib/feature/home/data/model/home_map_instance_key.dart`: stable home map identity excluding grid state.
- `app/lib/feature/home/ui/component/map/home_map_view.dart`: home overlay insertion without map-key changes.
- `app/lib/feature/live_monitor/data/model/live_monitor_map_instance_key.dart`: stable live map identity excluding grid state.
- `app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart`: live overlay insertion without instance-key changes.

---

### Task EQ0: Publish the approved design and plans

**Files:**
- Existing: `docs/superpowers/specs/2026-08-02-computed-geojson-grid-design.md`
- Existing: `docs/superpowers/plans/2026-08-02-flutter-maplibre-computed-geojson-source.md`
- Existing: `docs/superpowers/plans/2026-08-02-eqmonitor-lat-lng-grid.md`

**Interfaces:**
- Consumes: approved design commit `b13fd5c4b`.
- Produces: documentation-only EQ0 PR.

- [ ] **Step 1: Verify the docs branch**

```bash
git --no-pager status --short --branch
git --no-pager log -3 --oneline
git --no-pager diff develop...HEAD --stat
```

Expected: only the approved spec and these two plans differ from `develop`.

- [ ] **Step 2: Run documentation checks**

```bash
git --no-pager diff --check develop...HEAD
rg -n "T""BD|TO""DO|FIX""ME" docs/superpowers/specs/2026-08-02-computed-geojson-grid-design.md docs/superpowers/plans/2026-08-02-*.md
rg -n "gh pr create --repo ""maplibre/flutter-maplibre|git push .*maplibre/flutter-maplibre" docs/superpowers/specs/2026-08-02-computed-geojson-grid-design.md docs/superpowers/plans/2026-08-02-*.md
```

Expected: no whitespace errors and no placeholders or upstream-PR instruction.

- [ ] **Step 3: Push and create EQ0**

```bash
git remote get-url origin
git push -u origin codex/computed-geojson-grid-design
gh pr create --repo YumNumm/EQMonitor --base develop --head codex/computed-geojson-grid-design --draft --title "docs: Computed GeoJSONグリッド設計" --body-file /tmp/eqmonitor-eq0.md
```

---

### Task E1.1: Pin the completed plugin stack

**Files:**
- Modify: `app/pubspec.yaml`
- Modify: `pubspec.lock`

**Interfaces:**
- Consumes: immutable F3 commit SHA from `YumNumm/flutter-maplibre`.
- Produces: all MapLibre packages resolved from that exact SHA.

- [ ] **Step 1: Create E1 from EQ0**

```bash
git switch codex/computed-geojson-grid-design
git switch -c codex/maplibre-computed-source-pin
```

- [ ] **Step 2: Record and verify the F3 SHA**

```bash
git ls-remote https://github.com/YumNumm/flutter-maplibre.git codex/computed-geojson-ios
```

Copy the 40-character commit hash printed for that exact ref. Verify the same
commit contains `ComputedGeoJsonSource`, Android
`CustomGeometrySource`, and iOS `MLNComputedShapeSource` commits before
editing EQMonitor.

- [ ] **Step 3: Replace all six refs atomically**

In `app/pubspec.yaml`, replace the old
`88c76eb0980d03504dc71c69ff50a4080e202e08` ref for:

```text
maplibre
maplibre_android
maplibre_ios
maplibre_platform_interface
maplibre_web
maplibre_webview
```

with the exact F3 hash. Do not change the repository URL or package paths.

- [ ] **Step 4: Resolve and prove one revision**

```bash
mise exec -- flutter pub get
rg -n "resolved-ref|flutter-maplibre" pubspec.lock
```

Expected: every Git-sourced MapLibre package resolves to the same F3 hash.

- [ ] **Step 5: Run existing map regression tests**

```bash
cd app
mise exec -- flutter test test/core/util/map test/feature/home/ui/component/map/layer test/feature/live_monitor/ui/components/live_monitor_map_host_test.dart
mise exec -- flutter analyze
```

Expected: all existing tests pass and analysis reports no issues. If the
dependency pin alone breaks an existing API, stop E1 and diagnose it with
`superpowers:systematic-debugging`; do not mix speculative compatibility
changes into E2.

- [ ] **Step 6: Build both mobile targets**

```bash
cd app
mise exec -- flutter build apk --debug
mise exec -- flutter build ios --simulator --no-codesign
```

Expected: both builds succeed.

- [ ] **Step 7: Commit the pin**

```bash
git add app/pubspec.yaml pubspec.lock
git commit -m "deps: Computed GeoJSON対応MapLibreへ更新"
```

- [ ] **Step 8: Push and create E1**

```bash
git remote get-url origin
git push -u origin codex/maplibre-computed-source-pin
gh pr create --repo YumNumm/EQMonitor --base codex/computed-geojson-grid-design --head codex/maplibre-computed-source-pin --draft --title "deps: Computed GeoJSON対応MapLibreへ更新" --body-file /tmp/eqmonitor-e1.md
```

---

### Task E2.1: Zoom interval selector

**Files:**
- Create: `app/lib/feature/map/data/logic/lat_lng_grid_interval_selector.dart`
- Test: `app/test/feature/map/data/logic/lat_lng_grid_interval_selector_test.dart`

**Interfaces:**
- Consumes: integer `zoomLevel`.
- Produces: `LatLngGridIntervalSelector.select({required int zoomLevel}) -> double`.

- [ ] **Step 1: Create E2 and write the interval table test**

```bash
git switch codex/maplibre-computed-source-pin
git switch -c codex/lat-lng-grid
```

```dart
test('selects the smallest approved interval above tileSpan / 8', () {
  const selector = LatLngGridIntervalSelector();
  const expected = {
    0: 45.0,
    1: 30.0,
    2: 15.0,
    3: 10.0,
    4: 5.0,
    5: 2.0,
    6: 1.0,
    7: 0.5,
    8: 0.25,
    9: 0.1,
    10: 0.05,
    11: 0.025,
    12: 0.025,
    13: 0.01,
    30: 0.01,
  };

  for (final entry in expected.entries) {
    expect(selector.select(zoomLevel: entry.key), entry.value);
  }
});
```

Also assert `-1` and `31` throw `RangeError`.

- [ ] **Step 2: Run the test and confirm RED**

```bash
cd app
mise exec -- flutter test test/feature/map/data/logic/lat_lng_grid_interval_selector_test.dart
```

Expected: compilation fails because the selector does not exist.

- [ ] **Step 3: Implement the selector**

```dart
final class LatLngGridIntervalSelector {
  const LatLngGridIntervalSelector();

  static const intervals = <double>[
    90,
    45,
    30,
    15,
    10,
    5,
    2,
    1,
    0.5,
    0.25,
    0.1,
    0.05,
    0.025,
    0.01,
  ];

  double select({required int zoomLevel}) {
    if (zoomLevel < 0 || zoomLevel > 30) {
      throw RangeError.range(zoomLevel, 0, 30, 'zoomLevel');
    }
    final tileSpan = 360 / math.pow(2, zoomLevel);
    final threshold = tileSpan / 8;
    return intervals.reversed.firstWhere(
      (interval) => interval >= threshold,
      orElse: () => intervals.last,
    );
  }
}
```

- [ ] **Step 4: Run test/analyze and commit**

```bash
cd app
mise exec -- flutter test test/feature/map/data/logic/lat_lng_grid_interval_selector_test.dart
mise exec -- flutter analyze lib/feature/map/data/logic/lat_lng_grid_interval_selector.dart
cd ..
git add app/lib/feature/map/data/logic/lat_lng_grid_interval_selector.dart
git add app/test/feature/map/data/logic/lat_lng_grid_interval_selector_test.dart
git commit -m "feat: グリッド間隔選択を追加"
```

---

### Task E2.2: Deterministic GeoJSON grid builder

**Files:**
- Create: `app/lib/feature/map/data/logic/lat_lng_grid_geo_json_builder.dart`
- Test: `app/test/feature/map/data/logic/lat_lng_grid_geo_json_builder_test.dart`

**Interfaces:**
- Consumes: `LngLatBounds`, integer zoom, and `LatLngGridIntervalSelector`.
- Produces: `LatLngGridGeoJsonBuilder.build(...) -> String`.

- [ ] **Step 1: Write normal-bounds and determinism tests**

For bounds `west=139, east=140, south=35, north=36` at zoom 7, decode the
result and require:

- root `type == FeatureCollection`;
- exactly six features;
- vertical values `139, 139.5, 140`;
- horizontal values `35, 35.5, 36`;
- every coordinate is `[longitude, latitude]`;
- two calls return byte-identical strings.

```dart
final result = const LatLngGridGeoJsonBuilder().build(
  bounds: const LngLatBounds(
    longitudeWest: 139,
    longitudeEast: 140,
    latitudeSouth: 35,
    latitudeNorth: 36,
  ),
  zoomLevel: 7,
);
final decoded = jsonDecode(result) as Map<String, dynamic>;
expect(decoded['type'], 'FeatureCollection');
expect(decoded['features'], hasLength(6));
```

- [ ] **Step 2: Write boundary/error tests**

Add cases for antimeridian bounds `179...-179`, exact `-180/180`, tiny
bounds, latitude `-90...90`, a region entirely outside Web Mercator, all
non-finite values, reversed latitude, out-of-range longitude, zoom `-1/31`,
and a world-width high-zoom request that exceeds 20 features.

Expected behavior:

- antimeridian horizontal lines split at the meridian;
- the antimeridian vertical line is emitted once per request;
- latitude endpoints are clipped to `±85.0511287798066`;
- an empty Mercator intersection yields a valid empty FeatureCollection;
- invalid input and feature overflow throw.

- [ ] **Step 3: Run tests and confirm RED**

```bash
cd app
mise exec -- flutter test test/feature/map/data/logic/lat_lng_grid_geo_json_builder_test.dart
```

- [ ] **Step 4: Implement validation, snapping, and stable ordering**

```dart
final class LatLngGridGeoJsonBuilder {
  const LatLngGridGeoJsonBuilder({
    this.intervalSelector = const LatLngGridIntervalSelector(),
  });

  static const mercatorLimit = 85.0511287798066;
  static const maxFeatureCount = 20;

  final LatLngGridIntervalSelector intervalSelector;

  String build({
    required LngLatBounds bounds,
    required int zoomLevel,
  });
}
```

Implementation rules:

1. Validate finite/range/order inputs before normalization.
2. Intersect latitude with `±mercatorLimit`; return the canonical empty
   FeatureCollection if empty.
3. Generate snapped coordinates by integer index
   `ceil(min / interval)...floor(max / interval)`, not repeated floating
   addition.
4. Normalize each emitted number with
   `double.parse(value.toStringAsFixed(12))` and convert `-0.0` to `0.0`.
5. Emit vertical features in ascending longitude order, then horizontal
   features in ascending latitude and west-to-east segment order.
6. Split crossing horizontal lines into `[west, 180]` and
   `[-180, east]`.
7. Check `features.length <= 20` before `jsonEncode`; otherwise throw
   `StateError`.

Each feature is:

```dart
{
  'type': 'Feature',
  'properties': <String, dynamic>{},
  'geometry': {
    'type': 'LineString',
    'coordinates': coordinates,
  },
}
```

- [ ] **Step 5: Run focused tests and commit**

```bash
cd app
mise exec -- flutter test test/feature/map/data/logic/lat_lng_grid_geo_json_builder_test.dart
mise exec -- flutter analyze lib/feature/map/data/logic
cd ..
git add app/lib/feature/map/data/logic/lat_lng_grid_geo_json_builder.dart
git add app/test/feature/map/data/logic/lat_lng_grid_geo_json_builder_test.dart
git commit -m "feat: 緯度経度グリッドGeoJSONを生成"
```

---

### Task E2.3: Provider and supported-platform boundary

**Files:**
- Create: `app/lib/feature/map/data/provider/lat_lng_grid_geo_json_provider.dart`
- Create: `app/lib/feature/map/data/logic/lat_lng_grid_platform_support.dart`
- Test: `app/test/feature/map/data/provider/lat_lng_grid_geo_json_provider_test.dart`
- Test: `app/test/feature/map/data/logic/lat_lng_grid_platform_support_test.dart`

**Interfaces:**
- Consumes: grid builder, `TargetPlatform`, and Web flag.
- Produces: callable provider and pure mobile support predicate.

- [ ] **Step 1: Write provider and platform matrix tests**

```dart
test('provider exposes the exact synchronous named-argument contract', () {
  const provider = LatLngGridGeoJsonProvider();
  final ComputedGeoJsonProvider callback = provider.call;
  final result = callback(
    bounds: const LngLatBounds(
      longitudeWest: 139,
      longitudeEast: 140,
      latitudeSouth: 35,
      latitudeNorth: 36,
    ),
    zoomLevel: 7,
  );
  expect(jsonDecode(result), isA<Map<String, dynamic>>());
});
```

Test `isLatLngGridSupportedPlatform` returns true only for non-Web Android
and iOS, and false for Web, Linux, macOS, Windows, and Fuchsia.

- [ ] **Step 2: Run tests and confirm RED**

```bash
cd app
mise exec -- flutter test test/feature/map/data/provider/lat_lng_grid_geo_json_provider_test.dart test/feature/map/data/logic/lat_lng_grid_platform_support_test.dart
```

- [ ] **Step 3: Implement the thin adapters**

```dart
final class LatLngGridGeoJsonProvider {
  const LatLngGridGeoJsonProvider({
    this.builder = const LatLngGridGeoJsonBuilder(),
  });

  final LatLngGridGeoJsonBuilder builder;

  String call({
    required LngLatBounds bounds,
    required int zoomLevel,
  }) => builder.build(bounds: bounds, zoomLevel: zoomLevel);
}
```

```dart
bool isLatLngGridSupportedPlatform({
  required bool isWeb,
  required TargetPlatform platform,
}) => !isWeb &&
    (platform == TargetPlatform.android || platform == TargetPlatform.iOS);
```

- [ ] **Step 4: Run tests/analyze and commit**

```bash
cd app
mise exec -- flutter test test/feature/map/data/provider/lat_lng_grid_geo_json_provider_test.dart test/feature/map/data/logic/lat_lng_grid_platform_support_test.dart
mise exec -- flutter analyze lib/feature/map/data/provider/lat_lng_grid_geo_json_provider.dart lib/feature/map/data/logic/lat_lng_grid_platform_support.dart
cd ..
git add app/lib/feature/map/data/provider/lat_lng_grid_geo_json_provider.dart
git add app/lib/feature/map/data/logic/lat_lng_grid_platform_support.dart
git add app/test/feature/map/data/provider/lat_lng_grid_geo_json_provider_test.dart
git add app/test/feature/map/data/logic/lat_lng_grid_platform_support_test.dart
git commit -m "feat: グリッドprovider境界を追加"
```

---

### Task E2.4: Persisted grid setting

**Files:**
- Modify: `app/lib/feature/home/data/model/home_configuration_model.dart`
- Regenerate: `app/lib/feature/home/data/model/home_configuration_model.freezed.dart`
- Regenerate: `app/lib/feature/home/data/model/home_configuration_model.g.dart`
- Modify: `app/lib/feature/home/data/notifier/home_configuration_notifier.dart`
- Regenerate: `app/lib/feature/home/data/notifier/home_configuration_notifier.g.dart`
- Test: `app/test/feature/home/data/notifier/home_map_grid_settings_test.dart`

**Interfaces:**
- Consumes: existing `home_configuration` preference.
- Produces: `HomeMapGridSettings(enabled: false)` and `updateMapGrid`.

- [ ] **Step 1: Write backward-compatibility and persistence tests**

Assert `HomeConfigurationModel.fromJson({})` yields disabled grid and
`toJson()` uses the `map_grid` key.

Use `SharedPreferences.setMockInitialValues({})`, a `ProviderContainer`,
and `homeConfigurationProvider.notifier.updateMapGrid` to enable the grid.
Read the stored `SharedPreferencesKey.homeConfiguration` JSON and assert
`map_grid.enabled == true`. Dispose that container, create a new one, and
assert the saved grid setting reloads as enabled.

- [ ] **Step 2: Run test and confirm RED**

```bash
cd app
mise exec -- flutter test test/feature/home/data/notifier/home_map_grid_settings_test.dart
```

- [ ] **Step 3: Add the model and notifier method**

```dart
@freezed
abstract class HomeMapGridSettings with _$HomeMapGridSettings {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory HomeMapGridSettings({
    @Default(false) bool enabled,
  }) = _HomeMapGridSettings;

  factory HomeMapGridSettings.fromJson(Map<String, dynamic> json) =>
      _$HomeMapGridSettingsFromJson(json);
}
```

Add
`@Default(HomeMapGridSettings()) HomeMapGridSettings mapGrid` to
`HomeConfigurationModel`, not `HomeMapSettings`.

```dart
Future<void> updateMapGrid(HomeMapGridSettings mapGrid) async {
  final current = await future;
  await save(current.copyWith(mapGrid: mapGrid));
}
```

Do not add a new preference enum value.

- [ ] **Step 4: Regenerate, test, and commit**

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
mise exec -- flutter test test/feature/home/data/notifier/home_map_grid_settings_test.dart
mise exec -- flutter analyze lib/feature/home/data/model/home_configuration_model.dart lib/feature/home/data/notifier/home_configuration_notifier.dart
cd ..
git add app/lib/feature/home/data/model/home_configuration_model.dart
git add app/lib/feature/home/data/model/home_configuration_model.freezed.dart
git add app/lib/feature/home/data/model/home_configuration_model.g.dart
git add app/lib/feature/home/data/notifier/home_configuration_notifier.dart
git add app/lib/feature/home/data/notifier/home_configuration_notifier.g.dart
git add app/test/feature/home/data/notifier/home_map_grid_settings_test.dart
git commit -m "feat: グリッド表示設定を保存"
```

---

### Task E2.5: MapLibre source/layer lifecycle

**Files:**
- Create: `app/lib/feature/map/ui/layer/lat_lng_grid_style.dart`
- Create: `app/lib/feature/map/ui/layer/lat_lng_grid_layer.dart`
- Create: `app/lib/feature/map/ui/layer/lat_lng_grid_layer_visibility.dart`
- Test: `app/test/feature/map/ui/layer/lat_lng_grid_style_test.dart`
- Test: `app/test/feature/map/ui/layer/lat_lng_grid_layer_visibility_test.dart`

**Interfaces:**
- Consumes: computed provider, Talker, operation queue, theme color, and BaseLayer.
- Produces: stable source/layer IDs and reusable enabled/platform gate.

- [ ] **Step 1: Write style lifecycle tests**

With a recording `StyleController`, call `LatLngGridStyle.add` and require:

- source ID `lat-lng-grid-source`;
- layer ID `lat-lng-grid-line`;
- source is `ComputedGeoJsonSource`;
- source is added before layer;
- line paint is the supplied color, width `1.0`, opacity `0.30`;
- `belowLayerId == BaseLayer.areaForecastLocalELine.name`.

Call `remove` and require layer removal before source removal. Pass
`isDisposed: () => true` after source insertion and require no layer add.

- [ ] **Step 2: Write visibility widget tests**

`LatLngGridLayerVisibility(enabled: false, isSupported: true)` and
`(enabled: true, isSupported: false)` both render `SizedBox.shrink`.
Only `(enabled: true, isSupported: true)` contains `LatLngGridLayer`.

- [ ] **Step 3: Run tests and confirm RED**

```bash
cd app
mise exec -- flutter test test/feature/map/ui/layer/lat_lng_grid_style_test.dart test/feature/map/ui/layer/lat_lng_grid_layer_visibility_test.dart
```

- [ ] **Step 4: Implement the style owner**

```dart
final class LatLngGridStyle {
  const LatLngGridStyle({required this.lineColor});

  static const sourceId = 'lat-lng-grid-source';
  static const lineLayerId = 'lat-lng-grid-line';
  static const provider = LatLngGridGeoJsonProvider();

  final String lineColor;

  Future<void> add({
    required StyleController styleController,
    required bool Function() isDisposed,
  }) async {
    await styleController.addSource(
      ComputedGeoJsonSource(
        id: sourceId,
        provider: provider.call,
        onError: (error) => talker.handle(error, error.stackTrace),
      ),
    );
    if (isDisposed()) return;
    await styleController.addLayer(
      LineStyleLayer(
        id: lineLayerId,
        sourceId: sourceId,
        paint: {
          'line-color': lineColor,
          'line-width': 1.0,
          'line-opacity': 0.30,
        },
      ),
      belowLayerId: BaseLayer.areaForecastLocalELine.name,
    );
  }

  Future<void> remove({required StyleController styleController}) =>
      removeMapStyleResources(
        styleController: styleController,
        layerIds: const [lineLayerId],
        sourceIds: const [sourceId],
      );
}
```

- [ ] **Step 5: Implement Hook lifecycle and visibility**

`LatLngGridLayer` reads `MapController.maybeOf(context)?.style`, captures
`Theme.of(context).colorScheme.outlineVariant.toHexString()`, and uses
`useMapOperationQueue`. Its effect sets `disposed = true` before enqueuing
`style.remove` during cleanup. It returns `SizedBox.shrink` and defines no
widget helper methods/getters.

`LatLngGridLayerVisibility` is a small stateless widget with required
`enabled` and `isSupported` fields; it returns the grid layer only when
both are true.

- [ ] **Step 6: Run tests/analyze and commit**

```bash
cd app
mise exec -- flutter test test/feature/map/ui/layer/lat_lng_grid_style_test.dart test/feature/map/ui/layer/lat_lng_grid_layer_visibility_test.dart
mise exec -- flutter analyze lib/feature/map/ui/layer
cd ..
git add app/lib/feature/map/ui/layer/lat_lng_grid_style.dart
git add app/lib/feature/map/ui/layer/lat_lng_grid_layer.dart
git add app/lib/feature/map/ui/layer/lat_lng_grid_layer_visibility.dart
git add app/test/feature/map/ui/layer/lat_lng_grid_style_test.dart
git add app/test/feature/map/ui/layer/lat_lng_grid_layer_visibility_test.dart
git commit -m "feat: グリッドレイヤーを追加"
```

---

### Task E2.6: Home and live-monitor composition

**Files:**
- Create: `app/lib/feature/home/data/model/home_map_instance_key.dart`
- Create: `app/lib/feature/live_monitor/data/model/live_monitor_map_instance_key.dart`
- Modify: `app/lib/feature/home/ui/component/map/home_map_view.dart`
- Modify: `app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart`
- Test: `app/test/feature/live_monitor/ui/components/live_monitor_map_host_test.dart`
- Test: `app/test/feature/home/ui/component/map/home_map_grid_identity_test.dart`

**Interfaces:**
- Consumes: persisted `mapGrid.enabled`, platform support predicate, and visibility widget.
- Produces: grid on both primary map hosts without key/identity changes.

- [ ] **Step 1: Write identity tests against explicit key builders**

Define these public, pure identity boundaries so tests do not depend on private
widget internals:

```dart
typedef HomeMapInstanceKey = ({
  String styleString,
  HomeMapSettings mapSettings,
  bool showLocation,
});

HomeMapInstanceKey homeMapInstanceKey({
  required String styleString,
  required HomeMapSettings mapSettings,
  required bool showLocation,
}) => (
  styleString: styleString,
  mapSettings: mapSettings,
  showLocation: showLocation,
);

typedef LiveMonitorMapInstanceKey = ({
  String slotId,
  String styleString,
  HomeMapSettings mapSettings,
});
```

Add the corresponding named-argument `liveMonitorMapInstanceKey` builder.
Create two `HomeConfigurationModel` values that differ only in
`mapGrid.enabled`; require both builders to produce equal keys for them.
Require the live key fields to remain exactly `slotId`, `styleString`, and
`mapSettings`.

Widget-test `LatLngGridLayerVisibility` is already covered in E2.5; these
tests protect the two host identity boundaries.

- [ ] **Step 2: Insert the home grid first**

In `_MapContent.build`, replace the current record used by `mapKey` with
`homeMapInstanceKey(...)`, then compute:

```dart
final gridEnabled = homeAsync.value?.mapGrid.enabled ?? false;
final gridSupported = isLatLngGridSupportedPlatform(
  isWeb: kIsWeb,
  platform: defaultTargetPlatform,
);
```

Insert
`LatLngGridLayerVisibility(enabled: gridEnabled, isSupported: gridSupported)`
as the first `MapLibreMap.children` entry. Do not add either value to
`mapKey`.

- [ ] **Step 3: Insert the live-monitor grid**

Read `mapGrid.enabled` in `_LiveMonitorMapViewport`, pass it and the pure
platform-support result to `_LiveMonitorMapContent`, and prepend the same
visibility widget to `children`. Build both the owner `instanceKey` and
`MapLibreMap.key` through `liveMonitorMapInstanceKey(...)`; do not add grid
state.

- [ ] **Step 4: Run focused tests and commit**

```bash
cd app
mise exec -- flutter test test/feature/home/ui/component/map/home_map_grid_identity_test.dart test/feature/live_monitor/ui/components/live_monitor_map_host_test.dart test/feature/map/ui/layer/lat_lng_grid_layer_visibility_test.dart
mise exec -- flutter analyze lib/feature/home/data/model/home_map_instance_key.dart lib/feature/live_monitor/data/model/live_monitor_map_instance_key.dart lib/feature/home/ui/component/map/home_map_view.dart lib/feature/live_monitor/ui/components/live_monitor_map_host.dart
cd ..
git add app/lib/feature/home/data/model/home_map_instance_key.dart
git add app/lib/feature/live_monitor/data/model/live_monitor_map_instance_key.dart
git add app/lib/feature/home/ui/component/map/home_map_view.dart
git add app/lib/feature/live_monitor/ui/components/live_monitor_map_host.dart
git add app/test/feature/home/ui/component/map/home_map_grid_identity_test.dart
git add app/test/feature/live_monitor/ui/components/live_monitor_map_host_test.dart
git commit -m "feat: ホームとライブ地図へグリッドを統合"
```

---

### Task E2.7: Mobile-only settings switch

**Files:**
- Create: `app/lib/feature/home/ui/component/map/home_map_grid_setting_tile.dart`
- Modify: `app/lib/feature/home/ui/page/home_map_layer_page.dart`
- Test: `app/test/feature/home/ui/component/map/home_map_grid_setting_tile_test.dart`

**Interfaces:**
- Consumes: `HomeMapGridSettings`, `HomeConfigurationNotifier.saveMutation`.
- Produces: one opt-in switch on iOS/Android.

- [ ] **Step 1: Write the switch test**

Pump `HomeMapGridSettingTile` inside `ProviderScope` after
`SharedPreferences.setMockInitialValues({})`. Assert title
`緯度・経度グリッド`, subtitle
`ズームに合わせた緯度・経度の線を表示します。`, and an off switch.
Tap the switch, pump, and assert
`homeConfigurationProvider.future` yields `mapGrid.enabled == true`.

- [ ] **Step 2: Run test and confirm RED**

```bash
cd app
mise exec -- flutter test test/feature/home/ui/component/map/home_map_grid_setting_tile_test.dart
```

- [ ] **Step 3: Implement the tile**

Implement `HomeMapGridSettingTile` directly with the same `ListTile` and
`AppSwitch` structure as the existing `_SettingSwitchTile`; leave the existing
private component in place because it is not shared outside its page.
Its `onChanged` runs:

```dart
await HomeConfigurationNotifier.saveMutation.run(
  ref,
  (tsx) async => tsx
      .get(homeConfigurationProvider.notifier)
      .updateMapGrid(config.mapGrid.copyWith(enabled: enabled)),
);
```

- [ ] **Step 4: Add it only on supported platforms**

In `HomeMapLayerPage.build`, compute the pure support value with `kIsWeb`
and `defaultTargetPlatform`. Add `HomeMapGridSettingTile` as the first child
of the `マップ` section only when supported. Update that section description
to `地図のグリッド、回転、ズーム、初期表示範囲を設定します。`

- [ ] **Step 5: Run tests/analyze and commit**

```bash
cd app
mise exec -- flutter test test/feature/home/ui/component/map/home_map_grid_setting_tile_test.dart test/feature/map/data/logic/lat_lng_grid_platform_support_test.dart
mise exec -- flutter analyze lib/feature/home/ui/component/map/home_map_grid_setting_tile.dart lib/feature/home/ui/page/home_map_layer_page.dart
cd ..
git add app/lib/feature/home/ui/component/map/home_map_grid_setting_tile.dart
git add app/lib/feature/home/ui/page/home_map_layer_page.dart
git add app/test/feature/home/ui/component/map/home_map_grid_setting_tile_test.dart
git commit -m "feat: グリッド表示スイッチを追加"
```

---

### Task E2.8: Failure isolation and lifecycle regression tests

**Files:**
- Modify: `app/test/feature/map/ui/layer/lat_lng_grid_style_test.dart`
- Create: `app/test/feature/map/ui/layer/lat_lng_grid_layer_lifecycle_test.dart`

**Interfaces:**
- Consumes: completed layer/style.
- Produces: regression coverage for rapid lifecycle and source error isolation.

- [ ] **Step 1: Add failing lifecycle cases**

Use a recording controller and the real `MapOperationQueue` to cover:

- mount → unmount → mount serializes add/remove/add;
- rapid enable/disable leaves one active source/layer at most;
- style controller replacement cleans the old controller;
- a provider throw records one Talker/plugin error and does not remove a
  pre-registered fake safety layer;
- source error does not prevent the queue's next operation.

For the provider failure case, retrieve the registered
`ComputedGeoJsonSource` from the recording controller and invoke
`computeGeoJson` with deterministic bounds and zoom. The provider body itself
does no logging; its `onError` path records the typed failure through Talker.

- [ ] **Step 2: Run tests**

```bash
cd app
mise exec -- flutter test test/feature/map/ui/layer/lat_lng_grid_style_test.dart test/feature/map/ui/layer/lat_lng_grid_layer_lifecycle_test.dart
```

Expected: pass without increasing arbitrary delays. If a race is found,
diagnose it before changing the shared queue.

- [ ] **Step 3: Commit regression coverage**

```bash
git add app/test/feature/map/ui/layer/lat_lng_grid_style_test.dart
git add app/test/feature/map/ui/layer/lat_lng_grid_layer_lifecycle_test.dart
git commit -m "test: グリッドライフサイクルを検証"
```

---

### Task E2.9: Knowledge and map architecture

**Files:**
- Create: `docs/knowledge/20260802_maplibre_computed_geojson_source.md`
- Modify: `docs/map-architecture.md`

**Interfaces:**
- Consumes: verified plugin/application behavior.
- Produces: operational rules for future agents and developers.

- [ ] **Step 1: Record the platform knowledge**

Document:

- exact synchronous callback signature;
- Android `CustomGeometrySource` and retained JNI proxy;
- iOS `MLNComputedShapeSourceDataSource.implementAsBlocking` and weak Native
  data-source ownership;
- provider no-I/O rule;
- FeatureCollection validation/error/empty-tile behavior;
- iOS/Android support and unsupported-platform guard;
- jnigen/ffigen regeneration commands;
- source removal/style replacement/disposal ordering;
- Android/iOS integration and build commands;
- the rule forbidding upstream PR/push.

- [ ] **Step 2: Update the map inventory**

Add the grid source/layer IDs, owning widget/style class, placement below
`BaseLayer.areaForecastLocalELine`, home/live scope, default-off setting, and
unsupported-platform behavior to `docs/map-architecture.md`.

- [ ] **Step 3: Commit documentation**

```bash
git add docs/knowledge/20260802_maplibre_computed_geojson_source.md docs/map-architecture.md
git commit -m "docs: Computed GeoJSON運用知見を記録"
```

---

### Task E2.10: Full verification and E2 pull request

**Files:**
- Verify all E2 files.

**Interfaces:**
- Consumes: E2.1-E2.9.
- Produces: reviewable E2 PR and evidence.

- [ ] **Step 1: Regenerate and require a clean diff**

```bash
cd app
mise exec -- dart run build_runner build --delete-conflicting-outputs
cd ..
git --no-pager diff --exit-code
```

- [ ] **Step 2: Run all focused tests**

```bash
cd app
mise exec -- flutter test test/feature/map/data/logic/lat_lng_grid_interval_selector_test.dart test/feature/map/data/logic/lat_lng_grid_geo_json_builder_test.dart test/feature/map/data/logic/lat_lng_grid_platform_support_test.dart test/feature/map/data/provider/lat_lng_grid_geo_json_provider_test.dart test/feature/map/ui/layer/lat_lng_grid_style_test.dart test/feature/map/ui/layer/lat_lng_grid_layer_visibility_test.dart test/feature/map/ui/layer/lat_lng_grid_layer_lifecycle_test.dart test/feature/home/data/notifier/home_map_grid_settings_test.dart test/feature/home/ui/component/map/home_map_grid_identity_test.dart test/feature/home/ui/component/map/home_map_grid_setting_tile_test.dart test/feature/live_monitor/ui/components/live_monitor_map_host_test.dart
```

Expected: all tests pass.

- [ ] **Step 3: Run repository analysis and full tests**

```bash
mise exec -- dart run melos run analyze
mise exec -- dart run melos run test
```

Expected: zero analysis issues and all workspace tests pass.

- [ ] **Step 4: Build both mobile applications**

```bash
cd app
mise exec -- flutter build apk --debug
mise exec -- flutter build ios --simulator --no-codesign
```

- [ ] **Step 5: Perform visual safety checks**

On Android and iOS, enable the switch and inspect home and live-monitor maps
in light/dark themes at zoom levels 3, 7, 13, and the app's maximum zoom.
Trigger or replay views containing EEW fill, P/S waves, hypocenter, observation
points, shake detection, tsunami/intensity overlays where available. Confirm
the 1px/0.30 grid remains behind them. Disable the switch and confirm the
source/layer disappears without camera reset.

- [ ] **Step 6: Update E1 to the merged F3 SHA**

After the plugin stack merges, replace the pre-merge F3 commit with its final
merged commit SHA in all six overrides. Perform the update on E1, then replay
E2 on the refreshed dependency branch:

```bash
git switch codex/maplibre-computed-source-pin
# Replace all six app/pubspec.yaml git refs with the immutable merged F3 SHA.
cd app
mise exec -- flutter pub get
cd ..
git add app/pubspec.yaml pubspec.lock
git commit -m "deps: MapLibreの統合済みSHAへ追従"
git push origin codex/maplibre-computed-source-pin
git switch codex/lat-lng-grid
git rebase codex/maplibre-computed-source-pin
# Use --force-with-lease only when this E2 branch was pushed before the rebase.
git push --force-with-lease origin codex/lat-lng-grid
```

Require `rg -n "ref:" app/pubspec.yaml` to show that same immutable SHA six
times, then repeat Steps 1-4 on the rebased E2 head.

- [ ] **Step 7: Push and create E2**

```bash
git remote get-url origin
git push -u origin codex/lat-lng-grid
gh pr create --repo YumNumm/EQMonitor --base codex/maplibre-computed-source-pin --head codex/lat-lng-grid --draft --title "feat: 緯度経度グリッドを追加" --body-file /tmp/eqmonitor-e2.md
```

- [ ] **Step 8: Read back the full stack**

Confirm EQ0/E1/E2 repository owner, bases, heads, draft state, check runs, and
links to F1/F2/F3. Confirm no PR or pushed branch exists in
`maplibre/flutter-maplibre`.
