import 'package:background_location_tracker/background_location_tracker.dart';
import 'package:eqmonitor/feature/location/data/logic/device_location_sync_service.dart';

class BackgroundLocationSyncLeaseManager
    implements DeviceLocationSyncLeaseManager {
  const BackgroundLocationSyncLeaseManager();

  static const leaseDuration = Duration(seconds: 45);

  @override
  Future<DeviceLocationSyncLease?> acquire({required String updateId}) async {
    final lease =
        await BackgroundLocationTracker.acquireDeviceLocationSyncLease(
          updateId: updateId,
          duration: leaseDuration,
        );
    if (lease == null) {
      return null;
    }
    return BackgroundLocationSyncLease(
      leaseId: lease.leaseId,
      updateId: lease.updateId,
    );
  }
}

class BackgroundLocationSyncLease implements DeviceLocationSyncLease {
  const BackgroundLocationSyncLease({
    required this.leaseId,
    required this.updateId,
  });

  final String leaseId;
  final String updateId;

  @override
  Future<bool> isCurrent() =>
      BackgroundLocationTracker.isDeviceLocationSyncLeaseCurrent(
        leaseId: leaseId,
        updateId: updateId,
      );

  @override
  Future<void> release() =>
      BackgroundLocationTracker.releaseDeviceLocationSyncLease(
        leaseId: leaseId,
      );
}
