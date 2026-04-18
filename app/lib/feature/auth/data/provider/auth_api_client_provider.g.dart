// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auth_api_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authApiClient)
final authApiClientProvider = AuthApiClientProvider._();

final class AuthApiClientProvider
    extends
        $FunctionalProvider<
          auth_api.ApiClient,
          auth_api.ApiClient,
          auth_api.ApiClient
        >
    with $Provider<auth_api.ApiClient> {
  AuthApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authApiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authApiClientHash();

  @$internal
  @override
  $ProviderElement<auth_api.ApiClient> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  auth_api.ApiClient create(Ref ref) {
    return authApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(auth_api.ApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<auth_api.ApiClient>(value),
    );
  }
}

String _$authApiClientHash() => r'fbd78dfdcd5c1521c84d5d6535ad5afdf83f3ee4';
