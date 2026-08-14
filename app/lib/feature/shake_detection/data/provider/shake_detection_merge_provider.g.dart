// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_merge_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionVisible)
final shakeDetectionVisibleProvider = ShakeDetectionVisibleProvider._();

final class ShakeDetectionVisibleProvider
    extends
        $FunctionalProvider<
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>,
          List<ShakeDetectionEvent>
        >
    with $Provider<List<ShakeDetectionEvent>> {
  ShakeDetectionVisibleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionVisibleProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionVisibleHash();

  @$internal
  @override
  $ProviderElement<List<ShakeDetectionEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  List<ShakeDetectionEvent> create(Ref ref) {
    return shakeDetectionVisible(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionVisibleHash() =>
    r'7dde8e6c8b8910755476ca58c29de8fac9a37f4f';
