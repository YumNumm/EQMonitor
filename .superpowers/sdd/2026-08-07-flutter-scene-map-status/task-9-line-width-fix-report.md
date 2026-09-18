# Task 9: Line width orientation fix report

## Status

DONE

## Commands run

```bash
cd /home/yumnumm/EQMonitor && mise exec -- dart pub get && cd packages/eqmonitor_map && mise exec -- flutter test test/flutter_scene/base_map_geometry_factory_test.dart
cd /home/yumnumm/EQMonitor && mise exec -- dart format packages/eqmonitor_map/lib/src/flutter_scene/base_map_geometry_factory.dart packages/eqmonitor_map/test/flutter_scene/base_map_geometry_factory_test.dart && cd packages/eqmonitor_map && mise exec -- flutter test test/flutter_scene/base_map_geometry_factory_test.dart
cd /home/yumnumm/EQMonitor/packages/eqmonitor_map && mise exec -- flutter test
```

## Failing test output before fix

The new pure arithmetic regression test failed before production code changes, as expected:

```text
00:00 +6: buildLineGeometryArgs line extrudeがscreen logical pxで線分に直交し半幅を保つ
00:00 +6 -1: buildLineGeometryArgs line extrudeがscreen logical pxで線分に直交し半幅を保つ [E]
  Expected: a numeric value within <0.000001> of <0>
    Actual: <-7.000000013281294>
     Which:  differs by <7.000000013281294>
  45deg offset must be perpendicular

  package:matcher                                               expect
  package:flutter_test/src/widget_tester.dart 473:18            expect
  test/flutter_scene/base_map_geometry_factory_test.dart 212:9  main.<fn>.<fn>

00:00 +10 -1: Some tests failed.
```

This verifies the confirmed bug: with half width 7 logical px, the 45-degree offset is not perpendicular and is instead aligned with the segment direction.

## Change made

The fix is applied in `BaseMapGeometryFactory.buildLineGeometryArgs`, not inside `base_map_line.fmat`.

`LineMeshBuilder` remains responsible for generating tile-local Y-down line normals from MVT geometry. The Flutter Scene adapter is the boundary where those mesh attributes become shader `texCoords`, so it now flips the Y component there and passes clip/NDC Y-up extrude vectors to the material. This keeps the coordinate-space conversion in Dart, covered by tests, rather than hiding the bug fix exclusively in an `.fmat` file.

Doc comments were updated at the producer and consumer boundaries:

- `LineMeshBuilder` documents that it produces tile-local Y-down extrude normals.
- `BaseMapGeometryFactory` documents that it converts those normals to clip/NDC Y-up before `texCoords`.
- `base_map_line.fmat` documents that `vertex.uv` carries a clip/NDC-space extrude vector, not raw tile-local normals.

The existing `buildLineGeometryArgs` test was updated to assert the Y flip, and a new pure arithmetic test models:

`tile-local segment direction -> LineMeshBuilder normal -> buildLineGeometryArgs texCoords -> shader NDC offset -> screen logical px offset`

It covers horizontal, vertical, 45-degree, 30-degree, and 135-degree segments and asserts both perpendicularity and constant half-width.

## Passing test output after fix

Targeted test:

```text
Formatted 2 files (0 changed) in 0.09 seconds.
00:00 +6: buildLineGeometryArgs line extrudeがscreen logical pxで線分に直交し半幅を保つ
00:00 +7: halfLineWidthNdcFor logical pixelの半線幅をNDC単位のvec2へ換算する
00:00 +8: halfLineWidthNdcFor 0を渡すと(0, 0)を返す
00:00 +9: halfLineWidthNdcFor 負値はArgumentErrorを投げる
00:00 +10: halfLineWidthNdcFor 非finite値はArgumentErrorを投げる
00:00 +11: All tests passed!
```

Full package suite:

```text
00:08 +210: All tests passed!
```

## TODO recorded

Created `docs/todo/700_eqmonitor_map_line_extrude_projection.md`.

It records that the current Y-flip contract is correct only for the current orthographic, north-locked projection, and that the MapLibre-style matrix-transformed extrude is required before pitch, bearing, or perspective are introduced. It references `docs/knowledge/20260805_maplibre_native_renderer_reference.md`.

## Concerns

No concerns for the current scoped fix.

The known limitation is intentionally deferred: if the renderer later gains pitch, bearing, or perspective, this boundary Y flip must be replaced with a matrix-transformed extrude design before shipping that behavior.

## Review fix

Updated only `packages/eqmonitor_map/lib/src/mesh/line_mesh.dart` doc comments to match the current contract: `LineMeshBuilder` stores tile-local Y-down extrude vectors, and `BaseMapGeometryFactory` flips Y before passing them through `texCoords` for the current orthographic, north-locked Flutter Scene projection. The comments now point readers to `BaseMapGeometryFactory` and todo 700 for the deferred MapLibre-style matrix-transformed extrude redesign.

No code logic changed.
