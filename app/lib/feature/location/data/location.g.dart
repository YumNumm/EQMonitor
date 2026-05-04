// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'location.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(locationStream)
final locationStreamProvider = LocationStreamProvider._();

final class LocationStreamProvider
    extends
        $FunctionalProvider<AsyncValue<Position>, Position, Stream<Position>>
    with $FutureModifier<Position>, $StreamProvider<Position> {
  LocationStreamProvider._()
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

String _$locationStreamHash() => r'0f1636bf1583f78551f435c90fbad18f74f6f5ee';

/// 近隣の強震観測点

@ProviderFor(closestKmoniObservationPointStream)
final closestKmoniObservationPointStreamProvider =
    ClosestKmoniObservationPointStreamProvider._();

/// 近隣の強震観測点

final class ClosestKmoniObservationPointStreamProvider
    extends
        $FunctionalProvider<
          AsyncValue<(KyoshinObservationPoint, double)>,
          (KyoshinObservationPoint, double),
          Stream<(KyoshinObservationPoint, double)>
        >
    with
        $FutureModifier<(KyoshinObservationPoint, double)>,
        $StreamProvider<(KyoshinObservationPoint, double)> {
  /// 近隣の強震観測点
  ClosestKmoniObservationPointStreamProvider._()
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
  $StreamProviderElement<(KyoshinObservationPoint, double)> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<(KyoshinObservationPoint, double)> create(Ref ref) {
    return closestKmoniObservationPointStream(ref);
  }
}

String _$closestKmoniObservationPointStreamHash() =>
    r'5cb8366871efb913595a5e3fe4047e4fa68c784a';
