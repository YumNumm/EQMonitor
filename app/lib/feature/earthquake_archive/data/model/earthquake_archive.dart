import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_archive.freezed.dart';

enum EarthquakeArchiveType(final String label) {
  eew('EEW'),
  earthquake('地震情報'),
  eewEarthquake('EEW・地震情報'),
}

enum EarthquakeArchiveWaveformStatus(final String label) {
  pending('波形を確認中'),
  attached('波形あり'),
  notPublished('波形なし'),
}

enum EarthquakeArchiveFrameKind(final int value, final String label) {
  kyoshinMonitorImage(100, '強震モニタ画像'),
  eqMonitorEew(1003, '緊急地震速報'),
  eqMonitorEarthquake(1004, '地震情報'),
  kyoshinWaveform(1005, 'K-NET/KiK-net 波形'),
  other(-1, 'その他'),
}

@freezed
abstract class const EarthquakeArchiveFrame._() with _$EarthquakeArchiveFrame {
  const factory({
    required EarthquakeArchiveFrameKind kind,
    required int frameType,
    required int frameCount,
    required int totalBytes,
    required DateTime firstTime,
    required DateTime lastTime,
  }) = _EarthquakeArchiveFrame;
}

@freezed
abstract class const EarthquakeArchive._() with _$EarthquakeArchive {
  const factory({
    required String eventId,
    required EarthquakeArchiveType type,
    required String objectKey,
    required DateTime originTime,
    required DateTime startTime,
    required DateTime endTime,
    required double? magnitude,
    required String? hypocenterName,
    required int fileSizeBytes,
    required EarthquakeArchiveWaveformStatus waveformStatus,
    required List<EarthquakeArchiveFrame> frames,
  }) = _EarthquakeArchive;

  String get fileName => objectKey.split('/').last;
}

@freezed
abstract class const EarthquakeArchivePage._() with _$EarthquakeArchivePage {
  const factory({
    required List<EarthquakeArchive> items,
    required String? nextCursor,
  }) = _EarthquakeArchivePage;
}
