import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_library_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/repository/replay_library_repository.dart';
import 'package:native_plugin/native_plugin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_device_storage_provider.g.dart';

@riverpod
Future<DeviceStorage?> replayDeviceStorage(Ref ref) {
  ref.watch(replayLibraryProvider);
  return ref.watch(replayLibraryRepositoryProvider).readDeviceStorage();
}
