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
          AsyncValue<PasskeyAuthGateway>,
          PasskeyAuthGateway,
          FutureOr<PasskeyAuthGateway>
        >
    with
        $FutureModifier<PasskeyAuthGateway>,
        $FutureProvider<PasskeyAuthGateway> {
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
  $FutureProviderElement<PasskeyAuthGateway> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PasskeyAuthGateway> create(Ref ref) {
    return passkeyRepository(ref);
  }
}

String _$passkeyRepositoryHash() => r'97f46b003596f1ccd6ba5b7517d15c38ed4405a3';
