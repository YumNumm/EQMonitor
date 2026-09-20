// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_history_map_popup.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeHistoryMapPopupAction)
final earthquakeHistoryMapPopupActionProvider =
    EarthquakeHistoryMapPopupActionProvider._();

final class EarthquakeHistoryMapPopupActionProvider
    extends
        $FunctionalProvider<
          EarthquakeHistoryMapPopupAction,
          EarthquakeHistoryMapPopupAction,
          EarthquakeHistoryMapPopupAction
        >
    with $Provider<EarthquakeHistoryMapPopupAction> {
  EarthquakeHistoryMapPopupActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeHistoryMapPopupActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeHistoryMapPopupActionHash();

  @$internal
  @override
  $ProviderElement<EarthquakeHistoryMapPopupAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarthquakeHistoryMapPopupAction create(Ref ref) {
    return earthquakeHistoryMapPopupAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeHistoryMapPopupAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeHistoryMapPopupAction>(
        value,
      ),
    );
  }
}

String _$earthquakeHistoryMapPopupActionHash() =>
    r'19cb5b8dc87d87464b85da6492ab2cefba69ff87';
