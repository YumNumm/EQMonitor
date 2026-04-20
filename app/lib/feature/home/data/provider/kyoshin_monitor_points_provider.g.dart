// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
    r'a445d1ab5ad7b6d0466e9fa3d41d422a62022619';

/// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の GeoJSON

@ProviderFor(homeKyoshinMonitorObservationGeoJson)
final homeKyoshinMonitorObservationGeoJsonProvider =
    HomeKyoshinMonitorObservationGeoJsonProvider._();

/// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の GeoJSON

final class HomeKyoshinMonitorObservationGeoJsonProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の GeoJSON
  HomeKyoshinMonitorObservationGeoJsonProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeKyoshinMonitorObservationGeoJsonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$homeKyoshinMonitorObservationGeoJsonHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return homeKyoshinMonitorObservationGeoJson(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$homeKyoshinMonitorObservationGeoJsonHash() =>
    r'fd88ec3165df2fafb00ade8ec5e65760da4ef6c3';
