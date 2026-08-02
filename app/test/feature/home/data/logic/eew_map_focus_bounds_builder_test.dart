import 'package:eqmonitor/feature/home/data/logic/eew_map_focus_bounds_builder.dart';
import 'package:eqmonitor/feature/home/data/model/eew_map_focus_grid_rect.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' show ShakeDetectionLevel;
import 'package:maplibre/maplibre.dart';
import 'package:test/test.dart';

void main() {
  const builder = EewMapFocusBoundsBuilder();

  test('0.5度に外向きスナップする', () {
    final rect = builder.snapOutward(
      minLat: 35.1,
      maxLat: 35.6,
      minLng: 139.1,
      maxLng: 139.6,
    );
    expect(
      rect,
      const EewMapFocusGridRect(
        minLat: 35.0,
        maxLat: 36.0,
        minLng: 139.0,
        maxLng: 140.0,
      ),
    );
  });

  test('unionは拡大のみで縮小しない', () {
    const a = EewMapFocusGridRect(
      minLat: 35.0,
      maxLat: 36.0,
      minLng: 139.0,
      maxLng: 140.0,
    );
    const b = EewMapFocusGridRect(
      minLat: 35.5,
      maxLat: 35.5,
      minLng: 138.5,
      maxLng: 139.5,
    );
    expect(
      builder.union(a: a, b: b),
      const EewMapFocusGridRect(
        minLat: 35.0,
        maxLat: 36.0,
        minLng: 138.5,
        maxLng: 140.0,
      ),
    );
  });

  test('複数揺れ検知をスナップしてunionする', () {
    final now = DateTime.utc(2026, 8, 2);
    final rect = builder.mergeShakeEvents(
      shakes: [
        ShakeDetectionEvent(
          eventId: 's1',
          serialNo: 1,
          createdAt: now,
          updatedAt: now,
          expiresAt: now.add(const Duration(hours: 1)),
          level: ShakeDetectionLevel.medium,
          pointCount: 1,
          minLat: 35.1,
          maxLat: 35.2,
          minLng: 139.1,
          maxLng: 139.2,
          changeReasons: const [],
        ),
        ShakeDetectionEvent(
          eventId: 's2',
          serialNo: 1,
          createdAt: now,
          updatedAt: now,
          expiresAt: now.add(const Duration(hours: 1)),
          level: ShakeDetectionLevel.strong,
          pointCount: 1,
          minLat: 35.7,
          maxLat: 35.8,
          minLng: 139.7,
          maxLng: 139.8,
          changeReasons: const [],
        ),
      ],
    );
    expect(
      rect,
      const EewMapFocusGridRect(
        minLat: 35.0,
        maxLat: 36.0,
        minLng: 139.0,
        maxLng: 140.0,
      ),
    );
  });

  test('震源のみなら震源周辺boundsを返す', () {
    final bounds = builder.boundsForFocus(
      hypocenter: (latitude: 35.5, longitude: 139.5),
      shakeRect: null,
      fallbackBounds: const LngLatBounds(
        longitudeWest: 120,
        longitudeEast: 150,
        latitudeSouth: 20,
        latitudeNorth: 50,
      ),
    );
    expect(bounds, isNotNull);
    expect(bounds!.latitudeSouth, lessThan(35.5));
    expect(bounds.latitudeNorth, greaterThan(35.5));
  });

  test('震源も矩形も無いときはnull', () {
    final bounds = builder.boundsForFocus(
      hypocenter: null,
      shakeRect: null,
      fallbackBounds: const LngLatBounds(
        longitudeWest: 120,
        longitudeEast: 150,
        latitudeSouth: 20,
        latitudeNorth: 50,
      ),
    );
    expect(bounds, isNull);
  });
}
