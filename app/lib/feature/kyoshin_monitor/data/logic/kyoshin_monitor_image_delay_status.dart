import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_image_delay_status.g.dart';

@riverpod
KyoshinMonitorImageDelayStatus kyoshinMonitorImageDelayStatus(Ref ref) =>
    const KyoshinMonitorImageDelayStatus();

class KyoshinMonitorImageDelayStatus {
  const new();

  /// [targetTime] は取得対象の時刻で、常に現在時刻([now])より過去になる。
  /// データが [delay] 以上遅れている (= `now - targetTime > delay`) 場合に
  /// 遅延とみなす。
  bool isDelayed({
    required DateTime now,
    required DateTime targetTime,
    required Duration delay,
  }) => now.difference(targetTime) > delay;
}
