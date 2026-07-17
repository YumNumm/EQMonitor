// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'push_token_platform_capabilities.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(pushTokenPlatformCapabilities)
final pushTokenPlatformCapabilitiesProvider =
    PushTokenPlatformCapabilitiesProvider._();

final class PushTokenPlatformCapabilitiesProvider
    extends
        $FunctionalProvider<
          PushTokenPlatformCapabilities,
          PushTokenPlatformCapabilities,
          PushTokenPlatformCapabilities
        >
    with $Provider<PushTokenPlatformCapabilities> {
  PushTokenPlatformCapabilitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pushTokenPlatformCapabilitiesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pushTokenPlatformCapabilitiesHash();

  @$internal
  @override
  $ProviderElement<PushTokenPlatformCapabilities> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PushTokenPlatformCapabilities create(Ref ref) {
    return pushTokenPlatformCapabilities(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PushTokenPlatformCapabilities value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PushTokenPlatformCapabilities>(
        value,
      ),
    );
  }
}

String _$pushTokenPlatformCapabilitiesHash() =>
    r'906bd0e74a1c2fd27c47490cafac673247b32391';
