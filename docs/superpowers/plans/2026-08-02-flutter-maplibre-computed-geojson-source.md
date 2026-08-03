# flutter-maplibre Computed GeoJSON Source Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add one synchronous `ComputedGeoJsonSource` Dart API backed by Android `CustomGeometrySource` and iOS `MLNComputedShapeSource`, with explicit unsupported behavior elsewhere.

**Architecture:** The platform interface owns provider execution, FeatureCollection validation, empty-tile recovery, and error notification. Android and iOS adapters only convert native bounds, retain callback proxies, translate the validated GeoJSON into native feature collections, and forward invalidation. Three stacked pull requests isolate the public contract, Android backend, and iOS backend/documentation.

**Tech Stack:** Flutter 3.44+, Dart 3.12+, the MapLibre Native Android version pinned by the fork, MapLibre Native iOS 6.27, jni/jnigen, objective_c/ffigen, Flutter integration_test, GitHub Actions.

## Global Constraints

- Work from the current `main` branch of `https://github.com/YumNumm/flutter-maplibre.git`, not EQMonitor's old pub-cache checkout.
- Never push to or open a pull request against `maplibre/flutter-maplibre`.
- The provider signature is exactly `String Function({required LngLatBounds bounds, required int zoomLevel})`.
- Provider execution is synchronous and must not perform I/O, return a `Future`, or touch Flutter UI state.
- Only GeoJSON objects with `type: "FeatureCollection"` and a list-valued `features` member are accepted.
- A provider, validation, or native-conversion failure reports once and returns `{"type":"FeatureCollection","features":[]}`.
- Region and tile invalidation are public; manual `setTileData` is not.
- Web and webview desktop implementations throw `UnsupportedError`; there is no fallback renderer.
- Nullable source options defer to each Native SDK default.
- iOS data-source callbacks use `implementAsBlocking` and the adapter is strongly retained because Native holds a weak data-source reference.
- Generated JNI/FFI files are regenerated from configuration and are never manually edited.
- Before every push, verify `git remote get-url origin` is the YumNumm fork.

---

## Repository and Stack Setup

Use `superpowers:using-git-worktrees` before implementation. Create an isolated checkout whose `origin` is exactly the YumNumm fork, then create these dependent branches:

```text
main
 └─ codex/computed-geojson-contract
     └─ codex/computed-geojson-android
         └─ codex/computed-geojson-ios
```

F1 targets `main`; F2 targets `codex/computed-geojson-contract`; F3 targets `codex/computed-geojson-android`. Use `--repo YumNumm/flutter-maplibre` for every PR command.

## File Responsibility Map

- `packages/maplibre_platform_interface/lib/src/style/sources/computed_geo_json_source.dart`: public model, provider/error types, common validation and recovery.
- `packages/maplibre_platform_interface/lib/src/style/sources/source.dart`: source part/import registration.
- `packages/maplibre_platform_interface/lib/src/style_controller.dart`: invalidation contract and unsupported defaults.
- `packages/maplibre/lib/maplibre.dart`: public exports.
- `packages/maplibre_android/lib/src/computed_geo_json_source.dart`: JNI callback binding and lifecycle.
- `packages/maplibre_android/lib/src/style_controller.dart`: Android source registration/removal/invalidation.
- `packages/maplibre_android/tool/jnigen.dart`: explicit `FeatureCollection` generation.
- `packages/maplibre_ios/lib/src/computed_geo_json_source.dart`: Objective-C callback binding and lifecycle.
- `packages/maplibre_ios/lib/src/style_controller.dart`: iOS source registration/removal/invalidation.
- `packages/maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/Helpers.swift`: narrow GeoJSON-to-feature-array converter.
- `packages/maplibre_ios/tool/ffigen.dart`: computed-source header/interface/protocol allowlists.
- `examples/integration_test/computed_geo_json_source_test.dart`: shared Android/iOS behavioral test.
- `examples/lib/style_sources_computed_geo_json_page.dart`: asset-free public example.

---

### Task F1.1: Public source, validation, and error contract

**Files:**
- Create: `packages/maplibre_platform_interface/lib/src/style/sources/computed_geo_json_source.dart`
- Modify: `packages/maplibre_platform_interface/lib/src/style/sources/source.dart`
- Modify: `packages/maplibre/lib/maplibre.dart`
- Test: `packages/maplibre/test/style/source/computed_geo_json_source_test.dart`

