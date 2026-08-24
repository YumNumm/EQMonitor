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
          AsyncValue<UserApiClient>,
          UserApiClient,
          FutureOr<UserApiClient>
        >
    with $FutureModifier<UserApiClient>, $FutureProvider<UserApiClient> {
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
  $FutureProviderElement<UserApiClient> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserApiClient> create(Ref ref) {
    return userApiClient(ref);
  }
}

String _$userApiClientHash() => r'3ee9c2e635b516e1a32ada0ec4bd34eb4ed5bcc6';
