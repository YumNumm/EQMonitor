import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';

enum ShakeDetectionDebugPresetId { tokyoMultiLevelGrid }

class const ShakeDetectionDebugPresetInfo({
  required final ShakeDetectionDebugPresetId id,
  required final String title,
  required final String description,
});

class const ShakeDetectionDebugPresetFactory() {
  List<ShakeDetectionDebugPresetInfo> get presets => const [
    ShakeDetectionDebugPresetInfo(
      id: ShakeDetectionDebugPresetId.tokyoMultiLevelGrid,
      title: '東京・多レベルグリッド',
      description: '東京付近の複数 0.25° セルに Weaker〜Stronger を配置',
    ),
  ];

  ShakeDetectionEvent create({
    required ShakeDetectionDebugPresetId id,
    required DateTime now,
  }) {
    return switch (id) {
      ShakeDetectionDebugPresetId.tokyoMultiLevelGrid => _tokyoMultiLevelGrid(
        now: now,
      ),
    };
  }

  ShakeDetectionEvent _tokyoMultiLevelGrid({required DateTime now}) {
    // 各点は異なる 0.25° セルに置き、intensity 閾値でレベルが分かれるようにする
    // <0.5 Weaker, ≥0.5 Weak, ≥2.5 Medium, ≥4.5 Strong, ≥5.5 Stronger
    final pointSpecs = <({double lat, double lng, double intensity})>[
      (lat: 35.55, lng: 139.55, intensity: 0), // Weaker @ 35.50/139.50
      (lat: 35.55, lng: 139.80, intensity: 1), // Weak @ 35.50/139.75
      (lat: 35.80, lng: 139.55, intensity: 3), // Medium @ 35.75/139.50
      (lat: 35.80, lng: 139.80, intensity: 5), // Strong @ 35.75/139.75
      (lat: 36.05, lng: 139.70, intensity: 6), // Stronger @ 36.00/139.50
    ];

    final points = [
      for (final (i, spec) in pointSpecs.indexed)
        ShakeDetectionPoint(
          code: 'DEBUG-TKY-$i',
          name: 'Debug Tokyo $i',
          latitude: spec.lat,
          longitude: spec.lng,
          intensity: spec.intensity,
          intensityDiff: 0,
          prefectureCode: '13',
          regionCode: '350',
        ),
    ];

    final lats = [for (final p in points) p.latitude];
    final lngs = [for (final p in points) p.longitude];
    final minLat = lats.reduce((a, b) => a < b ? a : b);
    final maxLat = lats.reduce((a, b) => a > b ? a : b);
    final minLng = lngs.reduce((a, b) => a < b ? a : b);
    final maxLng = lngs.reduce((a, b) => a > b ? a : b);

    return ShakeDetectionEvent(
      eventId:
          'debug-shake-tokyoMultiLevelGrid-${now.toUtc().millisecondsSinceEpoch}',
      createdAt: now.toUtc(),
      updatedAt: now.toUtc(),
      expiresAt: now.toUtc().add(const Duration(days: 365 * 100)),
      level: ShakeDetectionLevel.stronger,
      pointCount: points.length,
      minLat: minLat,
      maxLat: maxLat,
      minLng: minLng,
      maxLng: maxLng,
      points: points,
    );
  }
}
