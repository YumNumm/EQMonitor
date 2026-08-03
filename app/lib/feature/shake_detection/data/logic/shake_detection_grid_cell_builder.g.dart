// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_grid_cell_builder.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionGridCellBuilder)
final shakeDetectionGridCellBuilderProvider =
    ShakeDetectionGridCellBuilderProvider._();

final class ShakeDetectionGridCellBuilderProvider
    extends
        $FunctionalProvider<
          ShakeDetectionGridCellBuilder,
          ShakeDetectionGridCellBuilder,
          ShakeDetectionGridCellBuilder
        >
    with $Provider<ShakeDetectionGridCellBuilder> {
  ShakeDetectionGridCellBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionGridCellBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionGridCellBuilderHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionGridCellBuilder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionGridCellBuilder create(Ref ref) {
    return shakeDetectionGridCellBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionGridCellBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionGridCellBuilder>(
        value,
      ),
    );
  }
}

String _$shakeDetectionGridCellBuilderHash() =>
    r'efd6f74df033f69adea943036dcbe02f33b18f94';
