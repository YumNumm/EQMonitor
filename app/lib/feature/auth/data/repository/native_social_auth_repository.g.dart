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
          AsyncValue<NativeSocialAuthRepository>,
          NativeSocialAuthRepository,
          FutureOr<NativeSocialAuthRepository>
        >
    with
        $FutureModifier<NativeSocialAuthRepository>,
        $FutureProvider<NativeSocialAuthRepository> {
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
  $FutureProviderElement<NativeSocialAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<NativeSocialAuthRepository> create(Ref ref) {
    return nativeSocialAuthRepository(ref);
  }
}

String _$nativeSocialAuthRepositoryHash() =>
    r'8562d8b71056695be3417d23ef2b33f26959a64d';
