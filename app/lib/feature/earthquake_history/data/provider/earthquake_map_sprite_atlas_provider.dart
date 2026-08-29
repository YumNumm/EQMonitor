import 'dart:ui' as ui;

import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/feature/earthquake_history/data/logic/earthquake_map_sprite_atlas_builder.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_map_sprite_atlas_provider.g.dart';

enum EarthquakeMapSpriteAtlasFailureReason {
  assetLoad,
  imageDecode,
  pixelConversion,
  atlasBuild,
}

typedef EarthquakeMapSpriteAtlasLimitsKey = ({
  int maxWidth,
  int maxHeight,
  int maxPixelBytes,
  int maxRegions,
});

extension EarthquakeMapSpriteAtlasLimitsKeyConverter on MapSpriteAtlasLimits {
  EarthquakeMapSpriteAtlasLimitsKey get earthquakeMapSpriteAtlasLimitsKey => (
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    maxPixelBytes: maxPixelBytes,
    maxRegions: maxRegions,
  );
}

final class EarthquakeMapSpriteAtlasException implements Exception {
  const new({required this.reason, required this.assetPath});

  final EarthquakeMapSpriteAtlasFailureReason reason;
  final String? assetPath;

  @override
  String toString() => 'Earthquake map sprite atlas failed: ${reason.name}';
}

abstract final class EarthquakeMapSpriteAtlasRetryPolicy {
  static Duration? noRetry(int retryCount, Object error) => null;
}

abstract interface class EarthquakeMapSpriteImageDecoder {
  Future<EarthquakeMapSpriteImage> decode({
    required String assetPath,
    required Uint8List encodedBytes,
  });
}

final class FlutterEarthquakeMapSpriteImageDecoder
    implements EarthquakeMapSpriteImageDecoder {
  const new();

  @override
  Future<EarthquakeMapSpriteImage> decode({
    required String assetPath,
    required Uint8List encodedBytes,
  }) async {
    final frame = await decodeFirstFrame(
      assetPath: assetPath,
      encodedBytes: encodedBytes,
    );
    try {
      return await convertToStraightRgba(
        assetPath: assetPath,
        image: frame.image,
      );
    } finally {
      frame.image.dispose();
      frame.codec.dispose();
    }
  }

  Future<({ui.Codec codec, ui.Image image})> decodeFirstFrame({
    required String assetPath,
    required Uint8List encodedBytes,
  }) async {
    ui.Codec? codec;
    try {
      codec = await ui.instantiateImageCodec(encodedBytes);
      final frame = await codec.getNextFrame();
      return (codec: codec, image: frame.image);
    } on Exception {
      codec?.dispose();
      throw EarthquakeMapSpriteAtlasException(
        reason: .imageDecode,
        assetPath: assetPath,
      );
    }
  }

  Future<EarthquakeMapSpriteImage> convertToStraightRgba({
    required String assetPath,
    required ui.Image image,
  }) async {
    try {
      final byteData = await image.toByteData(
        format: ui.ImageByteFormat.rawStraightRgba,
      );
      if (byteData == null) {
        throw EarthquakeMapSpriteAtlasException(
          reason: .pixelConversion,
          assetPath: assetPath,
        );
      }
      return EarthquakeMapSpriteImage(
        width: image.width,
        height: image.height,
        rgbaBytes: byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );
    } on EarthquakeMapSpriteAtlasException {
      rethrow;
    } on Exception {
      throw EarthquakeMapSpriteAtlasException(
        reason: .pixelConversion,
        assetPath: assetPath,
      );
    }
  }
}

final class EarthquakeMapSpriteAssetLoader {
  const new();

  Future<EarthquakeMapSpriteImage> load({
    required AssetBundle bundle,
    required EarthquakeMapSpriteImageDecoder decoder,
    required String assetPath,
  }) async {
    final ByteData encoded;
    try {
      encoded = await bundle.load(assetPath);
    } on FlutterError {
      throw EarthquakeMapSpriteAtlasException(
        reason: .assetLoad,
        assetPath: assetPath,
      );
    } on Exception {
      throw EarthquakeMapSpriteAtlasException(
        reason: .assetLoad,
        assetPath: assetPath,
      );
    }
    return decoder.decode(
      assetPath: assetPath,
      encodedBytes: encoded.buffer.asUint8List(
        encoded.offsetInBytes,
        encoded.lengthInBytes,
      ),
    );
  }

