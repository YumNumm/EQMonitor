// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'earthquake_vxse_debug_action.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(earthquakeVxseDebugAction)
final earthquakeVxseDebugActionProvider = EarthquakeVxseDebugActionProvider._();

final class EarthquakeVxseDebugActionProvider
    extends
        $FunctionalProvider<
          EarthquakeVxseDebugAction,
          EarthquakeVxseDebugAction,
          EarthquakeVxseDebugAction
        >
    with $Provider<EarthquakeVxseDebugAction> {
  EarthquakeVxseDebugActionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'earthquakeVxseDebugActionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$earthquakeVxseDebugActionHash();

  @$internal
  @override
  $ProviderElement<EarthquakeVxseDebugAction> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EarthquakeVxseDebugAction create(Ref ref) {
    return earthquakeVxseDebugAction(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EarthquakeVxseDebugAction value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EarthquakeVxseDebugAction>(value),
    );
  }
}

String _$earthquakeVxseDebugActionHash() =>
    r'381ffada49087f060b3c4dd168a4ac31947d5b4e';
