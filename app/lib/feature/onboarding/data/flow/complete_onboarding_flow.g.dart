// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'complete_onboarding_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(completeOnboardingFlow)
final completeOnboardingFlowProvider = CompleteOnboardingFlowProvider._();

final class CompleteOnboardingFlowProvider
    extends
        $FunctionalProvider<
          CompleteOnboardingFlow,
          CompleteOnboardingFlow,
          CompleteOnboardingFlow
        >
    with $Provider<CompleteOnboardingFlow> {
  CompleteOnboardingFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'completeOnboardingFlowProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$completeOnboardingFlowHash();

  @$internal
  @override
  $ProviderElement<CompleteOnboardingFlow> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CompleteOnboardingFlow create(Ref ref) {
    return completeOnboardingFlow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CompleteOnboardingFlow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CompleteOnboardingFlow>(value),
    );
  }
}

String _$completeOnboardingFlowHash() =>
    r'72620ad3b8aa6183b23a1f56417a874cdb1adc6e';
