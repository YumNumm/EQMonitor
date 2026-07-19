// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShakeDetection)
final shakeDetectionProvider = ShakeDetectionProvider._();

final class ShakeDetectionProvider
    extends $NotifierProvider<ShakeDetection, List<ShakeDetectionEvent>> {
  ShakeDetectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionHash();

  @$internal
  @override
  ShakeDetection create() => ShakeDetection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ShakeDetectionEvent> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ShakeDetectionEvent>>(value),
    );
  }
}

String _$shakeDetectionHash() => r'1434253db9b440329808087c16beb968ae731c06';

abstract class _$ShakeDetection extends $Notifier<List<ShakeDetectionEvent>> {
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
