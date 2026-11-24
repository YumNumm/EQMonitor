import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

extension EarthquakeArchiveTypeConverter on api.EarthquakeArchiveType {
  EarthquakeArchiveType toModel() => switch (this) {
    .eew => .eew,
    .earthquake => .earthquake,
    .eewEarthquake => .eewEarthquake,
  };
}

extension EarthquakeArchiveWaveformStatusConverter
    on api.EarthquakeArchiveWaveformStatus {
  EarthquakeArchiveWaveformStatus toModel() => switch (this) {
    .pending => .pending,
    .attached => .attached,
    .notPublished => .notPublished,
  };
}

extension EarthquakeArchiveFrameConverter on api.EarthquakeArchiveFrame {
  EarthquakeArchiveFrame toModel() => EarthquakeArchiveFrame(
    kind: EarthquakeArchiveFrameKind.values.firstWhere(
      (kind) => kind.value == frameType,
      orElse: () => .other,
    ),
    frameType: frameType.toInt(),
    frameCount: frameCount.toInt(),
    totalBytes: totalBytes.toInt(),
    firstTime: DateTime.parse(firstTime),
    lastTime: DateTime.parse(lastTime),
  );
}

extension EarthquakeArchiveConverter on api.EarthquakeArchive {
  EarthquakeArchive toModel() => EarthquakeArchive(
    eventId: eventId,
    type: type.toModel(),
    objectKey: objectKey,
    originTime: DateTime.parse(originTime),
    startTime: DateTime.parse(startTime),
    endTime: DateTime.parse(endTime),
    magnitude: magnitude?.toDouble(),
    hypocenterName: hypocenterName,
    fileSizeBytes: fileSizeBytes.toInt(),
    waveformStatus: waveformStatus.toModel(),
    frames: [for (final frame in frames) frame.toModel()],
  );
}
