import 'package:freezed_annotation/freezed_annotation.dart';

part 'kyoshin_monitor_time_sample.freezed.dart';
part 'kyoshin_monitor_time_sample.g.dart';

/// `latest.json` を 1 回取得したときの観測結果。
///
/// 送信直前と受信直後の端末時計を両方持つことで、往復時間の片道ぶんを
/// 補正できるようにしている。受信後の端末時計だけを使うと往復時間が
/// まるごと遅延に加算されてしまう。
@freezed
abstract class KyoshinMonitorTimeSample with _$KyoshinMonitorTimeSample {
  const factory({
    /// リクエスト送信直前の端末時計
    required DateTime sentAt,

    /// レスポンス受信直後の端末時計
    required DateTime receivedAt,

    /// `latest.json` の `latest_time` (絶対時刻)
    required DateTime latestTime,
  }) = _KyoshinMonitorTimeSample;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorTimeSampleFromJson(json);
}
