import 'package:eqmonitor/feature/location/data/background_location_monitoring_lifecycle.dart';
import 'package:eqmonitor/feature/location/data/background_location_permission_provider.dart';
import 'package:eqmonitor/feature/location/data/notifier/current_device_location_notifier.dart';
import 'package:eqmonitor/feature/location/data/repository/device_location_sync_state_repository.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/notification_slot.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/shake_detection_settings.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_location_consumers_repository.g.dart';

@Riverpod(keepAlive: true)
DeviceLocationConsumersRepository deviceLocationConsumersRepository(Ref ref) {
  final repository = DeviceLocationConsumersRepository(
    ref.watch(deviceLocationSyncStateRepositoryProvider),
    syncLocation: () async {
      try {
        await ref.read(currentDeviceLocationProvider.future);
      } on Object {
        // A failed cached-state load must still allow a fresh location attempt.
      }
      if (!ref.mounted) return;
      await ref.read(currentDeviceLocationProvider.notifier).refresh();
    },
  );
  // Also covers granting permission in OS settings and returning to the app.
  ref.listen(backgroundLocationPermissionProvider, (previous, next) async {
    if (next.value == LocationPermission.always &&
        previous?.value != LocationPermission.always) {
      await repository.reconcile(syncLocation: true);
    }
  });
  return repository;
}

/// Combines independently loaded consumers before changing headless availability.
///
/// 揺れ検知の設定は起動時にサーバーから取得しないため、この起動で未取得の間は
/// 端末に保存した最後の「現在地」条件を使う。
class DeviceLocationConsumersRepository(
  final DeviceLocationSyncStateRepository storage, {
  final BackgroundLocationMonitoringLifecycle lifecycle =
      const BackgroundLocationMonitoringLifecycle(),
  final BackgroundLocationMonitoringAction? syncLocation,
}) {
  List<NotificationSlot>? _slots;
  bool? _isShakeCurrentLocationEnabled;
  Future<void> _pending = Future<void>.value();
  Future<void> updateSlots(List<NotificationSlot> slots) {
    _slots = slots;
    return reconcile();
  }

  Future<void> updateShake(ShakeDetectionState shake) {
    final wasEnabled = _isShakeCurrentLocationEnabled == true;
    final isEnabled = shake.entries.any(
      (entry) => entry.isCurrentLocation && entry.enabled,
    );
    _isShakeCurrentLocationEnabled = isEnabled;
    return reconcile(
      syncLocation: !wasEnabled && isEnabled,
      storedShake: isEnabled,
    );
  }

  Future<void> reset() {
    _slots = [];
    _isShakeCurrentLocationEnabled = false;
    return reconcile(storedShake: false);
  }

  /// 起動時に、端末に保存した揺れ検知の現在地条件を読み込み済みとして引き継ぐ。
  ///
  /// 設定をサーバーから読み込んだときと同じく、条件が有効なら監視を宣言して
  /// 現在地を一度同期する。保存値がない場合や、既に読み込み済みの場合は何もしない。
  Future<void> restoreStoredShake() async {
    if (_isShakeCurrentLocationEnabled != null) return;
    final stored = await storage.readShakeCurrentLocationEnabled();
    if (stored == null || _isShakeCurrentLocationEnabled != null) return;
    _isShakeCurrentLocationEnabled = stored;
    await reconcile(syncLocation: stored);
  }

  /// この起動で揺れ検知の設定を読み込んでいれば、その値。未読み込みなら端末の保存値。
  Future<bool?> readShakeCurrentLocationEnabled() async =>
      _isShakeCurrentLocationEnabled ??
      await storage.readShakeCurrentLocationEnabled();

  /// [storedShake] は、揺れ検知の「現在地」条件が変わったときに端末へ保存する値。
  Future<void> reconcile({bool syncLocation = false, bool? storedShake}) {
    final operation = _pending.onError((error, stackTrace) {}).then((_) async {
      if (storedShake != null) {
        await storage.writeShakeCurrentLocationEnabled(isEnabled: storedShake);
      }
      final slots = _slots;
      final shake = await readShakeCurrentLocationEnabled();
      const policy = BackgroundLocationMonitoringPolicy();
      final enabled = policy.shouldMonitor(
        slots: slots ?? [],
        isShakeCurrentLocationEnabled: shake,
      );
      final disabled = policy.shouldStop(
        slots: slots,
        isShakeCurrentLocationEnabled: shake,
      );
      if (!enabled && !disabled) return;
      await storage.writeAvailability(
        enabled
            ? DeviceLocationSyncAvailability.enabled
            : DeviceLocationSyncAvailability.disabled,
      );
      await lifecycle.reconcile(
        slots: slots,
        isShakeCurrentLocationEnabled: shake,
      );
      if (enabled && syncLocation) await this.syncLocation?.call();
    });
    _pending = operation;
    return operation;
  }
}
