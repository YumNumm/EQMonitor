import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/background_location.g.dart',
    swiftOut: 'ios/Classes/BackgroundLocationApi.g.swift',
    kotlinOut:
        'android/src/main/kotlin/net/yumnumm/background_location_tracker/BackgroundLocationApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'net.yumnumm.background_location_tracker',
    ),
  ),
)
class LocationUpdateMessage {
  LocationUpdateMessage({
    required this.latitude,
    required this.longitude,
    required this.accuracy,
  });
  final double latitude;
  final double longitude;
  final double accuracy;
}

/// Flutter → Native
@HostApi()
abstract class BackgroundLocationHostApi {
  void initialize(int callbackHandle);
  void startMonitoring();
  void stopMonitoring();
}

/// Native → Flutter (Path A: engine running)
@FlutterApi()
abstract class BackgroundLocationFlutterApi {
  void onLocationUpdate(LocationUpdateMessage location);
}
