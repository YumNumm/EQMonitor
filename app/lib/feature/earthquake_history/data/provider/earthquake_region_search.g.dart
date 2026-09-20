// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_region_search.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeRegionSearch)
final earthquakeRegionSearchProvider = EarthquakeRegionSearchProvider._();

final class EarthquakeRegionSearchProvider
    extends
        $FunctionalProvider<
          EarthquakeRegionSearch,
          EarthquakeRegionSearch,
          EarthquakeRegionSearch
        >
    with $Provider<EarthquakeRegionSearch> {
  EarthquakeRegionSearchProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeRegionSearchProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeRegionSearchHash();

  @$internal
  @override
  $ProviderElement<EarthquakeRegionSearch> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarthquakeRegionSearch create(Ref ref) {
    return earthquakeRegionSearch(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeRegionSearch value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeRegionSearch>(value),
    );
  }
}

String _$earthquakeRegionSearchHash() =>
    r'634daf37d417dea5b8c96a72d5f497e5362445fc';
