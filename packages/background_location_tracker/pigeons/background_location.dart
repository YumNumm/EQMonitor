import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/background_location.g.dart',
    swiftOut: 'ios/background_location_tracker/Sources/background_location_tracker/BackgroundLocationApi.g.swift',
    kotlinOut: 'android/src/main/kotlin/net/yumnumm/background_location_tracker/BackgroundLocationApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'net.yumnumm.background_location_tracker',
    ),
  ),
)
enum PendingLocationConsumer { deviceLocation, appEffects }

enum HeadlessTaskResult { success, retry, terminalFailure }

class PendingLocationMessage {
  // Pigeon 26.3.4のanalyzer上限で解釈できる通常コンストラクタ形式を使う。
  // ignore: unnecessary_type_name_in_constructor
  PendingLocationMessage({
    required this.updateId,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.timestampMillis,
  });
  final String updateId;
  final double latitude;
  final double longitude;
  final double accuracy;
  final int timestampMillis;
}

class DeviceLocationSyncLeaseMessage {
  // Pigeon 26.3.4のanalyzer上限で解釈できる通常コンストラクタ形式を使う。
  // ignore: unnecessary_type_name_in_constructor
  DeviceLocationSyncLeaseMessage({
    required this.leaseId,
    required this.updateId,
  });
  final String leaseId;
  final String updateId;
}

/// Flutter → Native
@HostApi()
abstract class BackgroundLocationHostApi {
  void initialize(int callbackHandle);
  void startMonitoring();
  void stopMonitoring();
  PendingLocationMessage? peekPendingLocation(PendingLocationConsumer consumer);
  bool acknowledgePendingLocation(
    String updateId,
    PendingLocationConsumer consumer,
  );
  DeviceLocationSyncLeaseMessage? acquireDeviceLocationSyncLease(
    String updateId,
    int durationMillis,
  );
  bool isDeviceLocationSyncLeaseCurrent(String leaseId, String updateId);
  void releaseDeviceLocationSyncLease(String leaseId);
  String? getActiveHeadlessTaskId();
  void completeHeadlessTask(String updateId, HeadlessTaskResult result);
}

/// Native → Flutter (Path A: engine running)
@FlutterApi()
abstract class BackgroundLocationFlutterApi {
  void onLocationUpdate(PendingLocationMessage location);
}
