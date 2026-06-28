// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'similar_earthquake_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nearbyEarthquake)
final nearbyEarthquakeProvider = NearbyEarthquakeFamily._();

final class NearbyEarthquakeProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EarthquakePartial>>,
          List<EarthquakePartial>,
          FutureOr<List<EarthquakePartial>>
        >
    with
        $FutureModifier<List<EarthquakePartial>>,
        $FutureProvider<List<EarthquakePartial>> {
  NearbyEarthquakeProvider._({
    required NearbyEarthquakeFamily super.from,
    required (String, double, double, int?, api.EarthquakeSortBy, api.SortOrder)
    super.argument,
  }) : super(
         retry: null,
         name: r'nearbyEarthquakeProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$nearbyEarthquakeHash();

  @override
  String toString() {
    return r'nearbyEarthquakeProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<EarthquakePartial>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EarthquakePartial>> create(Ref ref) {
    final argument =
        this.argument
            as (
              String,
              double,
              double,
              int?,
              api.EarthquakeSortBy,
              api.SortOrder,
            );
    return nearbyEarthquake(
      ref,
      argument.$1,
      argument.$2,
      argument.$3,
      argument.$4,
      argument.$5,
      argument.$6,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is NearbyEarthquakeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$nearbyEarthquakeHash() => r'2e8fe5b4b86563f9e8fdf6e2c6284137d5d080cd';

final class NearbyEarthquakeFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<EarthquakePartial>>,
          (String, double, double, int?, api.EarthquakeSortBy, api.SortOrder)
        > {
  NearbyEarthquakeFamily._()
    : super(
        retry: null,
        name: r'nearbyEarthquakeProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NearbyEarthquakeProvider call(
    String excludeEventId,
    double latitude,
    double longitude,
    int? depth,
    api.EarthquakeSortBy sortBy,
    api.SortOrder sortOrder,
  ) => NearbyEarthquakeProvider._(
    argument: (excludeEventId, latitude, longitude, depth, sortBy, sortOrder),
    from: this,
  );

  @override
  String toString() => r'nearbyEarthquakeProvider';
}
