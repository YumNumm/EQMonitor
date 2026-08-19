import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_mode.freezed.dart';
part 'time_mode.g.dart';

/// アプリの再生モード。
///
/// 強震モニタ・EEW・揺れ検知の表示すべてがこのモードに従って時刻基準を切り替える。
/// - [RealtimeTimeMode] : 通常再生（NTP 補正済みの現在時刻）
/// - [TimeShiftTimeMode] : タイムシフト再生（現在時刻からの `offset` で過去を表現）
/// - [ReplayTimeMode] : リプレイファイル再生（再生位置の `currentTime`）
@freezed
sealed class TimeMode with _$TimeMode {
  const factory realtime() = RealtimeTimeMode;

  /// `offset` は過去方向（負の [Duration]）を表す。
  const factory timeShift({required Duration offset}) =
      TimeShiftTimeMode;

  /// `currentTime` はリプレイファイル上の現在の再生位置。
  const factory replay({required DateTime currentTime}) =
      ReplayTimeMode;


  factory fromJson(Map<String, dynamic> json) => _$TimeModeFromJson(json);
}
