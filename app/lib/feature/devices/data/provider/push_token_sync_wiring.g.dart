// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'push_token_sync_wiring.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pushTokenSyncStartup)
final pushTokenSyncStartupProvider = PushTokenSyncStartupProvider._();

final class PushTokenSyncStartupProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  PushTokenSyncStartupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushTokenSyncStartupProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushTokenSyncStartupHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return pushTokenSyncStartup(ref);
  }
}

String _$pushTokenSyncStartupHash() =>
    r'1ec239946d7ea6e37c1154e616630ae7465648f7';

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
    r'32683832b416b452d33f80c71cb0f24849623c26';
