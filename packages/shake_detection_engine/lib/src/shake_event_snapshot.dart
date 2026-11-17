import 'package:shake_detection_engine/src/shake_event_level.dart';

final class const ShakeEventSnapshot({
  required final String id,
  required final DateTime createdAt,
  required final DateTime updatedAt,
  required final DateTime expiresAt,
  required final ShakeEventLevel level,
  required final bool isConfirmed,

  /// 平常値との差で検知したイベント。[createdAt] は揺れ始めの時刻ではなく、
  /// それ以降のいずれかの時刻になる。
  required final bool isBootstrap,
  required final double minLatitude,
  required final double maxLatitude,
  required final double minLongitude,
  required final double maxLongitude,
  required final List<ShakeEventPointSnapshot> points,
  required final List<ShakeMergedEvent> mergedEvents,
});

final class const ShakeEventPointSnapshot({
  required final int stationIndex,

  /// この観測点がイベントに加わった時刻。
  required final DateTime detectedAt,

  /// 最新フレームの震度。
  required final double? intensity,

  /// イベントに加わってから観測した最大の震度。
  required final double? peakIntensity,
  required final double intensityDiff,
});

final class const ShakeMergedEvent({
  required final String id,
  required final DateTime mergedAt,
});
