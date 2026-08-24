// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'apple_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appleAuthRepository)
final appleAuthRepositoryProvider = AppleAuthRepositoryProvider._();

final class AppleAuthRepositoryProvider
    extends
        $FunctionalProvider<
          AppleAuthRepository,
          AppleAuthRepository,
          AppleAuthRepository
        >
    with $Provider<AppleAuthRepository> {
  AppleAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appleAuthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appleAuthRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppleAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AppleAuthRepository create(Ref ref) {
    return appleAuthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppleAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppleAuthRepository>(value),
    );
  }
}

String _$appleAuthRepositoryHash() =>
    r'0b648f89123997b2f4bef49a808dcd07fe42ed9c';
