// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_offset_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 強震モニタ画像の取得に使う公開遅延。
///
/// `latest.json` の実測値 (`publishDelay`) に、404 フィードバックで学習した
/// 補正量を足したもの。測定がまだ無い場合は null。
///
/// NTP 補正の有無は `AppClock` と必ず揃える必要があるため、ここで
/// [Ntp] のオフセットを読んで [KyoshinMonitorTimerStateX.publishDelay] に渡す。

@ProviderFor(kyoshinMonitorEffectiveOffset)
final kyoshinMonitorEffectiveOffsetProvider =
    KyoshinMonitorEffectiveOffsetProvider._();

/// 強震モニタ画像の取得に使う公開遅延。
///
/// `latest.json` の実測値 (`publishDelay`) に、404 フィードバックで学習した
/// 補正量を足したもの。測定がまだ無い場合は null。
///
/// NTP 補正の有無は `AppClock` と必ず揃える必要があるため、ここで
/// [Ntp] のオフセットを読んで [KyoshinMonitorTimerStateX.publishDelay] に渡す。

final class KyoshinMonitorEffectiveOffsetProvider
    extends $FunctionalProvider<Duration?, Duration?, Duration?>
    with $Provider<Duration?> {
  /// 強震モニタ画像の取得に使う公開遅延。
  ///
  /// `latest.json` の実測値 (`publishDelay`) に、404 フィードバックで学習した
  /// 補正量を足したもの。測定がまだ無い場合は null。
  ///
  /// NTP 補正の有無は `AppClock` と必ず揃える必要があるため、ここで
  /// [Ntp] のオフセットを読んで [KyoshinMonitorTimerStateX.publishDelay] に渡す。
  KyoshinMonitorEffectiveOffsetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorEffectiveOffsetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorEffectiveOffsetHash();

  @$internal
  @override
  $ProviderElement<Duration?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Duration? create(Ref ref) {
    return kyoshinMonitorEffectiveOffset(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Duration? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Duration?>(value),
    );
  }
}

String _$kyoshinMonitorEffectiveOffsetHash() =>
    r'ea6b6e9cba7e97a6bcdd15faeae615d2379e4bc2';
