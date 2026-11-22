import 'package:eqmonitor/feature/home/ui/component/map/layer/home_map_user_location_layer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  const factory = HomeMapUserLocationStreamFactory();
  final timestamp = DateTime.utc(2026, 8, 17);

  Position position({required double accuracy, required double heading}) =>
      Position(
        latitude: 35.5,
        longitude: 139.5,
        timestamp: timestamp,
        accuracy: accuracy,
        altitude: 0,
        altitudeAccuracy: 0,
        heading: heading,
        headingAccuracy: 0,
        speed: 0,
        speedAccuracy: 0,
      );

  test('緯度経度・精度・方位をUserLocationへ変換する', () {
    final location = factory.toUserLocation(
      position(accuracy: 12.5, heading: 370),
    );

    expect(location.position.lat, 35.5);
    expect(location.position.lon, 139.5);
    expect(location.accuracy, 12.5);
    expect(location.heading, 10);
    expect(location.timestamp, timestamp);
  });

  test('計測できなかった精度と方位はnullにする', () {
    final location = factory.toUserLocation(position(accuracy: 0, heading: -1));

    expect(location.accuracy, isNull);
    expect(location.heading, isNull);
  });
}