  Future<(EarthquakeMapSpriteImage, EarthquakeMapSpriteImage)> loadPair({
    required AssetBundle bundle,
    required EarthquakeMapSpriteImageDecoder decoder,
    required String firstAssetPath,
    required String secondAssetPath,
  }) async {
    final (first, second) = await (
      settle(load(bundle: bundle, decoder: decoder, assetPath: firstAssetPath)),
      settle(
        load(bundle: bundle, decoder: decoder, assetPath: secondAssetPath),
      ),
    ).wait;
    return (first.unwrap(), second.unwrap());
  }

  Future<_EarthquakeMapSpriteLoadResult> settle(
    Future<EarthquakeMapSpriteImage> pending,
  ) async {
    try {
      return _EarthquakeMapSpriteLoadSuccess(await pending);
    } on Exception catch (error, stackTrace) {
      return _EarthquakeMapSpriteLoadException(error, stackTrace);
    } on Error catch (error, stackTrace) {
      return _EarthquakeMapSpriteLoadError(error, stackTrace);
    }
  }
}

sealed class _EarthquakeMapSpriteLoadResult {
  const new();

  EarthquakeMapSpriteImage unwrap();
}

final class _EarthquakeMapSpriteLoadSuccess
    extends _EarthquakeMapSpriteLoadResult {
  const new(this.image);

  final EarthquakeMapSpriteImage image;

  @override
  EarthquakeMapSpriteImage unwrap() => image;
}

final class _EarthquakeMapSpriteLoadException
    extends _EarthquakeMapSpriteLoadResult {
  const new(this.error, this.stackTrace);

  final Exception error;
  final StackTrace stackTrace;

  @override
  Never unwrap() => Error.throwWithStackTrace(error, stackTrace);
}

final class _EarthquakeMapSpriteLoadError
    extends _EarthquakeMapSpriteLoadResult {
  const new(this.error, this.stackTrace);

  final Error error;
  final StackTrace stackTrace;

  @override
  Never unwrap() => Error.throwWithStackTrace(error, stackTrace);
}

@Riverpod(keepAlive: true)
AssetBundle earthquakeMapSpriteAssetBundle(Ref ref) => rootBundle;

@Riverpod(keepAlive: true)
EarthquakeMapSpriteImageDecoder earthquakeMapSpriteImageDecoder(Ref ref) =>
    const FlutterEarthquakeMapSpriteImageDecoder();

@Riverpod(keepAlive: true)
EarthquakeMapSpriteAssetLoader earthquakeMapSpriteAssetLoader(Ref ref) =>
    const EarthquakeMapSpriteAssetLoader();

@Riverpod(keepAlive: true)
EarthquakeMapSpriteAtlasBuilder earthquakeMapSpriteAtlasBuilder(Ref ref) =>
    const EarthquakeMapSpriteAtlasBuilder();

@Riverpod(
  keepAlive: true,
  retry: EarthquakeMapSpriteAtlasRetryPolicy.noRetry,
)
Future<MapSpriteAtlas> earthquakeMapSpriteAtlas(
  Ref ref,
  EarthquakeMapSpriteAtlasLimitsKey limitsKey,
) async {
  final loader = ref.watch(earthquakeMapSpriteAssetLoaderProvider);
  final bundle = ref.watch(earthquakeMapSpriteAssetBundleProvider);
  final decoder = ref.watch(earthquakeMapSpriteImageDecoderProvider);
  final (normalImage, lowPrecisionImage) = await loader.loadPair(
    bundle: bundle,
    decoder: decoder,
    firstAssetPath: Assets.images.map.normalHypocenter.path,
    secondAssetPath: Assets.images.map.lowPreciseHypocenter.path,
  );
  final limits = MapSpriteAtlasLimits(
    maxWidth: limitsKey.maxWidth,
    maxHeight: limitsKey.maxHeight,
    maxPixelBytes: limitsKey.maxPixelBytes,
    maxRegions: limitsKey.maxRegions,
  );
  try {
    return ref
        .watch(earthquakeMapSpriteAtlasBuilderProvider)
        .build(
          normalImage: normalImage,
          lowPrecisionImage: lowPrecisionImage,
          limits: limits,
        );
  } on ArgumentError {
    throw const EarthquakeMapSpriteAtlasException(
      reason: .atlasBuild,
      assetPath: null,
    );
  }
}
