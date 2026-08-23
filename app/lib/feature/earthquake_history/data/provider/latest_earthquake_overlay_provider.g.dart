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
    r'19419441db4839464bb424ede192d8e9b99ef964';

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
