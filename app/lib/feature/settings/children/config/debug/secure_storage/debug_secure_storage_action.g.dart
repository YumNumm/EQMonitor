// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_secure_storage_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugSecureStorageAction)
final debugSecureStorageActionProvider = DebugSecureStorageActionProvider._();

final class DebugSecureStorageActionProvider
    extends
        $FunctionalProvider<
          DebugSecureStorageAction,
          DebugSecureStorageAction,
          DebugSecureStorageAction
        >
    with $Provider<DebugSecureStorageAction> {
  DebugSecureStorageActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugSecureStorageActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugSecureStorageActionHash();

  @$internal
  @override
  $ProviderElement<DebugSecureStorageAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DebugSecureStorageAction create(Ref ref) {
    return debugSecureStorageAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DebugSecureStorageAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DebugSecureStorageAction>(value),
    );
  }
}

String _$debugSecureStorageActionHash() =>
    r'ddaedb0974ee1edb8d538238c0fe53eac98b523e';
