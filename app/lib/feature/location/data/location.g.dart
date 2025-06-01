// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(locationStream)
const locationStreamProvider = LocationStreamProvider._();

final class LocationStreamProvider
    extends $FunctionalProvider<AsyncValue<Position>, Stream<Position>>
    with $FutureModifier<Position>, $StreamProvider<Position> {
  const LocationStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'locationStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$locationStreamHash();

  @$internal
  @override
  $StreamProviderElement<Position> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Position> create(Ref ref) {
    return locationStream(ref);
  }
}

String _$locationStreamHash() => r'512cf5869f3db7a5bc88d1c027ab5cc84e006ab8';

/// 近隣の強震観測点
@ProviderFor(closestKmoniObservationPointStream)
const closestKmoniObservationPointStreamProvider =
    ClosestKmoniObservationPointStreamProvider._();

/// 近隣の強震観測点
final class ClosestKmoniObservationPointStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<(KyoshinObservationPoint, double km)>,
          Stream<(KyoshinObservationPoint, double km)>
        >
    with
        $FutureModifier<(KyoshinObservationPoint, double km)>,
        $StreamProvider<(KyoshinObservationPoint, double km)> {
  /// 近隣の強震観測点
  const ClosestKmoniObservationPointStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'closestKmoniObservationPointStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$closestKmoniObservationPointStreamHash();

  @$internal
  @override
  $StreamProviderElement<(KyoshinObservationPoint, double km)> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<(KyoshinObservationPoint, double km)> create(Ref ref) {
    return closestKmoniObservationPointStream(ref);
  }
}

String _$closestKmoniObservationPointStreamHash() =>
    r'0094c2c47c008397a4f460398410ce01c5f4847a';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
