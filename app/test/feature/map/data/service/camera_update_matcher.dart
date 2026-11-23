import 'package:maplibre/maplibre.dart';
import 'package:test/test.dart';

Matcher isCameraPositionUpdate({
  Object? center = anything,
  Object? zoom = anything,
  Object? bearing = anything,
  Object? pitch = anything,
  Object? padding = anything,
}) => isA<CameraUpdatePosition>()
    .having((update) => update.center, 'center', center)
    .having((update) => update.zoom, 'zoom', zoom)
    .having((update) => update.bearing, 'bearing', bearing)
    .having((update) => update.pitch, 'pitch', pitch)
    .having((update) => update.padding, 'padding', padding);
