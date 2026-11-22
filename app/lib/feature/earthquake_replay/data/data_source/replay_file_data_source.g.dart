// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_file_data_source.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayFileDataSource)
final replayFileDataSourceProvider = ReplayFileDataSourceProvider._();

final class ReplayFileDataSourceProvider
    extends
        $FunctionalProvider<
          ReplayFileDataSource,
          ReplayFileDataSource,
          ReplayFileDataSource
        >
    with $Provider<ReplayFileDataSource> {
  ReplayFileDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayFileDataSourceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayFileDataSourceHash();

  @$internal
  @override
  $ProviderElement<ReplayFileDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayFileDataSource create(Ref ref) {
    return replayFileDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayFileDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayFileDataSource>(value),
    );
  }
}

String _$replayFileDataSourceHash() =>
    r'c47092676ee8fae717c7298712add7eff5921353';
