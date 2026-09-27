// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'intensity_fill_layer_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(intensityFillLayerAction)
final intensityFillLayerActionProvider = IntensityFillLayerActionProvider._();

final class IntensityFillLayerActionProvider
    extends
        $FunctionalProvider<
          IntensityFillLayerAction,
          IntensityFillLayerAction,
          IntensityFillLayerAction
        >
    with $Provider<IntensityFillLayerAction> {
  IntensityFillLayerActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intensityFillLayerActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intensityFillLayerActionHash();

  @$internal
  @override
  $ProviderElement<IntensityFillLayerAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  IntensityFillLayerAction create(Ref ref) {
    return intensityFillLayerAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntensityFillLayerAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntensityFillLayerAction>(value),
    );
  }
}

String _$intensityFillLayerActionHash() =>
    r'fb2faf5fb318ace1b194a523a55687374a9104b1';
