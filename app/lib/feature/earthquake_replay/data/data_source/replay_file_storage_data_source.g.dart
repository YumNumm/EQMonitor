// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_file_storage_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayFileStorageDataSource)
final replayFileStorageDataSourceProvider =
    ReplayFileStorageDataSourceProvider._();

final class ReplayFileStorageDataSourceProvider
    extends
        $FunctionalProvider<
          ReplayFileStorageDataSource,
          ReplayFileStorageDataSource,
          ReplayFileStorageDataSource
        >
    with $Provider<ReplayFileStorageDataSource> {
  ReplayFileStorageDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayFileStorageDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayFileStorageDataSourceHash();

  @$internal
  @override
  $ProviderElement<ReplayFileStorageDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayFileStorageDataSource create(Ref ref) {
    return replayFileStorageDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayFileStorageDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayFileStorageDataSource>(value),
    );
  }
}

String _$replayFileStorageDataSourceHash() =>
    r'f8efcf9ec18039375a28533e49cb787563cbd240';
