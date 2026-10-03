// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'push_token_sync_state_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pushTokenSyncStateRepository)
final pushTokenSyncStateRepositoryProvider =
    PushTokenSyncStateRepositoryProvider._();

final class PushTokenSyncStateRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<PushTokenSyncStateRepository>,
          PushTokenSyncStateRepository,
          FutureOr<PushTokenSyncStateRepository>
        >
    with
        $FutureModifier<PushTokenSyncStateRepository>,
        $FutureProvider<PushTokenSyncStateRepository> {
  PushTokenSyncStateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushTokenSyncStateRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushTokenSyncStateRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<PushTokenSyncStateRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PushTokenSyncStateRepository> create(Ref ref) {
    return pushTokenSyncStateRepository(ref);
  }
}

String _$pushTokenSyncStateRepositoryHash() =>
    r'98216526040ec1ab8c66430f5ba6584e45395284';
