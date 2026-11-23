import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_storage_exception.freezed.dart';

@freezed
sealed class DeviceStorageException
    with _$DeviceStorageException
    implements Exception {
  const factory unsupportedPlatform({required String operatingSystem}) =
      DeviceStorageUnsupportedPlatformException;

  const factory nativeCallFailed({required String message}) =
      DeviceStorageNativeCallFailedException;
}