**Interfaces:**
- Consumes: `LngLatBounds`, `Source`, and Flutter error reporting.
- Produces: `ComputedGeoJsonProvider`, `ComputedGeoJsonErrorCallback`, `ComputedGeoJsonSourceErrorKind`, `ComputedGeoJsonSourceError`, and `ComputedGeoJsonSource`.

- [ ] **Step 1: Write provider and recovery tests**

```dart
test('passes named bounds and integer zoomLevel to the provider', () {
  const bounds = LngLatBounds(
    longitudeWest: 139,
    longitudeEast: 140,
    latitudeSouth: 35,
    latitudeNorth: 36,
  );
  LngLatBounds? receivedBounds;
  int? receivedZoom;
  final source = ComputedGeoJsonSource(
    id: 'computed',
    provider: ({required bounds, required zoomLevel}) {
      receivedBounds = bounds;
      receivedZoom = zoomLevel;
      return '{"type":"FeatureCollection","features":[]}';
    },
  );

  final result = source.computeGeoJson(bounds: bounds, zoomLevel: 7);

  expect(result, ComputedGeoJsonSource.emptyFeatureCollection);
  expect(receivedBounds, bounds);
  expect(receivedZoom, 7);
});

test('reports invalid root and returns an empty FeatureCollection', () {
  ComputedGeoJsonSourceError? received;
  final source = ComputedGeoJsonSource(
    id: 'computed',
    provider: ({required bounds, required zoomLevel}) =>
        '{"type":"Feature","geometry":null,"properties":{}}',
    onError: (error) => received = error,
  );

  final result = source.computeGeoJson(
    bounds: const LngLatBounds(
      longitudeWest: 0,
      longitudeEast: 1,
      latitudeSouth: 0,
      latitudeNorth: 1,
    ),
    zoomLevel: 3,
  );

  expect(result, ComputedGeoJsonSource.emptyFeatureCollection);
  expect(received?.kind, ComputedGeoJsonSourceErrorKind.invalidGeoJson);
  expect(received?.sourceId, 'computed');
});
```

Add separate tests for provider throws, malformed JSON, a missing/list-invalid `features` member, default `FlutterError.reportError`, an `onError` callback that itself throws, and preservation of every nullable option.

- [ ] **Step 2: Run the focused test and confirm RED**

Run:

```bash
cd packages/maplibre
mise exec -- flutter test test/style/source/computed_geo_json_source_test.dart
```

Expected: compilation fails because `ComputedGeoJsonSource` is not defined.

- [ ] **Step 3: Implement the exact public types**

```dart
typedef ComputedGeoJsonProvider = String Function({
  required LngLatBounds bounds,
  required int zoomLevel,
});

typedef ComputedGeoJsonErrorCallback = void Function(
  ComputedGeoJsonSourceError error,
);

enum ComputedGeoJsonSourceErrorKind {
  provider,
  invalidGeoJson,
  nativeConversion,
}

final class ComputedGeoJsonSourceError implements Exception {
  const ComputedGeoJsonSourceError({
    required this.sourceId,
    required this.kind,
    required this.message,
    required this.stackTrace,
  });

  final String sourceId;
  final ComputedGeoJsonSourceErrorKind kind;
  final String message;
  final StackTrace stackTrace;
}
```

Implement `ComputedGeoJsonSource` with the approved constructor fields and:

```dart
static const emptyFeatureCollection =
    '{"type":"FeatureCollection","features":[]}';

@internal
String computeGeoJson({
  required LngLatBounds bounds,
  required int zoomLevel,
});

@internal
String recoverFromError({
  required ComputedGeoJsonSourceErrorKind kind,
  required String message,
  required StackTrace stackTrace,
});
```

`computeGeoJson` calls the provider inside one try/catch, then decodes the returned string inside a second try/catch. Require a map root, `type == 'FeatureCollection'`, and a list-valued `features`. `recoverFromError` invokes `onError` or `FlutterError.reportError` and always returns `emptyFeatureCollection`. If `onError` throws, report that callback failure with `FlutterError.reportError` and still return empty.

Add `part 'computed_geo_json_source.dart';` and the `dart:convert` / Flutter foundation imports to `source.dart`. Export all five public symbols from `packages/maplibre/lib/maplibre.dart`.

- [ ] **Step 4: Run tests and analysis**

