import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_source.freezed.dart';

@freezed
sealed class const ReplaySource._() with _$ReplaySource {
  const factory eqrp({
    required ReplayFile file,
    required String name,
    required DateTime? originTime,
  }) = ReplayEqrpSource;

  /// 強震モニタが公開している過去画像を再生位置に合わせて取得する。
  /// [eewFrames] は EQRP の 1003 と同じ形式で、震度画像を含まない。
  const factory kyoshinArchive({
    required String label,
    required DateTime windowStart,
    required DateTime windowEnd,
    required DateTime? originTime,
    required bool isOriginTimeApproximate,
    required List<ReplayData> eewFrames,
    required KyoshinMonitorSource monitorSource,
  }) = ReplayKyoshinArchiveSource;

  static const _eqrpPlaybackSpeeds = [0.5, 1.0, 2.0, 4.0];
  static const _kyoshinArchivePlaybackSpeeds = [0.5, 1.0, 2.0];

  List<ReplayData> get frames => switch (this) {
    ReplayEqrpSource(:final file) => file.data,
    ReplayKyoshinArchiveSource(:final eewFrames) => eewFrames,
  };

  // EQRP のヘッダの開始時刻より前のフレームは、揺れ検知の平常値に使う前置き区間として再生範囲に含めない。
  DateTime get startTime => switch (this) {
    ReplayEqrpSource(:final file) =>
      file.header.startTime.isAfter(file.data.first.time) &&
              file.header.startTime.isBefore(file.data.last.time)
          ? file.header.startTime
          : file.data.first.time,
    ReplayKyoshinArchiveSource(:final windowStart) => windowStart,
  };

  // 強震モニタ画像の無いファイルでは、最後のフレームが EEW のため波形の記録より先に終わる。
  // K-NET/KiK-net の波形を含む場合は、ヘッダの終了時刻まで再生する。
  DateTime get endTime => switch (this) {
    ReplayEqrpSource(:final file)
        when file.header.endTime.isAfter(file.data.last.time) &&
            file.data.any((frame) => frame is KyoshinWaveformReplayData) =>
      file.header.endTime,
    ReplayEqrpSource(:final file) => file.data.last.time,
    ReplayKyoshinArchiveSource(:final windowEnd) => windowEnd,
  };

  String get title => switch (this) {
    ReplayEqrpSource(:final name) => name,
    ReplayKyoshinArchiveSource(:final label) => label,
  };

  bool get isOriginApproximate => switch (this) {
    ReplayEqrpSource() => false,
    ReplayKyoshinArchiveSource(:final isOriginTimeApproximate) =>
      isOriginTimeApproximate,
  };

  List<double> get playbackSpeeds => switch (this) {
    ReplayEqrpSource() => _eqrpPlaybackSpeeds,
    ReplayKyoshinArchiveSource() => _kyoshinArchivePlaybackSpeeds,
  };
}
