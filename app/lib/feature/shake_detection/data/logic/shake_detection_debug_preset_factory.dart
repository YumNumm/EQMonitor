import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum ShakeDetectionDebugPresetId { tokyoMultiLevelGrid }

class ShakeDetectionDebugPresetInfo {
  const ShakeDetectionDebugPresetInfo({
    required this.id,
    required this.title,
    required this.description,
  });

  final ShakeDetectionDebugPresetId id;
  final String title;
  final String description;
}

class ShakeDetectionDebugPresetFactory {
  const ShakeDetectionDebugPresetFactory();

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
    // ≤-1 Weaker, >-1 Weak, >0.5 Medium, >2.5 Strong, >4.5 Stronger
    final pointSpecs = <({double lat, double lng, num intensity})>[
      (lat: 35.55, lng: 139.55, intensity: -2), // Weaker @ 35.50/139.50
      (lat: 35.55, lng: 139.80, intensity: 0), // Weak @ 35.50/139.75
      (lat: 35.80, lng: 139.55, intensity: 1), // Medium @ 35.75/139.50
      (lat: 35.80, lng: 139.80, intensity: 3), // Strong @ 35.75/139.75
      (lat: 36.05, lng: 139.70, intensity: 5), // Stronger @ 36.00/139.50
    ];

    final points = [
      for (final (i, spec) in pointSpecs.indexed)
        api.Points(
          code: 'DEBUG-TKY-$i',
          name: 'Debug Tokyo $i',
          region: '東京都',
          type: 'K',
          location: api.Location(latitude: spec.lat, longitude: spec.lng),
          intensity: spec.intensity,
          prefectureCode: '13',
          regionCode: '350',
          cityCode: null,
        ),
    ];

    final lats = [for (final p in points) p.location.latitude.toDouble()];
    final lngs = [for (final p in points) p.location.longitude.toDouble()];
    final minLat = lats.reduce((a, b) => a < b ? a : b);
    final maxLat = lats.reduce((a, b) => a > b ? a : b);
    final minLng = lngs.reduce((a, b) => a < b ? a : b);
    final maxLng = lngs.reduce((a, b) => a > b ? a : b);

    return ShakeDetectionEvent(
      eventId:
          'debug-shake-tokyoMultiLevelGrid-${now.toUtc().millisecondsSinceEpoch}',
      serialNo: 1,
      createdAt: now.toUtc(),
      updatedAt: now.toUtc(),
      expiresAt: now.toUtc().add(const Duration(days: 365 * 100)),
      level: ShakeDetectionLevel.stronger,
      pointCount: points.length,
      minLat: minLat,
      maxLat: maxLat,
      minLng: minLng,
      maxLng: maxLng,
      changeReasons: const ['new_event'],
      points: points,
    );
  }
}
