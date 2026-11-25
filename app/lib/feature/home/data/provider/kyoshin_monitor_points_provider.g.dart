// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_points_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 強震モニタ画像を解析した観測点の Feature。画像が変わったときだけ JSON を読み直す。

@ProviderFor(kyoshinMonitorImageFeatures)
final kyoshinMonitorImageFeaturesProvider =
    KyoshinMonitorImageFeaturesProvider._();

/// 強震モニタ画像を解析した観測点の Feature。画像が変わったときだけ JSON を読み直す。

final class KyoshinMonitorImageFeaturesProvider
    extends $FunctionalProvider<List<Object?>, List<Object?>, List<Object?>>
    with $Provider<List<Object?>> {
  /// 強震モニタ画像を解析した観測点の Feature。画像が変わったときだけ JSON を読み直す。
  KyoshinMonitorImageFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorImageFeaturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorImageFeaturesHash();

  @$internal
  @override
  $ProviderElement<List<Object?>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Object?> create(Ref ref) {
    return kyoshinMonitorImageFeatures(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Object?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Object?>>(value),
    );
  }
}

String _$kyoshinMonitorImageFeaturesHash() =>
    r'ee9fae683978c117f5e664b12c23cbb0688de5ef';

/// 画像の観測点に、リプレイ中は波形から求めた観測点を重ねた Feature

@ProviderFor(kyoshinMonitorObservationFeatures)
final kyoshinMonitorObservationFeaturesProvider =
    KyoshinMonitorObservationFeaturesProvider._();

/// 画像の観測点に、リプレイ中は波形から求めた観測点を重ねた Feature

final class KyoshinMonitorObservationFeaturesProvider
    extends $FunctionalProvider<List<Object?>, List<Object?>, List<Object?>>
    with $Provider<List<Object?>> {
  /// 画像の観測点に、リプレイ中は波形から求めた観測点を重ねた Feature
  KyoshinMonitorObservationFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorObservationFeaturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$kyoshinMonitorObservationFeaturesHash();

  @$internal
  @override
  $ProviderElement<List<Object?>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Object?> create(Ref ref) {
    return kyoshinMonitorObservationFeatures(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Object?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Object?>>(value),
    );
  }
}

String _$kyoshinMonitorObservationFeaturesHash() =>
    r'a79461fb1ae14c2a621401c09639914538a036f7';

/// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の Feature

@ProviderFor(homeKyoshinMonitorObservationFeatures)
final homeKyoshinMonitorObservationFeaturesProvider =
    HomeKyoshinMonitorObservationFeaturesProvider._();

/// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の Feature

final class HomeKyoshinMonitorObservationFeaturesProvider
    extends $FunctionalProvider<List<Object?>, List<Object?>, List<Object?>>
    with $Provider<List<Object?>> {
  /// ホーム設定の最低リアルタイム震度による観測点フィルター適用後の Feature
  HomeKyoshinMonitorObservationFeaturesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeKyoshinMonitorObservationFeaturesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$homeKyoshinMonitorObservationFeaturesHash();

  @$internal
  @override
  $ProviderElement<List<Object?>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Object?> create(Ref ref) {
    return homeKyoshinMonitorObservationFeatures(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Object?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Object?>>(value),
    );
  }
}

String _$homeKyoshinMonitorObservationFeaturesHash() =>
    r'1dc47973a02a3015d94f5c9e92944e611f93ae8b';

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
    r'10f51bcb7c939088452e8bf77dda89be3f77000d';

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
    r'34db621f65619a9a9c0e85c445404e77f1309dc0';
