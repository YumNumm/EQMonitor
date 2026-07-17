// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'push_token_sync_wiring.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pushTokenSyncWiring)
final pushTokenSyncWiringProvider = PushTokenSyncWiringProvider._();

final class PushTokenSyncWiringProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  PushTokenSyncWiringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushTokenSyncWiringProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushTokenSyncWiringHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return pushTokenSyncWiring(ref);
  }
}

String _$pushTokenSyncWiringHash() =>
    r'950d83d5fa2d708df422f7a191d4515ec6fb7902';