```bash
cd packages/maplibre
mise exec -- flutter test test/style/source/computed_geo_json_source_test.dart
cd ../..
mise exec -- dart analyze packages/maplibre_platform_interface packages/maplibre
```

Expected: all focused tests pass and analysis reports no issues.

- [ ] **Step 5: Commit the common source contract**

```bash
git add packages/maplibre_platform_interface/lib/src/style/sources/source.dart
git add packages/maplibre_platform_interface/lib/src/style/sources/computed_geo_json_source.dart
git add packages/maplibre/lib/maplibre.dart
git add packages/maplibre/test/style/source/computed_geo_json_source_test.dart
git commit -m "feat: Computed GeoJSON source契約を追加"
```

---

### Task F1.2: Invalidation contract and unsupported platforms

**Files:**
- Modify: `packages/maplibre_platform_interface/lib/src/style_controller.dart`
- Modify: `packages/maplibre_web/lib/src/style_controller.dart`
- Modify: `packages/maplibre_webview/lib/src/style_controller.dart`
- Test: `packages/maplibre/test/style/computed_geo_json_style_controller_test.dart`

**Interfaces:**
- Consumes: `ComputedGeoJsonSource` from F1.1.
- Produces: region/tile invalidation methods with default `UnsupportedError`.

- [ ] **Step 1: Write unsupported-contract tests**

Create a concrete test controller that extends `StyleController` and satisfies unrelated abstract methods through `noSuchMethod`. Assert both default invalidation calls throw:

```dart
expect(
  () => controller.invalidateComputedGeoJsonSourceRegion(
    id: 'computed',
    bounds: const LngLatBounds(
      longitudeWest: 0,
      longitudeEast: 1,
      latitudeSouth: 0,
      latitudeNorth: 1,
    ),
  ),
  throwsA(isA<UnsupportedError>()),
);
expect(
  () => controller.invalidateComputedGeoJsonSourceTile(
    id: 'computed',
    x: 1,
    y: 2,
    zoomLevel: 3,
  ),
  throwsA(isA<UnsupportedError>()),
);
```

- [ ] **Step 2: Run the test and confirm RED**

```bash
cd packages/maplibre
mise exec -- flutter test test/style/computed_geo_json_style_controller_test.dart
```

Expected: compilation fails because the invalidation methods do not exist.

- [ ] **Step 3: Add default controller methods**

```dart
Future<void> invalidateComputedGeoJsonSourceRegion({
  required String id,
  required LngLatBounds bounds,
}) async => throw UnsupportedError(
  'ComputedGeoJsonSource is not supported on this platform.',
);

Future<void> invalidateComputedGeoJsonSourceTile({
  required String id,
  required int x,
  required int y,
  required int zoomLevel,
}) async => throw UnsupportedError(
  'ComputedGeoJsonSource is not supported on this platform.',
);
```

In Web and WebView `addSource` switches, add an explicit
`case ComputedGeoJsonSource():` that throws the same message before bridge
access. Do not add invalidation overrides; the platform-interface defaults are
the supported contract.

- [ ] **Step 4: Verify tests, Web unit tests, and desktop/Web builds**

```bash
cd packages/maplibre
mise exec -- flutter test test/style/computed_geo_json_style_controller_test.dart
cd ../maplibre_webview
mise exec -- flutter test
cd ../../examples
mise exec -- flutter build web
mise exec -- flutter build macos --debug
```

On a non-macOS worker, run the Web test/build locally and leave the macOS build
to CI; do not mark F1 ready until CI reports it green.

- [ ] **Step 5: Commit unsupported behavior**

```bash
git add packages/maplibre_platform_interface/lib/src/style_controller.dart
git add packages/maplibre_web/lib/src/style_controller.dart
git add packages/maplibre_webview/lib/src/style_controller.dart
git add packages/maplibre/test/style/computed_geo_json_style_controller_test.dart
git commit -m "feat: Computed sourceの非対応契約を追加"
```

---

### Task F1.3: Contract documentation and F1 pull request

**Files:**
- Modify: `packages/maplibre/CHANGELOG.md`
- Modify: `packages/maplibre_platform_interface/CHANGELOG.md`

**Interfaces:**
- Consumes: F1.1/F1.2.
- Produces: reviewable F1 branch and PR.

- [ ] **Step 1: Add Unreleased entries**

Document the new synchronous provider, strict FeatureCollection requirement,
error callback, invalidation methods, and iOS/Android-only support. Do not
claim either mobile backend is implemented in the F1 text.

