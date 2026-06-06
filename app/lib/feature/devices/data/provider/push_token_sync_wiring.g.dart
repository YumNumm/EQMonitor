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
    r'27fada4798a19daa3e96d8ca6ee3269c83bd25db';
