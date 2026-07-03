// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'similar_earthquake_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NearbyEarthquake)
final nearbyEarthquakeProvider = NearbyEarthquakeFamily._();

final class NearbyEarthquakeProvider
    extends $AsyncNotifierProvider<NearbyEarthquake, List<EarthquakePartial>> {
  NearbyEarthquakeProvider._({
    required NearbyEarthquakeFamily super.from,
    required (
      String,
      double,
      double,
      int?,
      api.EarthquakeSortBy,
      api.SortOrder,
      NearbyEarthquakeParameter,
    )
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
  NearbyEarthquake create() => NearbyEarthquake();

  @override
  bool operator ==(Object other) {
    return other is NearbyEarthquakeProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$nearbyEarthquakeHash() => r'4f7beeb0dcc46f286f4dd51ecbbf90ea60de5b4a';

final class NearbyEarthquakeFamily extends $Family
    with
        $ClassFamilyOverride<
          NearbyEarthquake,
          AsyncValue<List<EarthquakePartial>>,
          List<EarthquakePartial>,
          FutureOr<List<EarthquakePartial>>,
          (
            String,
            double,
            double,
            int?,
            api.EarthquakeSortBy,
            api.SortOrder,
            NearbyEarthquakeParameter,
          )
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
    NearbyEarthquakeParameter parameter,
  ) => NearbyEarthquakeProvider._(
    argument: (
      excludeEventId,
      latitude,
      longitude,
      depth,
      sortBy,
      sortOrder,
      parameter,
    ),
    from: this,
  );

  @override
  String toString() => r'nearbyEarthquakeProvider';
}

abstract class _$NearbyEarthquake
    extends $AsyncNotifier<List<EarthquakePartial>> {
  late final _$args =
      ref.$arg
          as (
            String,
            double,
            double,
            int?,
            api.EarthquakeSortBy,
            api.SortOrder,
            NearbyEarthquakeParameter,
          );
  String get excludeEventId => _$args.$1;
  double get latitude => _$args.$2;
  double get longitude => _$args.$3;
  int? get depth => _$args.$4;
  api.EarthquakeSortBy get sortBy => _$args.$5;
  api.SortOrder get sortOrder => _$args.$6;
  NearbyEarthquakeParameter get parameter => _$args.$7;

  FutureOr<List<EarthquakePartial>> build(
    String excludeEventId,
    double latitude,
    double longitude,
    int? depth,
    api.EarthquakeSortBy sortBy,
    api.SortOrder sortOrder,
    NearbyEarthquakeParameter parameter,
  );
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<EarthquakePartial>>,
              List<EarthquakePartial>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<EarthquakePartial>>,
                List<EarthquakePartial>
              >,
              AsyncValue<List<EarthquakePartial>>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(
        _$args.$1,
        _$args.$2,
        _$args.$3,
        _$args.$4,
        _$args.$5,
        _$args.$6,
        _$args.$7,
      ),
    );
  }
}
