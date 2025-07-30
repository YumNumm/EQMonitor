// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'jma_earthquake_nearest_observation_point.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(jmaEarthquakeNearestObservationPoint)
const jmaEarthquakeNearestObservationPointProvider =
    JmaEarthquakeNearestObservationPointFamily._();

final class JmaEarthquakeNearestObservationPointProvider
    extends
        $FunctionalProvider<
          AsyncValue<(EarthquakeParameterStationItem, double)?>,
          (EarthquakeParameterStationItem, double)?,
          FutureOr<(EarthquakeParameterStationItem, double)?>
        >
    with
        $FutureModifier<(EarthquakeParameterStationItem, double)?>,
        $FutureProvider<(EarthquakeParameterStationItem, double)?> {
  const JmaEarthquakeNearestObservationPointProvider._({
    required JmaEarthquakeNearestObservationPointFamily super.from,
    required LatLng super.argument,
  }) : super(
         retry: null,
         name: r'jmaEarthquakeNearestObservationPointProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() =>
      _$jmaEarthquakeNearestObservationPointHash();

  @override
  String toString() {
    return r'jmaEarthquakeNearestObservationPointProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<(EarthquakeParameterStationItem, double)?>
  $createElement($ProviderPointer pointer) => $FutureProviderElement(pointer);

  @override
  FutureOr<(EarthquakeParameterStationItem, double)?> create(Ref ref) {
    final argument = this.argument as LatLng;
    return jmaEarthquakeNearestObservationPoint(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is JmaEarthquakeNearestObservationPointProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$jmaEarthquakeNearestObservationPointHash() =>
    r'21a12adc56a07f503d016b4fa4844f539233f0c8';

final class JmaEarthquakeNearestObservationPointFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<(EarthquakeParameterStationItem, double)?>,
          LatLng
        > {
  const JmaEarthquakeNearestObservationPointFamily._()
    : super(
        retry: null,
        name: r'jmaEarthquakeNearestObservationPointProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  JmaEarthquakeNearestObservationPointProvider call(LatLng latLng) =>
      JmaEarthquakeNearestObservationPointProvider._(
        argument: latLng,
        from: this,
      );

  @override
  String toString() => r'jmaEarthquakeNearestObservationPointProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
