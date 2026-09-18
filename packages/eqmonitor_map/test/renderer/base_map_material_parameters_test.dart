import 'dart:typed_data';
import 'dart:ui';

import 'package:eqmonitor_map/src/geo/map_viewport.dart';
import 'package:eqmonitor_map/src/renderer/base_map_material_parameters.dart';
import 'package:eqmonitor_map/src/tile/base_map_tile_decoder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final viewport = MapViewport(
    logicalSize: const Size(400, 800),
    devicePixelRatio: 2,
  );

  group('baseMapLineHalfWidthNdc', () {
    test('scales each axis by its own logical extent', () {
      final ndc = baseMapLineHalfWidthNdc(
        halfWidthLogicalPixels: 1,
        viewport: viewport,
      );

      expect(ndc.x, closeTo(2 / 400, 1e-12));
      expect(ndc.y, closeTo(2 / 800, 1e-12));
    });

    test('does not depend on the device pixel ratio', () {
      final doubled = baseMapLineHalfWidthNdc(
        halfWidthLogicalPixels: 1,
        viewport: MapViewport(
          logicalSize: const Size(400, 800),
          devicePixelRatio: 4,
        ),
      );

      expect(
        doubled,
        baseMapLineHalfWidthNdc(
          halfWidthLogicalPixels: 1,
          viewport: viewport,
        ),
      );
    });

    test('accepts zero and rejects negative or non-finite widths', () {
      expect(
        baseMapLineHalfWidthNdc(
          halfWidthLogicalPixels: 0,
          viewport: viewport,
        ),
        (x: 0.0, y: 0.0),
      );
      expect(
        () => baseMapLineHalfWidthNdc(
          halfWidthLogicalPixels: -1,
          viewport: viewport,
        ),
        throwsArgumentError,
      );
      expect(
        () => baseMapLineHalfWidthNdc(
          halfWidthLogicalPixels: double.nan,
          viewport: viewport,
        ),
        throwsArgumentError,
      );
    });
  });

  group('fill uniforms', () {
    test('round-trips the layer color', () {
      const color = Color(0xFFDCD6C9);

      final decoded = decodeBaseMapFillMaterialBytes(
        encodeBaseMapFillMaterialBytes(color: color),
      );

      expect(decoded.color.r, closeTo(color.r, 1e-6));
      expect(decoded.color.g, closeTo(color.g, 1e-6));
      expect(decoded.color.b, closeTo(color.b, 1e-6));
      expect(decoded.color.a, closeTo(color.a, 1e-6));
    });

    test('occupies exactly the declared byte length', () {
      expect(
        encodeBaseMapFillMaterialBytes(color: const Color(0xFF000000)).length,
        baseMapFillMaterialByteLength,
      );
    });

    test('rejects bytes of the wrong length', () {
      expect(
        () => decodeBaseMapFillMaterialBytes(Uint8List(8)),
        throwsArgumentError,
      );
    });
  });

  group('line uniforms', () {
    test('round-trips the color and the CPU-resolved half width', () {
      const color = Color(0xFFFF7043);

      final decoded = decodeBaseMapLineMaterialBytes(
        encodeBaseMapLineMaterialBytes(
          color: color,
          halfWidthLogicalPixels: 1.5,
          viewport: viewport,
        ),
      );

      expect(decoded.color.r, closeTo(color.r, 1e-6));
      expect(decoded.halfWidthNdcX, closeTo(2 * 1.5 / 400, 1e-6));
      expect(decoded.halfWidthNdcY, closeTo(2 * 1.5 / 800, 1e-6));
    });

    test('occupies exactly the declared byte length', () {
      expect(
        encodeBaseMapLineMaterialBytes(
          color: const Color(0xFF000000),
          halfWidthLogicalPixels: 1,
          viewport: viewport,
        ).length,
        baseMapLineMaterialByteLength,
      );
    });

    test('changes bytes when the viewport changes', () {
      final portrait = encodeBaseMapLineMaterialBytes(
        color: const Color(0xFF000000),
        halfWidthLogicalPixels: 1,
        viewport: viewport,
      );
      final landscape = encodeBaseMapLineMaterialBytes(
        color: const Color(0xFF000000),
        halfWidthLogicalPixels: 1,
        viewport: MapViewport(
          logicalSize: const Size(800, 400),
          devicePixelRatio: 2,
        ),
      );

      expect(portrait, isNot(landscape));
    });

    test('rejects bytes of the fill length', () {
      expect(
        () => decodeBaseMapLineMaterialBytes(
          Uint8List(baseMapFillMaterialByteLength),
        ),
        throwsArgumentError,
      );
    });
  });

  group('baseMapMaterialParametersFor', () {
    BaseMapLayerSpec specOf(String styleLayerId) =>
        baseMapLayerSpecs.singleWhere(
          (spec) => spec.styleLayerId == styleLayerId,
        );

    test('uses the fill encoding for fill layers', () {
      final block = baseMapMaterialParametersFor(
        spec: specOf('countriesFill'),
        lineHalfWidthLogicalPixels: 1,
        viewport: viewport,
      );

      expect(block.version, baseMapMaterialParameterVersion);
      expect(block.bytes.length, baseMapFillMaterialByteLength);
    });

    test('uses the line encoding for line layers', () {
      final block = baseMapMaterialParametersFor(
        spec: specOf('countriesLine'),
        lineHalfWidthLogicalPixels: 1,
        viewport: viewport,
      );

      expect(block.bytes.length, baseMapLineMaterialByteLength);
    });

    test('distinct layer colors produce distinct uniform bytes', () {
      final countries = baseMapMaterialParametersFor(
        spec: specOf('countriesFill'),
        lineHalfWidthLogicalPixels: 1,
        viewport: viewport,
      );
      final areaForecast = baseMapMaterialParametersFor(
        spec: specOf('areaForecastLocalEFill'),
        lineHalfWidthLogicalPixels: 1,
        viewport: viewport,
      );

      expect(countries.bytes, isNot(areaForecast.bytes));
    });

    test('rejects the background spec, which has no material', () {
      expect(
        () => baseMapMaterialParametersFor(
          spec: specOf('background'),
          lineHalfWidthLogicalPixels: 1,
          viewport: viewport,
        ),
        throwsArgumentError,
      );
    });
  });
}
