# Computed GeoJSON Source and Latitude/Longitude Grid Design

## Goal

Add a generic, synchronous computed GeoJSON source to the
`YumNumm/flutter-maplibre` fork for iOS and Android, then use it in EQMonitor
to render an optional latitude/longitude grid on the home and live-monitor
maps.

All work stays in repositories owned by `YumNumm`. Do not push branches or
open pull requests against the `maplibre/flutter-maplibre` upstream
repository.

## Scope

### flutter-maplibre

- Add one platform-neutral `ComputedGeoJsonSource` API.
- Accept a synchronous provider with named `bounds` and `zoomLevel`
  parameters.
- Support region and tile invalidation.
- Implement the source with Android `CustomGeometrySource` and iOS
  `MLNComputedShapeSource`.
- Report provider, GeoJSON parsing, and native conversion failures before
  returning an empty tile.
- Throw an explicit `UnsupportedError` on Web and desktop implementations.
- Add API documentation, a minimal example, unit tests, native integration
  tests, and generated-binding checks.

### EQMonitor

- Pin `maplibre` to the completed fork commit before adding the feature.
- Add an opt-in grid to the home and live-monitor maps only.
- Draw lines without coordinate labels in the first release.
- Keep the grid behind all earthquake, tsunami, intensity, hypocenter,
  observation, and wave layers.
- Keep all other maps, including detail and bounds-selection maps, unchanged.
- Do not implement a Flutter canvas or camera-event fallback on unsupported
  platforms.

## Non-goals

- A public API that exposes JNI or Objective-C generated binding types.
- Asynchronous source providers, isolates, network access, or storage access
  inside a tile callback.
- Manual `setTileData` support in the first API version.
- PluginLayer/Metal rendering.
- Web or desktop grid rendering.
- Coordinate labels, user-configurable intervals, colors, widths, or opacity
  in the first EQMonitor release.
- Automatic rollout to every `MapLibreMap` in EQMonitor.
- Any upstream `maplibre/flutter-maplibre` branch, push, issue, or pull request.

## Chosen Architecture

Use a common Dart API with platform-specific callback adapters. This keeps
native ownership and conversion details inside each backend while giving
applications one source model and one invalidation contract.

The alternatives were rejected for the following reasons:

- Exposing raw JNI/Objective-C types would make application code
  platform-specific and leak generated binding lifecycles into consumers.
- Implementing all native behavior directly in handwritten FFI without a
  narrow conversion helper would increase Objective-C collection bridging
  complexity without adding application capability.
- Rendering in Flutter from camera events would duplicate MapLibre's tile
  scheduling, projection, clipping, and cache invalidation behavior.

## Public Dart API

The public API is owned by `maplibre_platform_interface` and exported by
`maplibre`.

```dart
typedef ComputedGeoJsonProvider = String Function({
  required LngLatBounds bounds,
  required int zoomLevel,
});

typedef ComputedGeoJsonErrorCallback = void Function(
  ComputedGeoJsonSourceError error,
);

final class ComputedGeoJsonSource extends Source {
  const ComputedGeoJsonSource({
    required super.id,
    required this.provider,
    this.onError,
    this.minZoom,
    this.maxZoom,
    this.buffer,
    this.tolerance,
    this.wrapsCoordinates,
    this.clipsCoordinates,
  });

  final ComputedGeoJsonProvider provider;
  final ComputedGeoJsonErrorCallback? onError;
  final int? minZoom;
  final int? maxZoom;
  final int? buffer;
  final double? tolerance;
  final bool? wrapsCoordinates;
  final bool? clipsCoordinates;
}
```

Nullable options mean "use the native SDK default". Neither the plugin nor
EQMonitor substitutes fixed fallback values for omitted native options.

`ComputedGeoJsonSourceError` contains a source ID, an error kind, a safe
message, and a stack trace. Its error kinds distinguish provider execution,
invalid GeoJSON, and native conversion failures. It does not
expose JNI, Objective-C, or unconstrained `Object` values.

