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
    required (String, NearbyEarthquakeSearchParameter) super.argument,
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
    final argument = this.argument as (String, NearbyEarthquakeSearchParameter);
    return nearbyEarthquake(ref, argument.$1, argument.$2);
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

String _$nearbyEarthquakeHash() => r'2e2f7f434a100e34c6ba1e36d199bcdd94c5b61b';

final class NearbyEarthquakeFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<EarthquakePartial>>,
          (String, NearbyEarthquakeSearchParameter)
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
    NearbyEarthquakeSearchParameter parameter,
  ) => NearbyEarthquakeProvider._(
    argument: (excludeEventId, parameter),
    from: this,
  );

  @override
  String toString() => r'nearbyEarthquakeProvider';
}
