import 'package:native_plugin/src/device_storage/device_storage_reader.dart';
import 'package:native_plugin/src/device_storage/model/device_storage.dart';
import 'package:native_plugin/src/device_storage/model/device_storage_exception.dart';

class const UnsupportedDeviceStorageReader({
  required final String operatingSystem,
}) implements DeviceStorageReader {
  @override
  DeviceStorage read({required String path}) =>
      throw DeviceStorageException.unsupportedPlatform(
        operatingSystem: operatingSystem,
      );
}
