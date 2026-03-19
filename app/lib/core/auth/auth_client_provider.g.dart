// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auth_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authTokenStore)
final authTokenStoreProvider = AuthTokenStoreProvider._();

final class AuthTokenStoreProvider
    extends $FunctionalProvider<AuthTokenStore, AuthTokenStore, AuthTokenStore>
    with $Provider<AuthTokenStore> {
  AuthTokenStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authTokenStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authTokenStoreHash();

  @$internal
  @override
  $ProviderElement<AuthTokenStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthTokenStore create(Ref ref) {
    return authTokenStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthTokenStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthTokenStore>(value),
    );
  }
}

String _$authTokenStoreHash() => r'6f411afa2574f45a75c232075512a269d2aa442d';

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

String _$authApiClientHash() => r'9636aa64f977ade8ec5047ef3e94920ad975bb4f';
