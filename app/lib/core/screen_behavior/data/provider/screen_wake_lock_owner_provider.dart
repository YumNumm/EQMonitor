import 'package:eqmonitor/core/screen_behavior/data/repository/screen_wake_lock_repository.dart';
import 'package:eqmonitor/core/screen_behavior/data/service/screen_wake_lock_owner.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'screen_wake_lock_owner_provider.g.dart';

@Riverpod(keepAlive: true)
ScreenWakeLockOwner screenWakeLockOwner(Ref ref) {
  final repository = ref.watch(screenWakeLockRepositoryProvider);
  final owner = ScreenWakeLockOwner(setEnabled: repository.setEnabled);
  ref.onDispose(owner.dispose);
  return owner;
}
