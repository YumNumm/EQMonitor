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
      description: '東京付近の複数セルに Weaker〜Stronger を配置',
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
    final pointSpecs = <({double lat, double lng, double intensity})>[
      (lat: 35.3, lng: 139.25, intensity: 0),
      (lat: 35.3, lng: 139.75, intensity: 1),
      (lat: 35.7, lng: 139.25, intensity: 3),
      (lat: 35.7, lng: 139.75, intensity: 5),
      (lat: 36.1, lng: 139.25, intensity: 6),
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
