// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_observation_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorObservationPoints)
final kyoshinMonitorObservationPointsProvider =
    KyoshinMonitorObservationPointsProvider._();

final class KyoshinMonitorObservationPointsProvider
    extends
        $FunctionalProvider<
          List<KyoshinMonitorObservationPoint>,
          List<KyoshinMonitorObservationPoint>,
          List<KyoshinMonitorObservationPoint>
        >
    with $Provider<List<KyoshinMonitorObservationPoint>> {
  KyoshinMonitorObservationPointsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorObservationPointsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorObservationPointsHash();

  @$internal
  @override
  $ProviderElement<List<KyoshinMonitorObservationPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<KyoshinMonitorObservationPoint> create(Ref ref) {
    return kyoshinMonitorObservationPoints(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<KyoshinMonitorObservationPoint> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<List<KyoshinMonitorObservationPoint>>(value),
    );
  }
}

String _$kyoshinMonitorObservationPointsHash() =>
    r'40cd77fd1f9eb6228c3a3c0884124ab2ee05b870';

@ProviderFor(kyoshinMonitorInternalObservationPointsConverted)
final kyoshinMonitorInternalObservationPointsConvertedProvider =
    KyoshinMonitorInternalObservationPointsConvertedProvider._();

final class KyoshinMonitorInternalObservationPointsConvertedProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<KyoshinMonitorObservationPoint>>,
          List<KyoshinMonitorObservationPoint>,
          FutureOr<List<KyoshinMonitorObservationPoint>>
        >
    with
        $FutureModifier<List<KyoshinMonitorObservationPoint>>,
        $FutureProvider<List<KyoshinMonitorObservationPoint>> {
  KyoshinMonitorInternalObservationPointsConvertedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorInternalObservationPointsConvertedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$kyoshinMonitorInternalObservationPointsConvertedHash();

  @$internal
  @override
  $FutureProviderElement<List<KyoshinMonitorObservationPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<KyoshinMonitorObservationPoint>> create(Ref ref) {
    return kyoshinMonitorInternalObservationPointsConverted(ref);
  }
}

String _$kyoshinMonitorInternalObservationPointsConvertedHash() =>
    r'51427c40b3db363acc7c314492e24e72b2081f6a';

@ProviderFor(kyoshinObservationPoints)
final kyoshinObservationPointsProvider = KyoshinObservationPointsProvider._();

final class KyoshinObservationPointsProvider
    extends
        $FunctionalProvider<
          KyoshinObservationPoints,
          KyoshinObservationPoints,
          KyoshinObservationPoints
        >
    with $Provider<KyoshinObservationPoints> {
  KyoshinObservationPointsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinObservationPointsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinObservationPointsHash();

  @$internal
  @override
  $ProviderElement<KyoshinObservationPoints> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinObservationPoints create(Ref ref) {
    return kyoshinObservationPoints(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinObservationPoints value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinObservationPoints>(value),
    );
  }
}

String _$kyoshinObservationPointsHash() =>
    r'5ed1439d3d32d21fb6e339c80b5f4070edbafc10';

@ProviderFor(kyoshinMonitorInternalObservationPoints)
final kyoshinMonitorInternalObservationPointsProvider =
    KyoshinMonitorInternalObservationPointsProvider._();

final class KyoshinMonitorInternalObservationPointsProvider
    extends
        $FunctionalProvider<
          AsyncValue<KyoshinObservationPoints>,
          KyoshinObservationPoints,
          FutureOr<KyoshinObservationPoints>
        >
    with
        $FutureModifier<KyoshinObservationPoints>,
        $FutureProvider<KyoshinObservationPoints> {
  KyoshinMonitorInternalObservationPointsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorInternalObservationPointsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$kyoshinMonitorInternalObservationPointsHash();

  @$internal
  @override
  $FutureProviderElement<KyoshinObservationPoints> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<KyoshinObservationPoints> create(Ref ref) {
    return kyoshinMonitorInternalObservationPoints(ref);
  }
}

String _$kyoshinMonitorInternalObservationPointsHash() =>
    r'e6165440e4dbbff60debe63240022a39dc8691c3';