`StyleController` adds:

```dart
Future<void> invalidateComputedGeoJsonSourceRegion({
  required String id,
  required LngLatBounds bounds,
});

Future<void> invalidateComputedGeoJsonSourceTile({
  required String id,
  required int x,
  required int y,
  required int zoomLevel,
});
```

Invalidating an absent source or a source of another type throws a
`StateError` containing the source ID. Web and desktop controllers throw
`UnsupportedError` before performing any native or JavaScript operation.

The provider must return a GeoJSON `FeatureCollection` string. A single
feature, a bare geometry, and malformed JSON are errors rather than being
implicitly converted differently on each platform.

## Android Backend

The Android backend uses MapLibre Native's `CustomGeometrySource`,
`CustomGeometrySourceOptions`, and `GeometryTileProvider`.

1. Add `org.maplibre.geojson.FeatureCollection` to the jnigen class list and
   regenerate bindings.
2. Create a `GeometryTileProvider.implement` adapter for each computed source.
3. Convert native bounds to `LngLatBounds` and forward the native integer zoom
   as `zoomLevel`.
4. Parse the provider string with `FeatureCollection.fromJson`.
5. Keep the JNI provider proxy and source registration strongly referenced by
   source ID.
6. Forward region/tile invalidation to the corresponding native methods.
7. Release references on source removal, style replacement, and controller
   disposal.

## iOS Backend

The iOS backend uses `MLNComputedShapeSource` and the bounds-based
`MLNComputedShapeSourceDataSource` callback.

1. Add `MLNComputedShapeSource.h`, `MLNComputedShapeSource`, and
   `MLNComputedShapeSourceDataSource` to the ffigen allowlists and regenerate
   the Objective-C bindings.
2. Implement exactly the bounds/zoom data-source callback with
   `implementAsBlocking`, because MapLibre requests data synchronously from its
   source request queue.
3. Add a narrow helper alongside the existing iOS helpers that parses a
   GeoJSON `FeatureCollection` string and returns the Objective-C feature
   array required by the data-source callback.
4. Keep the data-source adapter strongly referenced by source ID because the
   native source's `dataSource` reference is weak.
5. Forward region/tile invalidation to `MLNComputedShapeSource`.
6. Invalidate the Dart adapter before releasing it on source removal, style
   replacement, and controller disposal.

No callback dispatches to the main isolate for UI work. Provider code must be
small, deterministic, synchronous, and free of I/O.

## Lifecycle and Error Handling

Adding a source creates both the native source and its callback adapter.
Removing the source marks the adapter invalid before native and Dart
references are released. A callback that was already in flight when removal
began returns an empty FeatureCollection without reporting an application
error, because removal is an expected lifecycle event.

For all other failures:

1. Wrap the failure as `ComputedGeoJsonSourceError`.
2. Invoke `onError` when supplied; otherwise call `FlutterError.reportError`.
3. Return an empty FeatureCollection for that tile only.
4. Continue serving other tiles and other map layers.

Errors are never silently swallowed. One bad grid tile must not remove or
block EEW, tsunami, intensity, hypocenter, observation, or P/S-wave layers.

## EQMonitor Grid Generation

`LatLngGridGeoJsonBuilder` is a pure, synchronous class in the shared map
feature. It depends on neither Riverpod, widgets, `MapController`, nor I/O.
Its input is `LngLatBounds` and `int zoomLevel`; its output is a GeoJSON
`FeatureCollection` containing horizontal and vertical `LineString` features.

The builder selects a globally consistent interval from this descending list:

```text
90, 45, 30, 15, 10, 5, 2, 1, 0.5, 0.25, 0.1, 0.05, 0.025, 0.01 degrees
```

