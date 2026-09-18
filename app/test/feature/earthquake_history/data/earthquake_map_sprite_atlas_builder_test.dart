import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_map_sprite_atlas_builder.dart';
import 'package:eqmonitor/feature/earthquake_history/data/provider/earthquake_map_sprite_atlas_provider.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _limits = MapSpriteAtlasLimits(
  maxWidth: 32,
  maxHeight: 32,
  maxPixelBytes: 32 * 32 * 4,
  maxRegions: 2,
);

EarthquakeMapSpriteImage _image({
  required int width,
  required int height,
  required List<int> rgbaBytes,
}) => EarthquakeMapSpriteImage(
  width: width,
  height: height,
  rgbaBytes: Uint8List.fromList(rgbaBytes),
);

List<int> _pixel(MapSpriteAtlas atlas, {required int x, required int y}) {
  final offset = (y * atlas.width + x) * MapSpriteAtlas.bytesPerPixel;
  return atlas.rgbaBytes.sublist(offset, offset + MapSpriteAtlas.bytesPerPixel);
}

final class _CountingAssetBundle extends CachingAssetBundle {
  final loadedPaths = <String>[];

  @override
  Future<ByteData> load(String key) async {
    loadedPaths.add(key);
    return ByteData.sublistView(Uint8List.fromList(const [1, 2, 3]));
  }
}

final class _CountingImageDecoder implements EarthquakeMapSpriteImageDecoder {
  final decodedPaths = <String>[];

  @override
  Future<EarthquakeMapSpriteImage> decode({
    required String assetPath,
    required Uint8List encodedBytes,
  }) async {
    decodedPaths.add(assetPath);
    return _image(
      width: 1,
      height: 1,
      rgbaBytes: assetPath == Assets.images.map.normalHypocenter.path
          ? const [255, 0, 0, 128]
          : const [0, 0, 255, 255],
    );
  }
}

final class _ThrowingAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) => throw FlutterError('fixture failure');
}

final class _UnexpectedErrorAssetBundle extends CachingAssetBundle {
  @override
  Future<ByteData> load(String key) => throw StateError('programming error');
}

