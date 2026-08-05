import 'package:eqmonitor_map/src/geo/map_camera.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('supports value equality and copyWith (Freezed)', () {
    const camera = MapCamera(
      centerLongitude: 139.767,
      centerLatitude: 35.681,
      zoom: 5,
    );
    const same = MapCamera(
      centerLongitude: 139.767,
      centerLatitude: 35.681,
      zoom: 5,
    );
    final zoomedIn = camera.copyWith(zoom: 10);

    expect(camera, same);
    expect(camera.hashCode, same.hashCode);
    expect(zoomedIn.zoom, 10);
    expect(zoomedIn.centerLongitude, camera.centerLongitude);
  });

  group('worldCenter', () {
    test('projects the origin to the center of the world at zoom 0', () {
      const camera = MapCamera(
        centerLongitude: 0,
        centerLatitude: 0,
        zoom: 0,
      );

      final world = camera.worldCenter();

      expect(world.x, closeTo(256, 1e-9));
      expect(world.y, closeTo(256, 1e-9));
    });

    test('scales with worldSize as zoom increases', () {
      const camera = MapCamera(
        centerLongitude: 0,
        centerLatitude: 0,
        zoom: 1,
      );

      final world = camera.worldCenter();

      expect(world.x, closeTo(512, 1e-9));
      expect(world.y, closeTo(512, 1e-9));
    });

    test('reflects an off-center longitude/latitude', () {
      const camera = MapCamera(
        centerLongitude: 90,
        centerLatitude: 0,
        zoom: 0,
      );

      final world = camera.worldCenter();

      expect(world.x, closeTo(384, 1e-9));
      expect(world.y, closeTo(256, 1e-9));
    });
  });
}
