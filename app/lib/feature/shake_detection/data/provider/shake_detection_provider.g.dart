// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShakeDetectionAcceptedSnapshot)
final shakeDetectionAcceptedSnapshotProvider =
    ShakeDetectionAcceptedSnapshotProvider._();

final class ShakeDetectionAcceptedSnapshotProvider
    extends
        $NotifierProvider<
          ShakeDetectionAcceptedSnapshot,
          ShakeDetectionSnapshot?
        > {
  ShakeDetectionAcceptedSnapshotProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionAcceptedSnapshotProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionAcceptedSnapshotHash();

  @$internal
  @override
  ShakeDetectionAcceptedSnapshot create() => ShakeDetectionAcceptedSnapshot();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionSnapshot? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionSnapshot?>(value),
    );
  }
}

String _$shakeDetectionAcceptedSnapshotHash() =>
    r'43960d352b396076f8e856af2e49e3b9720f9a22';

abstract class _$ShakeDetectionAcceptedSnapshot
    extends $Notifier<ShakeDetectionSnapshot?> {
  ShakeDetectionSnapshot? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<ShakeDetectionSnapshot?, ShakeDetectionSnapshot?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ShakeDetectionSnapshot?, ShakeDetectionSnapshot?>,
              ShakeDetectionSnapshot?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

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

String _$shakeDetectionHash() => r'767b3cda3de475432fc0e104d9cd8c4466c9e25c';

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
