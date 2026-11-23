import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:native_plugin/native_plugin.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_device_storage_data_source.g.dart';

@Riverpod(keepAlive: true)
ReplayDeviceStorageDataSource replayDeviceStorageDataSource(Ref ref) =>
    ReplayDeviceStorageDataSource(reader: DeviceStorageReader.platform());

class const ReplayDeviceStorageDataSource({
  required final DeviceStorageReader reader,
}) {
  DeviceStorage? read({required String path}) {
    try {
      return reader.read(path: path);
    } on DeviceStorageException catch (error, stackTrace) {
      talker.warning(
        '[Replay] failed to read device storage',
        error,
        stackTrace,
      );
      return null;
    }
  }
}