For a zoom level `z`, compute the equatorial tile longitude span as
`360 / 2^z`. Select the smallest listed interval that is greater than or
equal to one eighth of that span, capped at 90 degrees and floored at 0.01
degrees. Because the choice depends only on integer zoom, adjacent native
tiles use the same grid interval. A request produces no more than 20 line
features; exceeding that invariant is treated as an error rather than
silently dropping arbitrary lines.

Coordinates snap to integer multiples of the chosen interval. Bounds that
cross the antimeridian are split into `[west, 180]` and `[-180, east]`, with
the antimeridian emitted only once. Input longitude must be in
`[-180, 180]`, input latitude must be in `[-90, 90]`, and zoom must be in
`[0, 30]`. Valid latitude bounds are intersected with MapLibre's Web Mercator
domain of `[-85.0511287798066, 85.0511287798066]`; an empty intersection
returns an empty FeatureCollection. Non-finite coordinates, reversed latitude
bounds, out-of-range coordinates or zoom, malformed bounds, and violated
feature limits throw. The plugin adapter reports the failure and returns an
empty tile; the builder does not substitute Japan or another fixed region.

The provider object only binds this builder to the plugin callback signature.
It does not call `ref.read`, `ref.watch`, `compute`, logging, storage, or a
network API from the callback.

## EQMonitor Presentation and Settings

`LatLngGridLayer` owns source/layer registration and cleanup. It uses the
existing map operation queue and removes resources in layer-then-source order.
It uses one computed source and one line layer with stable IDs.

The layer is inserted into the shared home/live-monitor map composition below
all safety-related overlays. It uses `ColorScheme.outlineVariant`, a
1-logical-pixel line width, and 0.30 opacity in both light and dark themes.
There are no labels. Layer errors are reported through Talker without
presenting raw exceptions to users.

Grid enablement is stored as a separate `HomeMapGridSettings` field on
`HomeConfigurationModel`, defaulting to `enabled: false`. The existing
home-configuration preference key remains in use, so no new hard-coded
storage key is introduced. A dedicated notifier mutation persists changes.
Keeping the setting outside `HomeMapSettings` prevents the grid toggle from
changing the existing map instance identity and remounting or refocusing the
map.

The settings page exposes one enable/disable switch on iOS and Android. The
switch is hidden and the grid layer is not mounted on unsupported platforms;
EQMonitor never invokes the unsupported plugin API as a fallback path.

## Stacked Pull Requests

The two repositories have separate stacks.

### YumNumm/flutter-maplibre stack

1. **F1: Common contract and unsupported implementations**
   - Public source, callback, error, and invalidation contracts.
   - Web/desktop `UnsupportedError` behavior.
   - Exports, Dartdoc, and contract unit tests.
2. **F2: Android backend**
   - jnigen configuration and generated bindings.
   - Custom geometry source, lifecycle, errors, and invalidation.
   - Android integration tests.
3. **F3: iOS backend and cross-platform documentation**
   - ffigen configuration, generated bindings, and narrow GeoJSON helper.
   - Computed shape source, lifecycle, errors, and invalidation.
   - iOS integration tests, example, website docs, and changelog entries.

Branches are based on the preceding branch. Pull requests target only the
`YumNumm/flutter-maplibre` default branch or the preceding branch in that same
repository. Work starts from the fork's current default branch, not the old
pub-cache checkout pinned by EQMonitor.

### YumNumm/EQMonitor stack

1. **E1: Pin and compatibility verification**
   - Update `maplibre` to the exact F3 commit SHA.
   - Make only compatibility changes required by that dependency update.
   - Run existing map regression tests and Android/iOS builds.
2. **E2: Latitude/longitude grid**
   - Builder, provider, settings, layer, home/live integration, tests, and
     operational knowledge documentation.

E2 is based on E1. While the plugin stack is open, E1 uses the immutable F3
commit SHA. After the plugin stack is merged, E1 receives a follow-up commit
that pins the final merged SHA. No mutable branch reference is used in
`pubspec.yaml`.

