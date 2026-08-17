import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 揺れ検知レベル（アプリ用ドメイン型）
enum ShakeDetectionLevel { weaker, weak, medium, strong, stronger }

extension ShakeDetectionLevelApiExtension on api.ShakeDetectionLevel {
  ShakeDetectionLevel get toShakeDetectionLevelModel => switch (this) {
    .weaker => .weaker,
    .weak => .weak,
    .medium => .medium,
    .strong => .strong,
    .stronger => .stronger,
  };
}

extension ShakeDetectionLevelToApiExtension on ShakeDetectionLevel {
  api.ShakeDetectionLevel get toApiShakeDetectionLevel => switch (this) {
    ShakeDetectionLevel.weaker => .weaker,
    ShakeDetectionLevel.weak => .weak,
    ShakeDetectionLevel.medium => .medium,
    ShakeDetectionLevel.strong => .strong,
    ShakeDetectionLevel.stronger => .stronger,
  };
}