- [ ] **Step 2: Run the F1 gate**

```bash
mise exec -- dart format --set-exit-if-changed packages/maplibre_platform_interface packages/maplibre
mise exec -- dart analyze --fatal-warnings --fatal-infos
cd packages/maplibre
mise exec -- flutter test
cd ../maplibre_webview
mise exec -- flutter test
```

Expected: zero formatting changes, zero analysis issues, and all unit tests pass.

- [ ] **Step 3: Commit documentation**

```bash
git add packages/maplibre/CHANGELOG.md packages/maplibre_platform_interface/CHANGELOG.md
git commit -m "docs: Computed source契約を記録"
```

- [ ] **Step 4: Push and create F1 only in the fork**

```bash
git remote get-url origin
git push -u origin codex/computed-geojson-contract
gh pr create --repo YumNumm/flutter-maplibre --base main --head codex/computed-geojson-contract --draft --title "feat: Computed GeoJSON source contract" --body-file /tmp/flutter-maplibre-f1.md
```

The remote check must print the YumNumm repository. The PR body lists provider
synchrony, strict validation, unsupported platforms, tests, and F2/F3 follow-up
links. Never use `--repo maplibre/flutter-maplibre`.

---

### Task F2.1: Failing Android integration test

**Files:**
- Create: `examples/integration_test/computed_geo_json_source_test.dart`
- Modify: `examples/integration_test/main.dart`

**Interfaces:**
- Consumes: F1 public API.
- Produces: one shared mobile scenario that initially fails on Android and is reused by iOS.

- [ ] **Step 1: Create a deterministic computed line fixture**

The provider records each `({LngLatBounds bounds, int zoomLevel})` request and
returns one diagonal line within those bounds:

```dart
String computedLine({
  required LngLatBounds bounds,
  required int zoomLevel,
}) => jsonEncode({
  'type': 'FeatureCollection',
  'features': [
    {
      'type': 'Feature',
      'properties': {'zoomLevel': zoomLevel},
      'geometry': {
        'type': 'LineString',
        'coordinates': [
          [bounds.longitudeWest, bounds.latitudeSouth],
          [bounds.longitudeEast, bounds.latitudeNorth],
        ],
      },
    },
  ],
});
```

Use an empty style JSON, center `(10, 10)`, zoom `4`, source ID
`computed-source`, and line-layer ID `computed-line`. Add a five-second
condition-based waiter; do not use an unbounded delay.

- [ ] **Step 2: Test callback, rendered query, and both invalidations**

Assert the first callback has finite ordered bounds and `zoomLevel == 4`.
Query rendered features across the full map viewport and require a feature
from `computed-line`. Save the callback count, invalidate the visible region,
and require the count to increase. Then invalidate the visible center tile
`z=4, x=8, y=7` and require another increase.

Add a second test whose provider throws `StateError('provider failed')`;
require one `ComputedGeoJsonSourceErrorKind.provider` notification and no
crash. Remove line then source at the end of each test.

Register `computed_geo_json_source_test.test()` from
`examples/integration_test/main.dart`.

- [ ] **Step 3: Run Android integration and confirm RED**

```bash
cd examples
mise exec -- flutter test integration_test/main.dart -d emulator-5554 --timeout=1800s -r expanded
```

Expected: the computed source add fails with the Android unsupported-source
error. If no emulator exists, start the repository's documented Android test
device before running this command.

- [ ] **Step 4: Commit the red integration test**

```bash
git add examples/integration_test/computed_geo_json_source_test.dart examples/integration_test/main.dart
git commit -m "test: Android computed sourceの期待動作を追加"
```

---

### Task F2.2: Generate complete Android GeoJSON bindings

**Files:**
- Modify: `packages/maplibre_android/tool/jnigen.dart`
- Regenerate: `packages/maplibre_android/lib/src/jni.g.dart`

**Interfaces:**
- Consumes: jnigen configuration.
- Produces: non-stub `jni.FeatureCollection.fromJson(JString)`.

- [ ] **Step 1: Add the explicit class**

```dart
'org.maplibre.geojson.Feature',
'org.maplibre.geojson.FeatureCollection',
```

- [ ] **Step 2: Regenerate and inspect**

```bash
cd packages/maplibre_android
mise exec -- dart tool/jnigen.dart
cd ../..
mise exec -- dart format packages/maplibre_android/lib/src/jni.g.dart
rg -n "static FeatureCollection.*fromJson" packages/maplibre_android/lib/src/jni.g.dart
```

