// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_creation_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayCreationRepository)
final replayCreationRepositoryProvider = ReplayCreationRepositoryProvider._();

final class ReplayCreationRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ReplayCreationRepository>,
          ReplayCreationRepository,
          FutureOr<ReplayCreationRepository>
        >
    with
        $FutureModifier<ReplayCreationRepository>,
        $FutureProvider<ReplayCreationRepository> {
  ReplayCreationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayCreationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayCreationRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ReplayCreationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ReplayCreationRepository> create(Ref ref) {
    return replayCreationRepository(ref);
  }
}

String _$replayCreationRepositoryHash() =>
    r'3b9875cd4e986311630c32ebee55a4bf101d68b9';
