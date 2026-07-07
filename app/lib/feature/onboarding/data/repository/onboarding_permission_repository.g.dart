// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'onboarding_permission_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(onboardingPermissionRepository)
final onboardingPermissionRepositoryProvider =
    OnboardingPermissionRepositoryProvider._();

final class OnboardingPermissionRepositoryProvider
    extends
        $FunctionalProvider<
          OnboardingPermissionRepository,
          OnboardingPermissionRepository,
          OnboardingPermissionRepository
        >
    with $Provider<OnboardingPermissionRepository> {
  OnboardingPermissionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onboardingPermissionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onboardingPermissionRepositoryHash();

  @$internal
  @override
  $ProviderElement<OnboardingPermissionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OnboardingPermissionRepository create(Ref ref) {
    return onboardingPermissionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OnboardingPermissionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OnboardingPermissionRepository>(
        value,
      ),
    );
  }
}

String _$onboardingPermissionRepositoryHash() =>
    r'a64ce7dc8299577cc6120bc47aa90a44cd47a99b';