Expected: `FeatureCollection` is no longer marked as a stub and has a static
`fromJson` binding.

- [ ] **Step 3: Commit configuration and generated output**

```bash
git add packages/maplibre_android/tool/jnigen.dart packages/maplibre_android/lib/src/jni.g.dart
git commit -m "build: FeatureCollection JNI bindingを生成"
```

---

### Task F2.3: Android callback adapter and lifecycle

**Files:**
- Create: `packages/maplibre_android/lib/src/computed_geo_json_source.dart`
- Modify: `packages/maplibre_android/lib/src/map_state.dart`
- Modify: `packages/maplibre_android/lib/src/style_controller.dart`

**Interfaces:**
- Consumes: `ComputedGeoJsonSource.computeGeoJson`, `recoverFromError`, and generated `FeatureCollection.fromJson`.
- Produces: retained `_ComputedGeoJsonSourceAndroidBinding` and Android invalidation overrides.

- [ ] **Step 1: Register the adapter part and binding map**

Add `part 'computed_geo_json_source.dart';` to `map_state.dart`. Make the
`StyleControllerAndroid._` constructor non-const and add:

```dart
final _computedGeoJsonSources =
    <String, _ComputedGeoJsonSourceAndroidBinding>{};
```

- [ ] **Step 2: Implement the binding**

```dart
final class _ComputedGeoJsonSourceAndroidBinding {
  _ComputedGeoJsonSourceAndroidBinding({
    required this.source,
    required this.nativeSource,
    required this.tileProvider,
  });

  final ComputedGeoJsonSource source;
  final jni.CustomGeometrySource nativeSource;
  final jni.GeometryTileProvider tileProvider;
  bool isActive = true;

  void dispose() {
    isActive = false;
    if (!nativeSource.isReleased) nativeSource.release();
    if (!tileProvider.isReleased) tileProvider.release();
  }
}
```

Create the proxy with
`jni.GeometryTileProvider.implement(jni.$GeometryTileProvider(...))`.
The `getFeaturesForBounds` callback:

1. Returns a parsed empty collection without notification when `isActive` is false.
2. Converts `jni.LatLngBounds` with `toLngLatBounds`.
3. Calls `source.computeGeoJson(bounds: ..., zoomLevel: zoomLevel)`.
4. Parses with `jni.FeatureCollection.fromJson`.
5. On parser/null failure, calls `source.recoverFromError(kind: nativeConversion, ...)` and parses the constant empty collection.

Do not register the native source or provider with a temporary JNI arena that
releases them at callback return.

- [ ] **Step 3: Apply nullable Native options and add the source**

Build `jni.CustomGeometrySourceOptions`; call `withMinZoom`,
`withMaxZoom`, `withBuffer`, `withTolerance`, `withWrap`, and
`withClip` only for non-null Dart values. Construct
`jni.CustomGeometrySource(jId, options, tileProvider)`, add it to the style,
then retain the binding by source ID. If style insertion throws, dispose the
binding before rethrowing.

- [ ] **Step 4: Implement invalidation and deterministic release**

```dart
@override
Future<void> invalidateComputedGeoJsonSourceRegion({
  required String id,
  required LngLatBounds bounds,
}) async {
  final binding = _computedGeoJsonSources[id];
  if (binding == null) throw StateError('Computed source "$id" does not exist.');
  using((arena) {
    binding.nativeSource.invalidateRegion(
      bounds.toJLatLngBounds(arena: arena),
    );
  });
}

@override
Future<void> invalidateComputedGeoJsonSourceTile({
  required String id,
  required int x,
  required int y,
  required int zoomLevel,
}) async {
  final binding = _computedGeoJsonSources[id];
  if (binding == null) throw StateError('Computed source "$id" does not exist.');
  binding.nativeSource.invalidateTile(zoomLevel, x, y);
}
```

In `removeSource`, mark/remove the retained binding, remove the native style
source, and dispose the binding in `finally`. In controller `dispose`, mark
all bindings inactive and release them before releasing `_jStyle`.

- [ ] **Step 5: Run the Android integration test and confirm GREEN**

```bash
cd examples
mise exec -- flutter test integration_test/main.dart -d emulator-5554 --timeout=1800s -r expanded
```

