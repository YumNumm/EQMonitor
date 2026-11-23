import 'dart:io';

import 'package:native_plugin/src/device_storage/android/android_device_storage_reader.dart';
import 'package:native_plugin/src/device_storage/ios/ios_device_storage_reader.dart';
import 'package:native_plugin/src/device_storage/model/device_storage.dart';
import 'package:native_plugin/src/device_storage/unsupported_device_storage_reader.dart';

abstract interface class DeviceStorageReader {
  factory platform() => switch (Platform.operatingSystem) {
    'android' => const AndroidDeviceStorageReader(),
    'ios' => const IosDeviceStorageReader(),
    final operatingSystem => UnsupportedDeviceStorageReader(
      operatingSystem: operatingSystem,
    ),
  };

  /// [path] を含むボリュームの容量を返す。失敗時は [DeviceStorageException] を投げる。
  DeviceStorage read({required String path});
}
