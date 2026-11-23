import 'package:native_plugin/src/device_storage/device_storage_reader.dart';
import 'package:native_plugin/src/device_storage/ios/ios_bindings.g.dart';
import 'package:native_plugin/src/device_storage/model/device_storage.dart';
import 'package:native_plugin/src/device_storage/model/device_storage_exception.dart';
import 'package:objective_c/objective_c.dart';

class const IosDeviceStorageReader() implements DeviceStorageReader {
  @override
  DeviceStorage read({required String path}) {
    final NSDictionary? values;
    try {
      values = NSURL
          .fileURLWithPath(path.toNSString())
          .resourceValuesForKeys(
            NSArray.of([
              NSURLVolumeTotalCapacityKey,
              NSURLVolumeAvailableCapacityKey,
              NSURLVolumeAvailableCapacityForImportantUsageKey,
              NSURLVolumeAvailableCapacityForOpportunisticUsageKey,
            ]),
          );
    } on NSErrorException catch (error) {
      throw DeviceStorageException.nativeCallFailed(message: error.toString());
    }
    final totalBytes = number(values: values, key: NSURLVolumeTotalCapacityKey);
    final availableBytes = number(
      values: values,
      key: NSURLVolumeAvailableCapacityKey,
    );
    if (totalBytes == null || availableBytes == null) {
      throw const DeviceStorageException.nativeCallFailed(
        message: 'Volume capacity is unavailable',
      );
    }
    return DeviceStorage.ios(
      totalBytes: totalBytes,
      availableBytes: availableBytes,
      importantUsageAvailableBytes: number(
        values: values,
        key: NSURLVolumeAvailableCapacityForImportantUsageKey,
      ),
      opportunisticUsageAvailableBytes: number(
        values: values,
        key: NSURLVolumeAvailableCapacityForOpportunisticUsageKey,
      ),
    );
  }

  int? number({required NSDictionary? values, required NSString key}) {
    final value = values?.objectForKey(key);
    return value == null || !NSNumber.isA(value)
        ? null
        : NSNumber.as(value).longLongValue;
  }
}
