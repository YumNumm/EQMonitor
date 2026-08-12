// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_secure_storage_entries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugSecureStorageEntries)
final debugSecureStorageEntriesProvider = DebugSecureStorageEntriesProvider._();

final class DebugSecureStorageEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<({String key, String value})>>,
          List<({String key, String value})>,
          FutureOr<List<({String key, String value})>>
        >
    with
        $FutureModifier<List<({String key, String value})>>,
        $FutureProvider<List<({String key, String value})>> {
  DebugSecureStorageEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugSecureStorageEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugSecureStorageEntriesHash();

  @$internal
  @override
  $FutureProviderElement<List<({String key, String value})>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<({String key, String value})>> create(Ref ref) {
    return debugSecureStorageEntries(ref);
  }
}

String _$debugSecureStorageEntriesHash() =>
    r'5da2ee33ba5a9ece115c39a83bcace947d5ee8c1';
