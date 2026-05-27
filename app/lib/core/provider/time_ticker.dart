import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/ntp/ntp_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'time_ticker.g.dart';

/// [duration] 周期で現在時刻を配信するティッカー。
///
/// 時刻は [AppClock] を経由するため、再生モード（通常/タイムシフト/リプレイ）と
/// NTP 補正に追従する。モードや NTP offset が変化した場合はストリームを張り直す。
@Riverpod(keepAlive: true)
Stream<DateTime> timeTicker(
  Ref ref, [
  Duration duration = const Duration(seconds: 1),
]) {
  ref
    ..watch(appClockProvider)
    ..watch(ntpProvider);
  final clock = ref.read(appClockProvider.notifier);
  return Stream.periodic(duration, (_) => clock.now());
}
