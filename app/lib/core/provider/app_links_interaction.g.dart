// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'app_links_interaction.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appLinksColdStartGate)
final appLinksColdStartGateProvider = AppLinksColdStartGateProvider._();

final class AppLinksColdStartGateProvider
    extends
        $FunctionalProvider<
          AppLinksColdStartGate,
          AppLinksColdStartGate,
          AppLinksColdStartGate
        >
    with $Provider<AppLinksColdStartGate> {
  AppLinksColdStartGateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLinksColdStartGateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLinksColdStartGateHash();

  @$internal
  @override
  $ProviderElement<AppLinksColdStartGate> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppLinksColdStartGate create(Ref ref) {
    return appLinksColdStartGate(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLinksColdStartGate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLinksColdStartGate>(value),
    );
  }
}

String _$appLinksColdStartGateHash() =>
    r'a73656b476b762a15f2722282658a84de364c69d';

@ProviderFor(appLinksInteraction)
final appLinksInteractionProvider = AppLinksInteractionProvider._();

final class AppLinksInteractionProvider
    extends $FunctionalProvider<AsyncValue<Uri>, Uri, Stream<Uri>>
    with $FutureModifier<Uri>, $StreamProvider<Uri> {
  AppLinksInteractionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLinksInteractionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLinksInteractionHash();

  @$internal
  @override
  $StreamProviderElement<Uri> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<Uri> create(Ref ref) {
    return appLinksInteraction(ref);
  }
}

String _$appLinksInteractionHash() =>
    r'b0856ecc69912b20f3adb93a364ef09f8769b95b';
