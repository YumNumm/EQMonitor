// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auth_session_lifecycle.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authSessionLifecycle)
final authSessionLifecycleProvider = AuthSessionLifecycleProvider._();

final class AuthSessionLifecycleProvider
    extends
        $FunctionalProvider<
          AuthSessionLifecycle,
          AuthSessionLifecycle,
          AuthSessionLifecycle
        >
    with $Provider<AuthSessionLifecycle> {
  AuthSessionLifecycleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authSessionLifecycleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authSessionLifecycleHash();

  @$internal
  @override
  $ProviderElement<AuthSessionLifecycle> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AuthSessionLifecycle create(Ref ref) {
    return authSessionLifecycle(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthSessionLifecycle value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthSessionLifecycle>(value),
    );
  }
}

String _$authSessionLifecycleHash() =>
    r'04545fc0974d60e5d3462635bd83ee49af33c134';
