// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'nearby_earthquakes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nearbyEarthquakes)
final nearbyEarthquakesProvider = NearbyEarthquakesFamily._();

final class NearbyEarthquakesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<EarthquakePartial>>,
          List<EarthquakePartial>,
          FutureOr<List<EarthquakePartial>>
        >
    with
        $FutureModifier<List<EarthquakePartial>>,
        $FutureProvider<List<EarthquakePartial>> {
  NearbyEarthquakesProvider._({
    required NearbyEarthquakesFamily super.from,
    required NearbyEarthquakeQuery super.argument,
  }) : super(
         retry: null,
         name: r'nearbyEarthquakesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$nearbyEarthquakesHash();

  @override
  String toString() {
    return r'nearbyEarthquakesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<EarthquakePartial>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<EarthquakePartial>> create(Ref ref) {
    final argument = this.argument as NearbyEarthquakeQuery;
    return nearbyEarthquakes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is NearbyEarthquakesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$nearbyEarthquakesHash() => r'b1b84985e925914d67c12ccfffcd65846839ce69';

final class NearbyEarthquakesFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<EarthquakePartial>>,
          NearbyEarthquakeQuery
        > {
  NearbyEarthquakesFamily._()
    : super(
        retry: null,
        name: r'nearbyEarthquakesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NearbyEarthquakesProvider call(NearbyEarthquakeQuery query) =>
      NearbyEarthquakesProvider._(argument: query, from: this);

  @override
  String toString() => r'nearbyEarthquakesProvider';
}
