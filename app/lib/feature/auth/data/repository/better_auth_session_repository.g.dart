// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'better_auth_session_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(betterAuthSessionRepository)
final betterAuthSessionRepositoryProvider =
    BetterAuthSessionRepositoryProvider._();

final class BetterAuthSessionRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<BetterAuthSessionRepository>,
          BetterAuthSessionRepository,
          FutureOr<BetterAuthSessionRepository>
        >
    with
        $FutureModifier<BetterAuthSessionRepository>,
        $FutureProvider<BetterAuthSessionRepository> {
  BetterAuthSessionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'betterAuthSessionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$betterAuthSessionRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<BetterAuthSessionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<BetterAuthSessionRepository> create(Ref ref) {
    return betterAuthSessionRepository(ref);
  }
}

String _$betterAuthSessionRepositoryHash() =>
    r'90f6075dbae70a9b28fee12c0cfadb29113ae7db';
