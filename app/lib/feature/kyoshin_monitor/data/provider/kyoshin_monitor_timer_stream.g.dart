// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'kyoshin_monitor_timer_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 強震モニタ画像の取得対象時刻を配信するストリーム。
///
/// NTP 補正済みの秒境界に同期して発火する。`Timer.periodic(1s)` だと発火位相が
/// 購読開始のタイミングで固定されてしまい、100ms 刻みのオフセット調整が
/// 実質 1 秒粒度に丸められてしまうため、毎回次の境界へ張り直す方式にしている。
///
/// 公開遅延の整数秒部を取得対象時刻から引き、端数は発火位相の遅れとして使う
/// (KyoshinEewViewer と同じ扱い)。たとえば公開遅延 1100ms なら
/// 「秒境界 + 100ms に発火し、その 1 秒前の画像を取る」となる。

@ProviderFor(kyoshinMonitorTimerStream)
final kyoshinMonitorTimerStreamProvider = KyoshinMonitorTimerStreamProvider._();

/// 強震モニタ画像の取得対象時刻を配信するストリーム。
///
/// NTP 補正済みの秒境界に同期して発火する。`Timer.periodic(1s)` だと発火位相が
/// 購読開始のタイミングで固定されてしまい、100ms 刻みのオフセット調整が
/// 実質 1 秒粒度に丸められてしまうため、毎回次の境界へ張り直す方式にしている。
///
/// 公開遅延の整数秒部を取得対象時刻から引き、端数は発火位相の遅れとして使う
/// (KyoshinEewViewer と同じ扱い)。たとえば公開遅延 1100ms なら
/// 「秒境界 + 100ms に発火し、その 1 秒前の画像を取る」となる。

final class KyoshinMonitorTimerStreamProvider
    extends
        $FunctionalProvider<AsyncValue<DateTime>, DateTime, Stream<DateTime>>
    with $FutureModifier<DateTime>, $StreamProvider<DateTime> {
  /// 強震モニタ画像の取得対象時刻を配信するストリーム。
  ///
  /// NTP 補正済みの秒境界に同期して発火する。`Timer.periodic(1s)` だと発火位相が
  /// 購読開始のタイミングで固定されてしまい、100ms 刻みのオフセット調整が
  /// 実質 1 秒粒度に丸められてしまうため、毎回次の境界へ張り直す方式にしている。
  ///
  /// 公開遅延の整数秒部を取得対象時刻から引き、端数は発火位相の遅れとして使う
  /// (KyoshinEewViewer と同じ扱い)。たとえば公開遅延 1100ms なら
  /// 「秒境界 + 100ms に発火し、その 1 秒前の画像を取る」となる。
  KyoshinMonitorTimerStreamProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'kyoshinMonitorTimerStreamProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$kyoshinMonitorTimerStreamHash();

  @$internal
  @override
  $StreamProviderElement<DateTime> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<DateTime> create(Ref ref) {
    return kyoshinMonitorTimerStream(ref);
  }
}

String _$kyoshinMonitorTimerStreamHash() =>
    r'3b4bc205c0544b1d2bb6d3d6c3a59b811f99427f';