Expected: callback, rendered query, region invalidation, tile invalidation,
error notification, and source removal all pass.

- [ ] **Step 6: Commit Android implementation**

```bash
git add packages/maplibre_android/lib/src/map_state.dart
git add packages/maplibre_android/lib/src/style_controller.dart
git add packages/maplibre_android/lib/src/computed_geo_json_source.dart
git commit -m "feat: Android computed sourceを実装"
```

---

### Task F2.4: Android CI, changelog, and F2 pull request

**Files:**
- Modify: `.github/workflows/ci.yml`
- Modify: `packages/maplibre/CHANGELOG.md`
- Modify: `packages/maplibre_android/CHANGELOG.md`

**Interfaces:**
- Consumes: F2.1-F2.3.
- Produces: reproducible Android binding check and F2 PR.

- [ ] **Step 1: Enable the Android codegen job**

Uncomment `codegen-android`. Keep Java 21, build the example before jnigen,
format the generated file, and fail when `git status --porcelain` is nonempty.

- [ ] **Step 2: Add Android Unreleased notes**

Document `CustomGeometrySource`, synchronous callback behavior, both
invalidations, lifecycle retention, and error isolation.

- [ ] **Step 3: Run the F2 gate**

```bash
mise exec -- dart format --set-exit-if-changed packages/maplibre_android examples/integration_test
mise exec -- dart analyze --fatal-warnings --fatal-infos
cd examples
mise exec -- flutter build apk
```

Then regenerate jnigen once more and require a clean diff:

```bash
cd ../packages/maplibre_android
mise exec -- dart tool/jnigen.dart
cd ../..
mise exec -- dart format packages/maplibre_android/lib/src/jni.g.dart
git --no-pager diff --exit-code
```

- [ ] **Step 4: Commit CI/docs**

```bash
git add .github/workflows/ci.yml packages/maplibre/CHANGELOG.md packages/maplibre_android/CHANGELOG.md
git commit -m "ci: Android binding再生成を検証"
```

- [ ] **Step 5: Push and create F2 only in the fork**

```bash
git remote get-url origin
git push -u origin codex/computed-geojson-android
gh pr create --repo YumNumm/flutter-maplibre --base codex/computed-geojson-contract --head codex/computed-geojson-android --draft --title "feat: Android computed GeoJSON source" --body-file /tmp/flutter-maplibre-f2.md
```

---

### Task F3.1: iOS Swift conversion helper and FFI generation

**Files:**
- Modify: `packages/maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/Helpers.swift`
- Regenerate: `packages/maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/MapLibreIos.h`
- Modify: `packages/maplibre_ios/tool/ffigen.dart`
- Regenerate: `packages/maplibre_ios/lib/src/maplibre_ffi.g.dart`
- Regenerate: `packages/maplibre_ios/lib/src/maplibre_ffi.g.dart.m`

**Interfaces:**
- Consumes: a validated FeatureCollection string.
- Produces: `Helpers.parseComputedGeoJsonFeatures(raw:)`, `MLNComputedShapeSource`, and `MLNComputedShapeSourceDataSource` FFI bindings.

- [ ] **Step 1: Add the narrow Swift helper**

```swift
@objc public static func parseComputedGeoJsonFeatures(
    raw: String
) -> NSArray? {
    guard let data = raw.data(using: .utf8) else {
        return nil
    }
    do {
        let shape = try MLNShape(
            data: data,
            encoding: String.Encoding.utf8.rawValue
        )
        guard let collection = shape as? MLNShapeCollectionFeature else {
            return nil
        }
        return collection.shapes as NSArray
    } catch {
        return nil
    }
}
```

The helper returns nil rather than printing or throwing across FFI; Dart
reports the typed native-conversion error.

- [ ] **Step 2: Regenerate the Swift header**

```bash
cd packages/maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios
./gen_swift_headers.sh
rg -n "parseComputedGeoJsonFeatures" MapLibreIos.h
```

Expected: the generated Objective-C `Helpers` interface exposes the method.

- [ ] **Step 3: Expand ffigen allowlists**

Add `MLNComputedShapeSource.h` to the header set,
`MLNComputedShapeSource` to interfaces, and
`MLNComputedShapeSourceDataSource` to protocols. Do not add
`MLNShapeCollectionFeature`: the helper's public return type is `NSArray`, so
the generated Dart interface does not expose that subtype.

- [ ] **Step 4: Regenerate FFI and inspect the blocking callback**

