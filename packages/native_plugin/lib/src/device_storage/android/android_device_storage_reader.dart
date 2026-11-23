import 'package:jni/jni.dart';
import 'package:native_plugin/src/device_storage/android/android_bindings.g.dart';
import 'package:native_plugin/src/device_storage/device_storage_reader.dart';
import 'package:native_plugin/src/device_storage/model/device_storage.dart';
import 'package:native_plugin/src/device_storage/model/device_storage_exception.dart';

class const AndroidDeviceStorageReader() implements DeviceStorageReader {
  @override
  DeviceStorage read({required String path}) {
    try {
      return using((arena) {
        final stat = StatFs(path.toJString()..releasedBy(arena))
          ..releasedBy(arena);
        return DeviceStorage.android(
          totalBytes: stat.totalBytes,
          availableBytes: stat.availableBytes,
          freeBytes: stat.freeBytes,
        );
      });
    } on JThrowable catch (error) {
      final message = error.toString();
      error.release();
      throw DeviceStorageException.nativeCallFailed(message: message);
    }
  }
}
