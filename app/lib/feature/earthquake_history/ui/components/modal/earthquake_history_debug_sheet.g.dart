// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_debug_sheet.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeHistoryDebugSheetAction)
final earthquakeHistoryDebugSheetActionProvider =
    EarthquakeHistoryDebugSheetActionProvider._();

final class EarthquakeHistoryDebugSheetActionProvider
    extends
        $FunctionalProvider<
          EarthquakeHistoryDebugSheetAction,
          EarthquakeHistoryDebugSheetAction,
          EarthquakeHistoryDebugSheetAction
        >
    with $Provider<EarthquakeHistoryDebugSheetAction> {
  EarthquakeHistoryDebugSheetActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeHistoryDebugSheetActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$earthquakeHistoryDebugSheetActionHash();

  @$internal
  @override
  $ProviderElement<EarthquakeHistoryDebugSheetAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarthquakeHistoryDebugSheetAction create(Ref ref) {
    return earthquakeHistoryDebugSheetAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeHistoryDebugSheetAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeHistoryDebugSheetAction>(
        value,
      ),
    );
  }
}

String _$earthquakeHistoryDebugSheetActionHash() =>
    r'0b97efda3c2e8757a3a8684675894715f00c097d';