```bash
cd packages/maplibre_ios
mise exec -- dart tool/ffigen.dart
rg -n "MLNComputedShapeSourceDataSource.*implementAsBlocking" lib/src/maplibre_ffi.g.dart
rg -n "computedShapeSource_featuresInCoordinateBounds_zoomLevel_" lib/src/maplibre_ffi.g.dart
```

Expected: the protocol has an `implementAsBlocking` builder member named
`computedShapeSource_featuresInCoordinateBounds_zoomLevel_`.

- [ ] **Step 5: Commit helper and generated bindings**

```bash
git add packages/maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/Helpers.swift
git add packages/maplibre_ios/ios/maplibre_ios/Sources/maplibre_ios/MapLibreIos.h
git add packages/maplibre_ios/tool/ffigen.dart
git add packages/maplibre_ios/lib/src/maplibre_ffi.g.dart
git add packages/maplibre_ios/lib/src/maplibre_ffi.g.dart.m
git commit -m "build: Computed shape FFI bindingを生成"
```

---

### Task F3.2: iOS callback adapter and lifecycle

**Files:**
- Create: `packages/maplibre_ios/lib/src/computed_geo_json_source.dart`
- Modify: `packages/maplibre_ios/lib/src/map_state.dart`
- Modify: `packages/maplibre_ios/lib/src/style_controller.dart`

**Interfaces:**
- Consumes: F1 source contract and F3.1 generated FFI.
- Produces: retained `_ComputedGeoJsonSourceIosBinding` and iOS invalidation overrides.

- [ ] **Step 1: Register the part and retained binding map**

Add `part 'computed_geo_json_source.dart';` to `map_state.dart` and:

```dart
final _computedGeoJsonSources =
    <String, _ComputedGeoJsonSourceIosBinding>{};
```

- [ ] **Step 2: Implement the blocking data source**

Create `MLNComputedShapeSourceDataSource.implementAsBlocking` with only
`computedShapeSource_featuresInCoordinateBounds_zoomLevel_`. Ignore the
native source argument, convert `MLNCoordinateBounds` to `LngLatBounds`,
convert `zoomLevel` to `int`, and call `source.computeGeoJson`.

Pass the returned string to
`Helpers.parseComputedGeoJsonFeaturesWithRaw(...toNSString())`. When the
binding is inactive, return an initialized empty `NSArray` without
notification. When the helper returns nil, call
`source.recoverFromError(kind: nativeConversion, ...)` and return an empty
`NSArray`.

- [ ] **Step 3: Construct the computed source and options**

Create an `NSMutableDictionary` and set only non-null values with these
MapLibre keys:

```text
MLNComputedShapeSourceOptionMinimumZoomLevel
MLNComputedShapeSourceOptionMaximumZoomLevel
MLNComputedShapeSourceOptionBuffer
MLNComputedShapeSourceOptionSimplificationTolerance
MLNComputedShapeSourceOptionWrapsCoordinates
MLNComputedShapeSourceOptionClipsCoordinates
```

Initialize `MLNComputedShapeSource` with identifier, data source, and options,
add it to the style, and retain a binding containing the Dart source, native
source, and data-source proxy. If style insertion throws, deactivate the
binding before rethrowing.

- [ ] **Step 4: Implement invalidation/removal/dispose**

Region invalidation calls Native `invalidateBounds`. Tile invalidation calls
`invalidateTileAtX(x, y: y, zoomLevel: zoomLevel)`. A missing ID throws
`StateError('Computed source "$id" does not exist.')`.

On `removeSource`, deactivate the binding before removing the native source,
then drop the strong proxy reference in `finally`. On controller `dispose`,
deactivate and clear all bindings. This ordering prevents a worker callback
from entering a released Dart provider.

- [ ] **Step 5: Run the shared iOS integration test**

```bash
cd examples
mise exec -- flutter test integration_test/main.dart -d "iPhone 16 Pro" --timeout=1800s -r expanded
```

Expected: the same callback/render/invalidation/error scenario that passed on
Android passes on iOS.

- [ ] **Step 6: Commit iOS implementation**

```bash
git add packages/maplibre_ios/lib/src/map_state.dart
git add packages/maplibre_ios/lib/src/style_controller.dart
git add packages/maplibre_ios/lib/src/computed_geo_json_source.dart
git commit -m "feat: iOS computed sourceを実装"
```

