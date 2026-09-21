// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_regions_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionRegions)
final shakeDetectionRegionsProvider = ShakeDetectionRegionsProvider._();

final class ShakeDetectionRegionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EarthquakeParameterPrefectureItem>>,
          List<EarthquakeParameterPrefectureItem>,
          FutureOr<List<EarthquakeParameterPrefectureItem>>
        >
    with
        $FutureModifier<List<EarthquakeParameterPrefectureItem>>,
        $FutureProvider<List<EarthquakeParameterPrefectureItem>> {
  ShakeDetectionRegionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionRegionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionRegionsHash();

  @$internal
  @override
  $FutureProviderElement<List<EarthquakeParameterPrefectureItem>>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EarthquakeParameterPrefectureItem>> create(Ref ref) {
    return shakeDetectionRegions(ref);
  }
}

String _$shakeDetectionRegionsHash() =>
    r'2e902c1814fdeba4f1577f21ae141616963ec966';