## Testing

### flutter-maplibre contract tests

- Source constructor and option preservation.
- Exact callback signature with named `bounds` and integer `zoomLevel`.
- Error structure and default reporting path.
- Web and webview/desktop controllers throw `UnsupportedError` before bridge
  access.
- Invalidating a missing or wrong source type throws the documented exception.

### Native adapter tests

- Bounds conversion, including antimeridian semantics.
- Valid FeatureCollection conversion.
- Provider throw, malformed JSON, wrong GeoJSON root, and native conversion
  failure each report once and return an empty tile.
- An invalidated/disposed adapter returns empty without reporting a spurious
  error.
- Source removal and style replacement release retained callbacks.

### Mobile integration tests

Use a minimal style, computed line source, and line layer. Record callback
arguments with a timeout and verify:

- The callback is invoked with finite ordered bounds and an integer zoom.
- The returned line is returned by a rendered-feature query.
- Region invalidation requests data again.
- Tile invalidation requests data again.
- Removing the source stops new callbacks and does not crash.
- Provider failure affects only the requested tile.

Run the shared scenario on Android and iOS. Register the test explicitly in
the integration-test entry point. Enable one focused iOS simulator integration
job instead of relying on an iOS build alone.

### EQMonitor tests

- Interval selection at every zoom boundary.
- Coordinate ordering is `[longitude, latitude]`.
- Snap/clip behavior, tiny bounds, antimeridian crossing, `-180`/`180`, and
  high-latitude bounds.
- Invalid bounds and feature-limit violations fail closed through the plugin
  error path.
- Identical input produces byte-identical output.
- The builder remains within the feature-count limit on representative
  worst-case inputs.
- Older saved configuration without `mapGrid` decodes to disabled.
- Save/reload and rapid toggle behavior.
- Grid toggling does not remount or refocus the map.
- Source-before-layer creation and layer-before-source removal.
- Repeated mount, unmount, style replacement, and rapid toggle leave no
  duplicate IDs or retained source.
- Grid failure leaves all safety-related layers registered.
- Light/dark visual checks confirm that the grid remains subordinate to
  safety-related overlays.

## CI and Verification

The flutter-maplibre stack runs formatting, analysis, Swift formatting,
Kotlin lint, package unit tests, Android integration on the maintained API
levels, a focused iOS simulator integration test, Android/iOS builds,
Web/WASM/macOS/Windows builds, and Web/webview unsupported-contract tests.

Both jnigen and ffigen are regenerated from configuration. CI regenerates them
and requires a clean `git diff`, so generated files are never maintained as
handwritten patches.

The EQMonitor stack runs the repository's Flutter status check, focused grid
and map lifecycle tests, the full workspace test suite, Android debug build,
and iOS simulator build. All Flutter and Dart commands run through
`mise exec --`.

## Documentation and Operational Knowledge

The plugin adds Dartdoc, a `website/docs/sources.md` section, changelog entries,
and an asset-free example that draws a computed grid.

EQMonitor adds
`docs/knowledge/20260802_maplibre_computed_geojson_source.md` during
implementation. It records callback synchronization, native ownership,
platform support, binding regeneration, and verification commands. The grid
is also added to `docs/map-architecture.md`.

## Success Criteria

- The same Dart source declaration works on iOS and Android.
- Native map movement requests only the visible computed tiles without a
  Flutter camera-event rendering loop.
- Both invalidation methods cause native data to be recomputed.
- Provider failures are observable and isolated to the grid tile.
- Removing or replacing a style does not leave callable native adapters.
- Unsupported platforms fail explicitly at the plugin boundary and EQMonitor
  does not call that boundary.
- The opt-in grid works on home and live-monitor maps without remounting the
  map or obscuring safety-related layers.
- Every PR remains reviewable and verifiable independently in dependency
  order.
