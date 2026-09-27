// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'latest_earthquake_overlay_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeMapOverlayBuilder)
final earthquakeMapOverlayBuilderProvider =
    EarthquakeMapOverlayBuilderProvider._();

final class EarthquakeMapOverlayBuilderProvider
    extends
        $FunctionalProvider<
          EarthquakeMapOverlayBuilder,
          EarthquakeMapOverlayBuilder,
          EarthquakeMapOverlayBuilder
        >
    with $Provider<EarthquakeMapOverlayBuilder> {
  EarthquakeMapOverlayBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeMapOverlayBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeMapOverlayBuilderHash();

  @$internal
  @override
  $ProviderElement<EarthquakeMapOverlayBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarthquakeMapOverlayBuilder create(Ref ref) {
    return earthquakeMapOverlayBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeMapOverlayBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeMapOverlayBuilder>(value),
    );
  }
}

String _$earthquakeMapOverlayBuilderHash() =>
    r'0156dba1aee5af4ffb66390c488d261b26f1ae5a';

@ProviderFor(earthquakeMapOverlayDigestBuilder)
final earthquakeMapOverlayDigestBuilderProvider =
    EarthquakeMapOverlayDigestBuilderProvider._();

final class EarthquakeMapOverlayDigestBuilderProvider
    extends
        $FunctionalProvider<
          EarthquakeMapOverlayDigestBuilder,
          EarthquakeMapOverlayDigestBuilder,
          EarthquakeMapOverlayDigestBuilder
        >
    with $Provider<EarthquakeMapOverlayDigestBuilder> {
  EarthquakeMapOverlayDigestBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeMapOverlayDigestBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$earthquakeMapOverlayDigestBuilderHash();

  @$internal
  @override
  $ProviderElement<EarthquakeMapOverlayDigestBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarthquakeMapOverlayDigestBuilder create(Ref ref) {
    return earthquakeMapOverlayDigestBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeMapOverlayDigestBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeMapOverlayDigestBuilder>(
        value,
      ),
    );
  }
}

String _$earthquakeMapOverlayDigestBuilderHash() =>
    r'acf123b9b4bdceb13ea98e9ca2d8e2f67929722e';

@ProviderFor(latestEarthquakeOverlaySpriteAtlas)
final latestEarthquakeOverlaySpriteAtlasProvider =
    LatestEarthquakeOverlaySpriteAtlasProvider._();

final class LatestEarthquakeOverlaySpriteAtlasProvider
    extends
        $FunctionalProvider<
          AsyncValue<MapSpriteAtlas>,
          MapSpriteAtlas,
          FutureOr<MapSpriteAtlas>
        >
    with $FutureModifier<MapSpriteAtlas>, $FutureProvider<MapSpriteAtlas> {
  LatestEarthquakeOverlaySpriteAtlasProvider._()
    : super(
        from: null,
        argument: null,
        retry: EarthquakeMapSpriteAtlasRetryPolicy.noRetry,
        name: r'latestEarthquakeOverlaySpriteAtlasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$latestEarthquakeOverlaySpriteAtlasHash();

  @$internal
  @override
  $FutureProviderElement<MapSpriteAtlas> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MapSpriteAtlas> create(Ref ref) {
    return latestEarthquakeOverlaySpriteAtlas(ref);
  }
}

String _$latestEarthquakeOverlaySpriteAtlasHash() =>
    r'c6501371a2c8cad517d3a3ced47e877e60e7a4be';

@ProviderFor(latestEarthquakeOverlayMapLayerParameter)
final latestEarthquakeOverlayMapLayerParameterProvider =
    LatestEarthquakeOverlayMapLayerParameterProvider._();

final class LatestEarthquakeOverlayMapLayerParameterProvider
    extends
        $FunctionalProvider<
          AsyncValue<EarthquakeHistoryMapLayerParameter>,
          EarthquakeHistoryMapLayerParameter,
          FutureOr<EarthquakeHistoryMapLayerParameter>
        >
    with
        $FutureModifier<EarthquakeHistoryMapLayerParameter>,
        $FutureProvider<EarthquakeHistoryMapLayerParameter> {
  LatestEarthquakeOverlayMapLayerParameterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'latestEarthquakeOverlayMapLayerParameterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$latestEarthquakeOverlayMapLayerParameterHash();

  @$internal
  @override
  $FutureProviderElement<EarthquakeHistoryMapLayerParameter> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<EarthquakeHistoryMapLayerParameter> create(Ref ref) {
    return latestEarthquakeOverlayMapLayerParameter(ref);
  }
}

String _$latestEarthquakeOverlayMapLayerParameterHash() =>
    r'1461072ac6cf2de4c1eb5357aa45f6c7c613b4a5';

@ProviderFor(LatestEarthquakeOverlay)
final latestEarthquakeOverlayProvider = LatestEarthquakeOverlayProvider._();

final class LatestEarthquakeOverlayProvider
    extends
        $AsyncNotifierProvider<
          LatestEarthquakeOverlay,
          LatestEarthquakeOverlayData
        > {
  LatestEarthquakeOverlayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'latestEarthquakeOverlayProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$latestEarthquakeOverlayHash();

  @$internal
  @override
  LatestEarthquakeOverlay create() => LatestEarthquakeOverlay();
}

String _$latestEarthquakeOverlayHash() =>
    r'1c585b2577dc3b9c45a7abec1d786fe090c4e1e5';

abstract class _$LatestEarthquakeOverlay
    extends $AsyncNotifier<LatestEarthquakeOverlayData> {
  FutureOr<LatestEarthquakeOverlayData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<LatestEarthquakeOverlayData>,
              LatestEarthquakeOverlayData
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<LatestEarthquakeOverlayData>,
                LatestEarthquakeOverlayData
              >,
              AsyncValue<LatestEarthquakeOverlayData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
