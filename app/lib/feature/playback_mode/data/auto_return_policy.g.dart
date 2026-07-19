// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auto_return_policy.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(autoReturnPolicy)
final autoReturnPolicyProvider = AutoReturnPolicyProvider._();

final class AutoReturnPolicyProvider
    extends
        $FunctionalProvider<
          AutoReturnPolicy,
          AutoReturnPolicy,
          AutoReturnPolicy
        >
    with $Provider<AutoReturnPolicy> {
  AutoReturnPolicyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoReturnPolicyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoReturnPolicyHash();

  @$internal
  @override
  $ProviderElement<AutoReturnPolicy> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AutoReturnPolicy create(Ref ref) {
    return autoReturnPolicy(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AutoReturnPolicy value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AutoReturnPolicy>(value),
    );
  }
}

String _$autoReturnPolicyHash() => r'a407131932305ce0c2f0c9db98c7026491bf4fd1';