---

### Task F3.3: Public example and source documentation

**Files:**
- Create: `examples/lib/style_sources_computed_geo_json_page.dart`
- Modify: `examples/lib/main.dart`
- Modify: `examples/lib/menu_page.dart`
- Modify: `website/docs/sources.md`
- Modify: `packages/maplibre/CHANGELOG.md`
- Modify: `packages/maplibre_ios/CHANGELOG.md`

**Interfaces:**
- Consumes: completed iOS/Android API.
- Produces: asset-free usage example and user-facing constraints.

- [ ] **Step 1: Add the computed grid example**

Create a stateful page at
`/style-sources/computed-geo-json`. In `onStyleLoaded`, add a
`ComputedGeoJsonSource` whose provider generates longitude/latitude lines at
10-degree intervals within the requested bounds, then add a blue
`LineStyleLayer`. Report errors with `debugPrint` in the example only.
Guard the menu item with iOS/Android platform support so Web/desktop example
builds do not invoke the source.

- [ ] **Step 2: Document source behavior**

In `website/docs/sources.md`, include:

- exact provider signature;
- FeatureCollection-only return;
- synchronous/no-I/O warning;
- `onError` and empty-tile behavior;
- region/tile invalidation examples;
- iOS/Android support and explicit Web/desktop `UnsupportedError`.

- [ ] **Step 3: Add Unreleased notes**

Update the main and iOS changelogs. The main entry now states both mobile
backends are implemented.

- [ ] **Step 4: Verify example and docs changes**

```bash
mise exec -- dart format --set-exit-if-changed examples/lib
mise exec -- dart analyze --fatal-warnings --fatal-infos
cd examples
mise exec -- flutter build apk
mise exec -- flutter build ios --simulator --no-codesign
mise exec -- flutter build web
```

- [ ] **Step 5: Commit docs/example**

```bash
git add examples/lib/style_sources_computed_geo_json_page.dart
git add examples/lib/main.dart examples/lib/menu_page.dart
git add website/docs/sources.md packages/maplibre/CHANGELOG.md packages/maplibre_ios/CHANGELOG.md
git commit -m "docs: Computed sourceの使用例を追加"
```

---

### Task F3.4: iOS integration/codegen CI and final fork PR

**Files:**
- Modify: `.github/workflows/ci.yml`

**Interfaces:**
- Consumes: all F1-F3 implementation.
- Produces: cross-platform required checks and F3 PR.

- [ ] **Step 1: Enable one focused iOS integration job**

Uncomment `integration-test-ios`, reduce the matrix to the maintained
`26.2` simulator runtime, keep the 30-minute timeout, and run the shared
`integration_test/main.dart`.

- [ ] **Step 2: Enable deterministic iOS codegen**

Uncomment `codegen-ios`. Clone `maplibre/maplibre-native` at the exact
`ios-v6.27.0` tag with `--branch ios-v6.27.0 --depth 1`, build that framework,
regenerate `MapLibreIos.h`, run ffigen, and fail on any uncommitted generated
diff. Keep the tag synchronized with both `Package.swift` and the podspec; do
not generate against a moving Native revision.

- [ ] **Step 3: Run the full local gate**

```bash
mise exec -- dart format --set-exit-if-changed .
mise exec -- dart analyze --fatal-warnings --fatal-infos
cd packages/maplibre
mise exec -- flutter test
cd ../maplibre_webview
mise exec -- flutter test
cd ../../examples
mise exec -- flutter build apk
mise exec -- flutter build ios --simulator --no-codesign
mise exec -- flutter build web
```

Regenerate both bindings and require a clean diff before committing.

- [ ] **Step 4: Commit CI**

```bash
git add .github/workflows/ci.yml
git commit -m "ci: iOS computed sourceを実機検証"
```

- [ ] **Step 5: Push and create F3 only in the fork**

```bash
git remote get-url origin
git push -u origin codex/computed-geojson-ios
gh pr create --repo YumNumm/flutter-maplibre --base codex/computed-geojson-android --head codex/computed-geojson-ios --draft --title "feat: iOS computed GeoJSON source" --body-file /tmp/flutter-maplibre-f3.md
```

- [ ] **Step 6: Read back all three PRs**

Confirm repository owner, base/head branches, draft state, check runs, and
cross-links. If any PR targets `maplibre/flutter-maplibre`, close it
immediately without pushing another branch there and report the incident.
