// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_plum_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(kyoshinMonitorPlumObservationReader)
final kyoshinMonitorPlumObservationReaderProvider =
    KyoshinMonitorPlumObservationReaderProvider._();

final class KyoshinMonitorPlumObservationReaderProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorPlumObservationReader,
          KyoshinMonitorPlumObservationReader,
          KyoshinMonitorPlumObservationReader
        >
    with $Provider<KyoshinMonitorPlumObservationReader> {
  KyoshinMonitorPlumObservationReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorPlumObservationReaderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$kyoshinMonitorPlumObservationReaderHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorPlumObservationReader> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorPlumObservationReader create(Ref ref) {
    return kyoshinMonitorPlumObservationReader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorPlumObservationReader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorPlumObservationReader>(
        value,
      ),
    );
  }
}

String _$kyoshinMonitorPlumObservationReaderHash() =>
    r'f2fd58ecb958aa2fc9f2ab2a12b903d2549255a5';

@ProviderFor(kyoshinMonitorPlumCalculator)
final kyoshinMonitorPlumCalculatorProvider =
    KyoshinMonitorPlumCalculatorProvider._();

final class KyoshinMonitorPlumCalculatorProvider
    extends
        $FunctionalProvider<
          KyoshinMonitorPlumCalculator,
          KyoshinMonitorPlumCalculator,
          KyoshinMonitorPlumCalculator
        >
    with $Provider<KyoshinMonitorPlumCalculator> {
  KyoshinMonitorPlumCalculatorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorPlumCalculatorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorPlumCalculatorHash();

  @$internal
  @override
  $ProviderElement<KyoshinMonitorPlumCalculator> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  KyoshinMonitorPlumCalculator create(Ref ref) {
    return kyoshinMonitorPlumCalculator(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(KyoshinMonitorPlumCalculator value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<KyoshinMonitorPlumCalculator>(value),
    );
  }
}

String _$kyoshinMonitorPlumCalculatorHash() =>
    r'c1ebd008f5b7d8847e108fa085798b08ad391bb1';

/// PLUM 法の予測震度表示を選べるか。
///
/// 入力にリアルタイム震度 (地表) を使うため、それ以外のデータ種別・レイヤーでは使えない。

@ProviderFor(kyoshinMonitorPlumAvailable)
final kyoshinMonitorPlumAvailableProvider =
    KyoshinMonitorPlumAvailableProvider._();

/// PLUM 法の予測震度表示を選べるか。
///
/// 入力にリアルタイム震度 (地表) を使うため、それ以外のデータ種別・レイヤーでは使えない。

final class KyoshinMonitorPlumAvailableProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// PLUM 法の予測震度表示を選べるか。
  ///
  /// 入力にリアルタイム震度 (地表) を使うため、それ以外のデータ種別・レイヤーでは使えない。
  KyoshinMonitorPlumAvailableProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorPlumAvailableProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorPlumAvailableHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return kyoshinMonitorPlumAvailable(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$kyoshinMonitorPlumAvailableHash() =>
    r'191fa9431ab52e7534b2111731286cce43e63e9f';

/// PLUM 法の予測震度表示が有効か。

@ProviderFor(kyoshinMonitorPlumEnabled)
final kyoshinMonitorPlumEnabledProvider = KyoshinMonitorPlumEnabledProvider._();

/// PLUM 法の予測震度表示が有効か。

final class KyoshinMonitorPlumEnabledProvider
    extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// PLUM 法の予測震度表示が有効か。
  KyoshinMonitorPlumEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorPlumEnabledProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorPlumEnabledHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return kyoshinMonitorPlumEnabled(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$kyoshinMonitorPlumEnabledHash() =>
    r'297ebedc3641f86e7e20f21d06c1e02ab1c94572';

/// 強震モニタのリアルタイム震度から PLUM 法で予測した細分区域ごとの震度。
///
/// 地図の震度塗りレイヤーへそのまま渡せるよう [EewForecastRegionInfo] で返す。

@ProviderFor(kyoshinMonitorPlumForecastRegions)
final kyoshinMonitorPlumForecastRegionsProvider =
    KyoshinMonitorPlumForecastRegionsProvider._();

/// 強震モニタのリアルタイム震度から PLUM 法で予測した細分区域ごとの震度。
///
/// 地図の震度塗りレイヤーへそのまま渡せるよう [EewForecastRegionInfo] で返す。

final class KyoshinMonitorPlumForecastRegionsProvider
    extends
        $FunctionalProvider<
          List<EewForecastRegionInfo>,
          List<EewForecastRegionInfo>,
          List<EewForecastRegionInfo>
        >
    with $Provider<List<EewForecastRegionInfo>> {
  /// 強震モニタのリアルタイム震度から PLUM 法で予測した細分区域ごとの震度。
  ///
  /// 地図の震度塗りレイヤーへそのまま渡せるよう [EewForecastRegionInfo] で返す。
  KyoshinMonitorPlumForecastRegionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorPlumForecastRegionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$kyoshinMonitorPlumForecastRegionsHash();

  @$internal
  @override
  $ProviderElement<List<EewForecastRegionInfo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<EewForecastRegionInfo> create(Ref ref) {
    return kyoshinMonitorPlumForecastRegions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<EewForecastRegionInfo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<EewForecastRegionInfo>>(value),
    );
  }
}

String _$kyoshinMonitorPlumForecastRegionsHash() =>
    r'358fe446af5dd02de5cda82794ad197212d71462';
