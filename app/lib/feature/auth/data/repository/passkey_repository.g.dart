// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'passkey_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(passkeyRepository)
final passkeyRepositoryProvider = PasskeyRepositoryProvider._();

final class PasskeyRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<PasskeyRepository>,
          PasskeyRepository,
          FutureOr<PasskeyRepository>
        >
    with
        $FutureModifier<PasskeyRepository>,
        $FutureProvider<PasskeyRepository> {
  PasskeyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passkeyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passkeyRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<PasskeyRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PasskeyRepository> create(Ref ref) {
    return passkeyRepository(ref);
  }
}

String _$passkeyRepositoryHash() => r'8fa03b027940809ee929995abe86e6214deac0f5';
