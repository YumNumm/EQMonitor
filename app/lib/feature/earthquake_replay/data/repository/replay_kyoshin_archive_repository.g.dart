// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_kyoshin_archive_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayKyoshinArchiveRepository)
final replayKyoshinArchiveRepositoryProvider =
    ReplayKyoshinArchiveRepositoryProvider._();

final class ReplayKyoshinArchiveRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReplayKyoshinArchiveRepository>,
          ReplayKyoshinArchiveRepository,
          FutureOr<ReplayKyoshinArchiveRepository>
        >
    with
        $FutureModifier<ReplayKyoshinArchiveRepository>,
        $FutureProvider<ReplayKyoshinArchiveRepository> {
  ReplayKyoshinArchiveRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayKyoshinArchiveRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayKyoshinArchiveRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ReplayKyoshinArchiveRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ReplayKyoshinArchiveRepository> create(Ref ref) {
    return replayKyoshinArchiveRepository(ref);
  }
}

String _$replayKyoshinArchiveRepositoryHash() =>
    r'2d59bde37fbe72707d4edd3219a03bf7f404d1f5';
