// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'paywall_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(paywallFlow)
final paywallFlowProvider = PaywallFlowProvider._();

final class PaywallFlowProvider
    extends $FunctionalProvider<PaywallFlow, PaywallFlow, PaywallFlow>
    with $Provider<PaywallFlow> {
  PaywallFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'paywallFlowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$paywallFlowHash();

  @$internal
  @override
  $ProviderElement<PaywallFlow> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PaywallFlow create(Ref ref) {
    return paywallFlow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PaywallFlow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PaywallFlow>(value),
    );
  }
}

String _$paywallFlowHash() => r'913a679cdd55bd6a49432c98235c911eeac17365';
