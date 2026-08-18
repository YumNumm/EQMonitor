// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'onboarding_permission_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(onboardingPermissionFlow)
final onboardingPermissionFlowProvider = OnboardingPermissionFlowProvider._();

final class OnboardingPermissionFlowProvider
    extends
        $FunctionalProvider<
          OnboardingPermissionFlow,
          OnboardingPermissionFlow,
          OnboardingPermissionFlow
        >
    with $Provider<OnboardingPermissionFlow> {
  OnboardingPermissionFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingPermissionFlowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingPermissionFlowHash();

  @$internal
  @override
  $ProviderElement<OnboardingPermissionFlow> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingPermissionFlow create(Ref ref) {
    return onboardingPermissionFlow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingPermissionFlow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingPermissionFlow>(value),
    );
  }
}

String _$onboardingPermissionFlowHash() =>
    r'73ea71d832fdf6a8f09615a83fc64ea49fc75d2e';
