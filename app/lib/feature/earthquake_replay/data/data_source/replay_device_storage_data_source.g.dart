// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_device_storage_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayDeviceStorageDataSource)
final replayDeviceStorageDataSourceProvider =
    ReplayDeviceStorageDataSourceProvider._();

final class ReplayDeviceStorageDataSourceProvider
    extends
        $FunctionalProvider<
          ReplayDeviceStorageDataSource,
          ReplayDeviceStorageDataSource,
          ReplayDeviceStorageDataSource
        >
    with $Provider<ReplayDeviceStorageDataSource> {
  ReplayDeviceStorageDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayDeviceStorageDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayDeviceStorageDataSourceHash();

  @$internal
  @override
  $ProviderElement<ReplayDeviceStorageDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayDeviceStorageDataSource create(Ref ref) {
    return replayDeviceStorageDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayDeviceStorageDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayDeviceStorageDataSource>(
        value,
      ),
    );
  }
}

String _$replayDeviceStorageDataSourceHash() =>
    r'714eccd898db977ce6ed0b6f41d42721c5107404';
