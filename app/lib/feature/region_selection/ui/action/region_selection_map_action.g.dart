// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'region_selection_map_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(regionSelectionMapAction)
final regionSelectionMapActionProvider = RegionSelectionMapActionProvider._();

final class RegionSelectionMapActionProvider
    extends
        $FunctionalProvider<
          RegionSelectionMapAction,
          RegionSelectionMapAction,
          RegionSelectionMapAction
        >
    with $Provider<RegionSelectionMapAction> {
  RegionSelectionMapActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'regionSelectionMapActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$regionSelectionMapActionHash();

  @$internal
  @override
  $ProviderElement<RegionSelectionMapAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RegionSelectionMapAction create(Ref ref) {
    return regionSelectionMapAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RegionSelectionMapAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RegionSelectionMapAction>(value),
    );
  }
}

String _$regionSelectionMapActionHash() =>
    r'b97ea078c0cac1fa06b1140deba86c82f6433a34';
