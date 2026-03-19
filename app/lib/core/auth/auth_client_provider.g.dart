// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auth_client_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authClient)
final authClientProvider = AuthClientProvider._();

final class AuthClientProvider
    extends
        $FunctionalProvider<
          BetterAuthClient<User>,
          BetterAuthClient<User>,
          BetterAuthClient<User>
        >
    with $Provider<BetterAuthClient<User>> {
  AuthClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authClientHash();

  @$internal
  @override
  $ProviderElement<BetterAuthClient<User>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BetterAuthClient<User> create(Ref ref) {
    return authClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BetterAuthClient<User> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BetterAuthClient<User>>(value),
    );
  }
}

String _$authClientHash() => r'0c25dd8c6daa1bdcdc08ccd7717dd470bf68c4f0';
