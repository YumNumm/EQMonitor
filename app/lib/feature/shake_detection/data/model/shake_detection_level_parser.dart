import 'package:eqmonitor_api/eqmonitor_api.dart';

extension ShakeDetectionLevelParser on String {
  ShakeDetectionLevel toShakeDetectionLevel() => switch (this) {
    'Weaker' => ShakeDetectionLevel.weaker,
    'Weak' => ShakeDetectionLevel.weak,
    'Medium' => ShakeDetectionLevel.medium,
    'Strong' => ShakeDetectionLevel.strong,
    'Stronger' => ShakeDetectionLevel.stronger,
    final value => throw FormatException(
      'Unknown shake detection level: $value',
    ),
  };
}
