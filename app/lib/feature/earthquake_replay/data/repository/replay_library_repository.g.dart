// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'replay_library_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(replayLibraryRepository)
final replayLibraryRepositoryProvider = ReplayLibraryRepositoryProvider._();

final class ReplayLibraryRepositoryProvider
    extends
        $FunctionalProvider<
          ReplayLibraryRepository,
          ReplayLibraryRepository,
          ReplayLibraryRepository
        >
    with $Provider<ReplayLibraryRepository> {
  ReplayLibraryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'replayLibraryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$replayLibraryRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReplayLibraryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReplayLibraryRepository create(Ref ref) {
    return replayLibraryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReplayLibraryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReplayLibraryRepository>(value),
    );
  }
}

String _$replayLibraryRepositoryHash() =>
    r'ebfc97a1d20547f7a7439b5c453a78cdadae67f8';
