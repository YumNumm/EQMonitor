// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'secure_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(secureStorage)
final secureStorageProvider = SecureStorageProvider._();

final class SecureStorageProvider
    extends
        $FunctionalProvider<
          AsyncValue<FlutterSecureStorage>,
          FlutterSecureStorage,
          FutureOr<FlutterSecureStorage>
        >
    with
        $FutureModifier<FlutterSecureStorage>,
        $FutureProvider<FlutterSecureStorage> {
  SecureStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'secureStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$secureStorageHash();

  @$internal
  @override
  $FutureProviderElement<FlutterSecureStorage> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FlutterSecureStorage> create(Ref ref) {
    return secureStorage(ref);
  }
}

String _$secureStorageHash() => r'9df46ddbe92d560b42b10f09cc6f8e50053cfd90';
