// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'eqmonitor_map_camera_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(eqmonitorMapCameraAction)
final eqmonitorMapCameraActionProvider = EqmonitorMapCameraActionProvider._();

final class EqmonitorMapCameraActionProvider
    extends
        $FunctionalProvider<
          EqmonitorMapCameraAction,
          EqmonitorMapCameraAction,
          EqmonitorMapCameraAction
        >
    with $Provider<EqmonitorMapCameraAction> {
  EqmonitorMapCameraActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eqmonitorMapCameraActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eqmonitorMapCameraActionHash();

  @$internal
  @override
  $ProviderElement<EqmonitorMapCameraAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EqmonitorMapCameraAction create(Ref ref) {
    return eqmonitorMapCameraAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EqmonitorMapCameraAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EqmonitorMapCameraAction>(value),
    );
  }
}

String _$eqmonitorMapCameraActionHash() =>
    r'2208fb004c0514881b7bfcac088b54dd3be62ab5';
