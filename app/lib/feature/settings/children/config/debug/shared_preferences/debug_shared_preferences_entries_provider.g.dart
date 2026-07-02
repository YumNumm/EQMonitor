// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_shared_preferences_entries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugSharedPreferencesEntries)
final debugSharedPreferencesEntriesProvider =
    DebugSharedPreferencesEntriesProvider._();

final class DebugSharedPreferencesEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<({String key, Object? value})>>,
          List<({String key, Object? value})>,
          FutureOr<List<({String key, Object? value})>>
        >
    with
        $FutureModifier<List<({String key, Object? value})>>,
        $FutureProvider<List<({String key, Object? value})>> {
  DebugSharedPreferencesEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugSharedPreferencesEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugSharedPreferencesEntriesHash();

  @$internal
  @override
  $FutureProviderElement<List<({String key, Object? value})>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<({String key, Object? value})>> create(Ref ref) {
    return debugSharedPreferencesEntries(ref);
  }
}

String _$debugSharedPreferencesEntriesHash() =>
    r'4dcff6e8396c657e0a54df00acb583e2ac11c476';
