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

/// 観測点名ラベル用の GeoJSON
///
/// 観測値を含めず、表示中の観測点の集合が変わらない限り同じ文字列を返す。
/// 毎秒の観測値更新でラベルが再配置されるのを避ける。

@ProviderFor(homeKyoshinMonitorStationLabelGeoJson)
final homeKyoshinMonitorStationLabelGeoJsonProvider =
    HomeKyoshinMonitorStationLabelGeoJsonProvider._();

/// 観測点名ラベル用の GeoJSON
///
/// 観測値を含めず、表示中の観測点の集合が変わらない限り同じ文字列を返す。
/// 毎秒の観測値更新でラベルが再配置されるのを避ける。

final class HomeKyoshinMonitorStationLabelGeoJsonProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// 観測点名ラベル用の GeoJSON
  ///
  /// 観測値を含めず、表示中の観測点の集合が変わらない限り同じ文字列を返す。
  /// 毎秒の観測値更新でラベルが再配置されるのを避ける。
  HomeKyoshinMonitorStationLabelGeoJsonProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeKyoshinMonitorStationLabelGeoJsonProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$homeKyoshinMonitorStationLabelGeoJsonHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return homeKyoshinMonitorStationLabelGeoJson(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$homeKyoshinMonitorStationLabelGeoJsonHash() =>
    r'2c48abe7a68675d2b29254d3e4fc368d69921e31';
