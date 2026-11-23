import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_storage.freezed.dart';

@freezed
sealed class const DeviceStorage._() with _$DeviceStorage {
  /// `android.os.StatFs` の値。[freeBytes] はアプリが使えない予約領域を含む。
  const factory android({
    required int totalBytes,
    required int availableBytes,
    required int freeBytes,
  }) = AndroidDeviceStorage;

  /// `NSURL` のボリューム容量。[importantUsageAvailableBytes] と
  /// [opportunisticUsageAvailableBytes] は、削除できるキャッシュを空きに含めた値。
  const factory ios({
    required int totalBytes,
    required int availableBytes,
    required int? importantUsageAvailableBytes,
    required int? opportunisticUsageAvailableBytes,
  }) = IosDeviceStorage;

  int get usableBytes => switch (this) {
    AndroidDeviceStorage(:final availableBytes) => availableBytes,
    IosDeviceStorage(
      :final availableBytes,
      :final importantUsageAvailableBytes,
    ) =>
      importantUsageAvailableBytes ?? availableBytes,
  };

  int get usedBytes => totalBytes - usableBytes;
}
