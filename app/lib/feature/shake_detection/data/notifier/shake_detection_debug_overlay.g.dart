// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_debug_overlay.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShakeDetectionDebugOverlay)
final shakeDetectionDebugOverlayProvider =
    ShakeDetectionDebugOverlayProvider._();

final class ShakeDetectionDebugOverlayProvider
    extends
        $NotifierProvider<
          ShakeDetectionDebugOverlay,
          List<ShakeDetectionEvent>
        > {
  ShakeDetectionDebugOverlayProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionDebugOverlayProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionDebugOverlayHash();

  @$internal
  @override
  ShakeDetectionDebugOverlay create() => ShakeDetectionDebugOverlay();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionDebugOverlayHash() =>
    r'40953c0c21efc1761f5d8ee72f10fd40ce54acad';

abstract class _$ShakeDetectionDebugOverlay
    extends $Notifier<List<ShakeDetectionEvent>> {
  List<ShakeDetectionEvent> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<List<ShakeDetectionEvent>, List<ShakeDetectionEvent>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ShakeDetectionEvent>, List<ShakeDetectionEvent>>,
              List<ShakeDetectionEvent>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
