// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'user_jwt_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userJwtService)
final userJwtServiceProvider = UserJwtServiceProvider._();

final class UserJwtServiceProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserJwtProvider>,
          UserJwtProvider,
          FutureOr<UserJwtProvider>
        >
    with $FutureModifier<UserJwtProvider>, $FutureProvider<UserJwtProvider> {
  UserJwtServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userJwtServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userJwtServiceHash();

  @$internal
  @override
  $FutureProviderElement<UserJwtProvider> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserJwtProvider> create(Ref ref) {
    return userJwtService(ref);
  }
}

String _$userJwtServiceHash() => r'5cfd65aed3f4d3bd17eeedb2d6d0d7449b5476cd';