void main() {
  const builder = EarthquakeMapSpriteAtlasBuilder();
  final normal = _image(
    width: 2,
    height: 2,
    rgbaBytes: const [
      255,
      0,
      0,
      255,
      0,
      255,
      0,
      128,
      0,
      0,
      255,
      255,
      255,
      255,
      255,
      255,
    ],
  );
  final lowPrecision = _image(
    width: 1,
    height: 1,
    rgbaBytes: const [12, 34, 56, 78],
  );

  MapSpriteAtlas build({
    EarthquakeMapSpriteImage? normalImage,
    MapSpriteAtlasLimits limits = _limits,
  }) => builder.build(
    normalImage: normalImage ?? normal,
    lowPrecisionImage: lowPrecision,
    limits: limits,
  );

  test('image dimensionとtight RGBA byte countをallocation前に拒否する', () {
    expect(
      () => _image(width: 0, height: 1, rgbaBytes: const []),
      throwsArgumentError,
    );
    expect(
      () => _image(width: 1, height: 0, rgbaBytes: const []),
      throwsArgumentError,
    );
    expect(
      () => _image(width: 1, height: 1, rgbaBytes: const [1, 2, 3]),
      throwsArgumentError,
    );
    expect(
      () => _image(width: 1 << 62, height: 1 << 62, rgbaBytes: const []),
      throwsArgumentError,
    );
  });

  test('top-left RGBAを保ち各regionの端を2px extrusionする', () {
    final atlas = build();

    expect((atlas.width, atlas.height), (11, 6));
    expect(_pixel(atlas, x: 0, y: 0), [255, 0, 0, 255]);
    expect(_pixel(atlas, x: 2, y: 2), [255, 0, 0, 255]);
    expect(_pixel(atlas, x: 3, y: 2), [0, 255, 0, 128]);
    expect(_pixel(atlas, x: 2, y: 3), [0, 0, 255, 255]);
    expect(_pixel(atlas, x: 5, y: 5), [255, 255, 255, 255]);
    expect(_pixel(atlas, x: 6, y: 0), [12, 34, 56, 78]);
    expect(_pixel(atlas, x: 10, y: 4), [12, 34, 56, 78]);
    expect(_pixel(atlas, x: 10, y: 5), [0, 0, 0, 0]);
  });

  test('paddingを除いたcontent texel-center UVとlogical sizeを返す', () {
    final atlas = build();
    final normalRegion = atlas.regions.singleWhere(
      (region) => region.id == earthquakeMapNormalSpriteRegionId,
    );
    final lowRegion = atlas.regions.singleWhere(
      (region) => region.id == earthquakeMapLowPrecisionSpriteRegionId,
    );

    expect(normalRegion.logicalSize, const Size(2, 2));
    expect(
      normalRegion.normalizedUv,
      const Rect.fromLTRB(2.5 / 11, 2.5 / 6, 3.5 / 11, 3.5 / 6),
    );
    expect(lowRegion.logicalSize, const Size(1, 1));
    expect(
      lowRegion.normalizedUv,
      const Rect.fromLTRB(8.5 / 11, 2.5 / 6, 8.5 / 11, 2.5 / 6),
    );
  });

  test('atlas identityは内容のSHA-256で安定しpixel変更で変化する', () {
    final first = build();
    final second = build();
    final changed = build(
      normalImage: _image(
        width: 2,
        height: 2,
        rgbaBytes: [254, ...normal.rgbaBytes.skip(1)],
      ),
    );

    expect(first.identity.value, matches(RegExp(r'^sha256:[0-9a-f]{64}$')));
    expect(second.identity, first.identity);
    expect(changed.identity, isNot(first.identity));
  });

  test('caller limitsのdimension・byte count・region countをすべて適用する', () {
    for (final limits in const [
      MapSpriteAtlasLimits(
        maxWidth: 10,
        maxHeight: 6,
        maxPixelBytes: 264,
        maxRegions: 2,
      ),
      MapSpriteAtlasLimits(
        maxWidth: 11,
        maxHeight: 5,
        maxPixelBytes: 264,
        maxRegions: 2,
      ),
      MapSpriteAtlasLimits(
        maxWidth: 11,
        maxHeight: 6,
        maxPixelBytes: 263,
        maxRegions: 2,
      ),
      MapSpriteAtlasLimits(
        maxWidth: 11,
        maxHeight: 6,
        maxPixelBytes: 264,
        maxRegions: 1,
      ),
    ]) {
      expect(() => build(limits: limits), throwsArgumentError);
    }
  });

  test('build後に入力bufferを変更してもatlasは変化しない', () {
    final bytes = Uint8List.fromList(const [1, 2, 3, 128]);
    final atlas = build(
      normalImage: EarthquakeMapSpriteImage(
        width: 1,
        height: 1,
        rgbaBytes: bytes,
      ),
    );

    bytes.setAll(0, const [9, 9, 9, 9]);

    expect(_pixel(atlas, x: 2, y: 2), const [1, 2, 3, 128]);
  });

  test('providerはroot bundle相当から各assetを一度だけload/decodeする', () async {
    final bundle = _CountingAssetBundle();
    final decoder = _CountingImageDecoder();
    final container = ProviderContainer(
      overrides: [
        earthquakeMapSpriteAssetBundleProvider.overrideWithValue(bundle),
        earthquakeMapSpriteImageDecoderProvider.overrideWithValue(decoder),
      ],
    );
    addTearDown(container.dispose);
    final provider = earthquakeMapSpriteAtlasProvider(
      _limits.earthquakeMapSpriteAtlasLimitsKey,
    );

    final first = await container.read(provider.future);
    final second = await container.read(
      earthquakeMapSpriteAtlasProvider(
        const MapSpriteAtlasLimits(
          maxWidth: 32,
          maxHeight: 32,
          maxPixelBytes: 32 * 32 * 4,
          maxRegions: 2,
        ).earthquakeMapSpriteAtlasLimitsKey,
      ).future,
    );

    expect(second, same(first));
    expect(bundle.loadedPaths, [
      Assets.images.map.normalHypocenter.path,
      Assets.images.map.lowPreciseHypocenter.path,
    ]);
    expect(decoder.decodedPaths, bundle.loadedPaths);
    expect(first.regions.map((region) => region.id), [
      earthquakeMapNormalSpriteRegionId,
      earthquakeMapLowPrecisionSpriteRegionId,
    ]);
  });

  test('asset load失敗はtyped AsyncErrorになりatlasを返さない', () async {
    final container = ProviderContainer(
      overrides: [
        earthquakeMapSpriteAssetBundleProvider.overrideWithValue(
          _ThrowingAssetBundle(),
        ),
      ],
    );
    addTearDown(container.dispose);
    final provider = earthquakeMapSpriteAtlasProvider(
      _limits.earthquakeMapSpriteAtlasLimitsKey,
    );

    await expectLater(
      container.read(provider.future),
      throwsA(
        isA<EarthquakeMapSpriteAtlasException>().having(
          (error) => error.reason,
          'reason',
          EarthquakeMapSpriteAtlasFailureReason.assetLoad,
        ),
      ),
    );
    expect(
      container.read(provider).error,
      isA<EarthquakeMapSpriteAtlasException>(),
    );
  });

  test('unexpected Errorはtyped化せずそのまま伝播する', () async {
    final container = ProviderContainer(
      overrides: [
        earthquakeMapSpriteAssetBundleProvider.overrideWithValue(
          _UnexpectedErrorAssetBundle(),
        ),
      ],
    );
    addTearDown(container.dispose);

    await expectLater(
      container.read(
        earthquakeMapSpriteAtlasProvider(
          _limits.earthquakeMapSpriteAtlasLimitsKey,
        ).future,
      ),
      throwsStateError,
    );
  });

  testWidgets('production decoderは既存2assetをraw straight RGBA atlasへ変換する', (
    tester,
  ) async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final result = await tester.runAsync(
      () => container.read(
        earthquakeMapSpriteAtlasProvider(
          const MapSpriteAtlasLimits(
            maxWidth: 1024,
            maxHeight: 512,
            maxPixelBytes: 1024 * 512 * 4,
            maxRegions: 2,
          ).earthquakeMapSpriteAtlasLimitsKey,
        ).future,
      ),
    );
    final atlas = result ?? (throw StateError('atlas decode returned null'));

    expect((atlas.width, atlas.height), (608, 304));
    expect(atlas.rgbaBytes.length, 608 * 304 * 4);
    expect(atlas.regions.map((region) => region.logicalSize), [
      const Size(300, 300),
      const Size(300, 300),
    ]);
  });
}
