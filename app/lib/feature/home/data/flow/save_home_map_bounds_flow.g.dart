// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'save_home_map_bounds_flow.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveHomeMapBoundsFlow)
final saveHomeMapBoundsFlowProvider = SaveHomeMapBoundsFlowProvider._();

final class SaveHomeMapBoundsFlowProvider
    extends
        $FunctionalProvider<
          SaveHomeMapBoundsFlow,
          SaveHomeMapBoundsFlow,
          SaveHomeMapBoundsFlow
        >
    with $Provider<SaveHomeMapBoundsFlow> {
  SaveHomeMapBoundsFlowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveHomeMapBoundsFlowProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveHomeMapBoundsFlowHash();

  @$internal
  @override
  $ProviderElement<SaveHomeMapBoundsFlow> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveHomeMapBoundsFlow create(Ref ref) {
    return saveHomeMapBoundsFlow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveHomeMapBoundsFlow value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveHomeMapBoundsFlow>(value),
    );
  }
}

String _$saveHomeMapBoundsFlowHash() =>
    r'3475426281d65b05562c37ba8db1882d502bb3a6';
