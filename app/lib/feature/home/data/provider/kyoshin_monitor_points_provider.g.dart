// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(_kyoshinMonitorObservationPointsStream)
final _kyoshinMonitorObservationPointsStreamProvider =
    _KyoshinMonitorObservationPointsStreamProvider._();

final class _KyoshinMonitorObservationPointsStreamProvider
    extends
        $FunctionalProvider<
          List<KyoshinMonitorImageParseObservationPoint>,
          List<KyoshinMonitorImageParseObservationPoint>,
          List<KyoshinMonitorImageParseObservationPoint>
        >
    with $Provider<List<KyoshinMonitorImageParseObservationPoint>> {
  _KyoshinMonitorObservationPointsStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_kyoshinMonitorObservationPointsStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$_kyoshinMonitorObservationPointsStreamHash();

  @$internal
  @override
  $ProviderElement<List<KyoshinMonitorImageParseObservationPoint>>
  $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  List<KyoshinMonitorImageParseObservationPoint> create(Ref ref) {
    return _kyoshinMonitorObservationPointsStream(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
    List<KyoshinMonitorImageParseObservationPoint> value,
  ) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<List<KyoshinMonitorImageParseObservationPoint>>(
            value,
          ),
    );
  }
}

String _$_kyoshinMonitorObservationPointsStreamHash() =>
    r'ae70938ef9a4a1be30d53cd9a00557416dce0f99';

@ProviderFor(kyoshinMonitorObservationGeoJson)
final kyoshinMonitorObservationGeoJsonProvider =
    KyoshinMonitorObservationGeoJsonProvider._();

final class KyoshinMonitorObservationGeoJsonProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  KyoshinMonitorObservationGeoJsonProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorObservationGeoJsonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorObservationGeoJsonHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return kyoshinMonitorObservationGeoJson(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$kyoshinMonitorObservationGeoJsonHash() =>
    r'daa51ea48035886c30e2a1990e441bf3d4bc51f2';
