// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'ai_credentials_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiCredentialsRepository)
final aiCredentialsRepositoryProvider = AiCredentialsRepositoryProvider._();

final class AiCredentialsRepositoryProvider
    extends
        $FunctionalProvider<
          AiCredentialsRepository,
          AiCredentialsRepository,
          AiCredentialsRepository
        >
    with $Provider<AiCredentialsRepository> {
  AiCredentialsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiCredentialsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiCredentialsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AiCredentialsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AiCredentialsRepository create(Ref ref) {
    return aiCredentialsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AiCredentialsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AiCredentialsRepository>(value),
    );
  }
}

String _$aiCredentialsRepositoryHash() =>
    r'34050bd5864f5e78fb5e10b92bcf3680e42d0add';
