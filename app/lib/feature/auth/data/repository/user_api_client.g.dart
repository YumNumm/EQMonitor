// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'user_api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userApiClient)
final userApiClientProvider = UserApiClientProvider._();

final class UserApiClientProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserApiGateway>,
          UserApiGateway,
          FutureOr<UserApiGateway>
        >
    with $FutureModifier<UserApiGateway>, $FutureProvider<UserApiGateway> {
  UserApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userApiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userApiClientHash();

  @$internal
  @override
  $FutureProviderElement<UserApiGateway> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserApiGateway> create(Ref ref) {
    return userApiClient(ref);
  }
}

String _$userApiClientHash() => r'da05dbea7785896dc10f138ec1d34c579bb69644';
