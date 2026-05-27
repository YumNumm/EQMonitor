import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_ticker.g.dart';

/// [duration] 周期で現在時刻を配信するティッカー。
///
/// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
/// NTP 補正に追従する。各 tick で [AppClock] の現在時刻を読むため、
/// リプレイ中の再生位置更新では張り直さず、リプレイ開始/終了と NTP 同期時のみ
/// ストリームを張り直す（毎フレーム張り直しによる周期停止を防ぐ）。
@Riverpod(keepAlive: true)
Stream<DateTime> timeTicker(
  Ref ref, [
  Duration duration = const Duration(seconds: 1),
]) {
  ref
    ..watch(isReplayModeProvider)
    ..watch(ntpProvider);
  final clock = ref.read(appClockProvider.notifier);
  return Stream.periodic(duration, (_) => clock.now());
}
