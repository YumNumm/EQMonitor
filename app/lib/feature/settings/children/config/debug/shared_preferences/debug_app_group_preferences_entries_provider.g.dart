// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'debug_app_group_preferences_entries_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(debugAppGroupPreferencesEntries)
final debugAppGroupPreferencesEntriesProvider =
    DebugAppGroupPreferencesEntriesProvider._();

final class DebugAppGroupPreferencesEntriesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<({String key, Object? value})>>,
          List<({String key, Object? value})>,
          FutureOr<List<({String key, Object? value})>>
        >
    with
        $FutureModifier<List<({String key, Object? value})>>,
        $FutureProvider<List<({String key, Object? value})>> {
  DebugAppGroupPreferencesEntriesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'debugAppGroupPreferencesEntriesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$debugAppGroupPreferencesEntriesHash();

  @$internal
  @override
  $FutureProviderElement<List<({String key, Object? value})>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<({String key, Object? value})>> create(Ref ref) {
    return debugAppGroupPreferencesEntries(ref);
  }
}

String _$debugAppGroupPreferencesEntriesHash() =>
    r'832668c8f583f3b0ab2f0aebdcfdb86c09c30de3';
