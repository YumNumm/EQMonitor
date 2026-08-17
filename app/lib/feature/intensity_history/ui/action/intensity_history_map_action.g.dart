// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_history_map_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(intensityHistoryMapAction)
final intensityHistoryMapActionProvider = IntensityHistoryMapActionProvider._();

final class IntensityHistoryMapActionProvider
    extends
        $FunctionalProvider<
          IntensityHistoryMapAction,
          IntensityHistoryMapAction,
          IntensityHistoryMapAction
        >
    with $Provider<IntensityHistoryMapAction> {
  IntensityHistoryMapActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityHistoryMapActionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityHistoryMapActionHash();

  @$internal
  @override
  $ProviderElement<IntensityHistoryMapAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IntensityHistoryMapAction create(Ref ref) {
    return intensityHistoryMapAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntensityHistoryMapAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntensityHistoryMapAction>(value),
    );
  }
}

String _$intensityHistoryMapActionHash() =>
    r'ed2b871ddbaad32efa1705f4067ff3ef56bda237';
