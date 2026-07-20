// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_snapshot_reducer.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionSnapshotReducer)
final shakeDetectionSnapshotReducerProvider =
    ShakeDetectionSnapshotReducerProvider._();

final class ShakeDetectionSnapshotReducerProvider
    extends
        $FunctionalProvider<
          ShakeDetectionSnapshotReducer,
          ShakeDetectionSnapshotReducer,
          ShakeDetectionSnapshotReducer
        >
    with $Provider<ShakeDetectionSnapshotReducer> {
  ShakeDetectionSnapshotReducerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionSnapshotReducerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionSnapshotReducerHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionSnapshotReducer> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionSnapshotReducer create(Ref ref) {
    return shakeDetectionSnapshotReducer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionSnapshotReducer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionSnapshotReducer>(
        value,
      ),
    );
  }
}

String _$shakeDetectionSnapshotReducerHash() =>
    r'6ca1973aa164270c1c8a3f554b10445089cee959';
