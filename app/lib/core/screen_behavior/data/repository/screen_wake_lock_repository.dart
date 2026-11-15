import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

part 'screen_wake_lock_repository.g.dart';

abstract interface class ScreenWakeLockRepository {
  Future<void> setEnabled({required bool enabled});
}

final class WakelockPlusScreenWakeLockRepository
    implements ScreenWakeLockRepository {
  @override
  Future<void> setEnabled({required bool enabled}) async {
    if (enabled) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }
}

@Riverpod(keepAlive: true)
ScreenWakeLockRepository screenWakeLockRepository(Ref ref) =>
    WakelockPlusScreenWakeLockRepository();
