// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_file_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayFileRepository)
final replayFileRepositoryProvider = ReplayFileRepositoryProvider._();

final class ReplayFileRepositoryProvider
    extends
        $FunctionalProvider<
          ReplayFileRepository,
          ReplayFileRepository,
          ReplayFileRepository
        >
    with $Provider<ReplayFileRepository> {
  ReplayFileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayFileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayFileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReplayFileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayFileRepository create(Ref ref) {
    return replayFileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayFileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayFileRepository>(value),
    );
  }
}

String _$replayFileRepositoryHash() =>
    r'31862d425d083918903406383e4e246fd2d154a0';
