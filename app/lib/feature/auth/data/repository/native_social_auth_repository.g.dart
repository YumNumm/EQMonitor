// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'native_social_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nativeSocialAuthRepository)
final nativeSocialAuthRepositoryProvider =
    NativeSocialAuthRepositoryProvider._();

final class NativeSocialAuthRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<NativeSocialAuthGateway>,
          NativeSocialAuthGateway,
          FutureOr<NativeSocialAuthGateway>
        >
    with
        $FutureModifier<NativeSocialAuthGateway>,
        $FutureProvider<NativeSocialAuthGateway> {
  NativeSocialAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nativeSocialAuthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nativeSocialAuthRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<NativeSocialAuthGateway> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NativeSocialAuthGateway> create(Ref ref) {
    return nativeSocialAuthRepository(ref);
  }
}

String _$nativeSocialAuthRepositoryHash() =>
    r'fda28167b386f7133f7ed26ac1ceb32aadcc55d0';
