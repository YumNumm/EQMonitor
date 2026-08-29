// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'auth_environment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authEnvironment)
final authEnvironmentProvider = AuthEnvironmentProvider._();

final class AuthEnvironmentProvider
    extends
        $FunctionalProvider<
          AsyncValue<Result<AuthEnvironment, AuthFailure>>,
          Result<AuthEnvironment, AuthFailure>,
          FutureOr<Result<AuthEnvironment, AuthFailure>>
        >
    with
        $FutureModifier<Result<AuthEnvironment, AuthFailure>>,
        $FutureProvider<Result<AuthEnvironment, AuthFailure>> {
  AuthEnvironmentProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authEnvironmentProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authEnvironmentHash();

  @$internal
  @override
  $FutureProviderElement<Result<AuthEnvironment, AuthFailure>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Result<AuthEnvironment, AuthFailure>> create(Ref ref) {
    return authEnvironment(ref);
  }
}

String _$authEnvironmentHash() => r'476a03e5bed09d10216f6a08bc8e5760f38cdf2d';
