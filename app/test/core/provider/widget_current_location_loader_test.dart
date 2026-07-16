import 'package:eqmonitor/core/provider/widget_current_location_loader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  group('WidgetCurrentLocationLoader', () {
    test('権限が無いと permissionDenied を返す', () async {
      final loader = WidgetCurrentLocationLoader(
        checkPermission: () async => LocationPermission.denied,
        getLastKnownPosition: () async =>
            position(latitude: 35, longitude: 139),
        getCurrentPosition: () async => position(latitude: 36, longitude: 140),
      );

      final result = await loader.load();

      expect(result.state, WidgetLocationState.permissionDenied);
      expect(result.position, isNull);
    });

    test('保存済み位置があればGPSを再取得しない', () async {
      var currentPositionCalls = 0;
      final lastKnown = position(latitude: 35, longitude: 139);
      final loader = WidgetCurrentLocationLoader(
        checkPermission: () async => LocationPermission.whileInUse,
        getLastKnownPosition: () async => lastKnown,
        getCurrentPosition: () async {
          currentPositionCalls++;
          return position(latitude: 36, longitude: 140);
        },
      );

      final result = await loader.load();

      expect(result.state, WidgetLocationState.available);
      expect(result.position, same(lastKnown));
      expect(currentPositionCalls, 0);
    });

    test('保存済み位置が無ければ現在位置を取得する', () async {
      final current = position(latitude: 35.68, longitude: 139.76);
      final loader = WidgetCurrentLocationLoader(
        checkPermission: () async => LocationPermission.always,
        getLastKnownPosition: () async => null,
        getCurrentPosition: () async => current,
      );

      final result = await loader.load();

      expect(result.state, WidgetLocationState.available);
      expect(result.position, same(current));
    });

    test('位置取得の一時失敗は temporarilyUnavailable を返す', () async {
      final loader = WidgetCurrentLocationLoader(
        checkPermission: () async => LocationPermission.whileInUse,
        getLastKnownPosition: () async => null,
        getCurrentPosition: () async =>
            throw const LocationServiceDisabledException(),
      );

      final result = await loader.load();

      expect(result.state, WidgetLocationState.temporarilyUnavailable);
      expect(result.position, isNull);
    });
  });
}

Position position({required double latitude, required double longitude}) =>
    Position(
      latitude: latitude,
      longitude: longitude,
      timestamp: DateTime(2026),
      accuracy: 10,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
