// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ShakeDetection)
const shakeDetectionProvider = ShakeDetectionProvider._();

final class ShakeDetectionProvider
    extends $AsyncNotifierProvider<ShakeDetection, List<ShakeDetectionEvent>> {
  const ShakeDetectionProvider._()
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
}

String _$shakeDetectionHash() => r'07bbd447c27e212010656596fbf04538fcc4c908';

abstract class _$ShakeDetection
    extends $AsyncNotifier<List<ShakeDetectionEvent>> {
  FutureOr<List<ShakeDetectionEvent>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ShakeDetectionEvent>>,
              List<ShakeDetectionEvent>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ShakeDetectionEvent>>,
                List<ShakeDetectionEvent>
              >,
              AsyncValue<List<ShakeDetectionEvent>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(ShakeDetectionKmoniPointsMerged)
const shakeDetectionKmoniPointsMergedProvider =
    ShakeDetectionKmoniPointsMergedProvider._();

final class ShakeDetectionKmoniPointsMergedProvider
    extends
        $AsyncNotifierProvider<
          ShakeDetectionKmoniPointsMerged,
          List<ShakeDetectionKmoniMergedEvent>
        > {
  const ShakeDetectionKmoniPointsMergedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionKmoniPointsMergedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionKmoniPointsMergedHash();

  @$internal
  @override
  ShakeDetectionKmoniPointsMerged create() => ShakeDetectionKmoniPointsMerged();
}

String _$shakeDetectionKmoniPointsMergedHash() =>
    r'6acb3dc3b31777fc938fbbc6304dd997fe855b44';

abstract class _$ShakeDetectionKmoniPointsMerged
    extends $AsyncNotifier<List<ShakeDetectionKmoniMergedEvent>> {
  FutureOr<List<ShakeDetectionKmoniMergedEvent>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<
              AsyncValue<List<ShakeDetectionKmoniMergedEvent>>,
              List<ShakeDetectionKmoniMergedEvent>
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ShakeDetectionKmoniMergedEvent>>,
                List<ShakeDetectionKmoniMergedEvent>
              >,
              AsyncValue<List<ShakeDetectionKmoniMergedEvent>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

@ProviderFor(_fetchShakeDetectionEvents)
const _fetchShakeDetectionEventsProvider =
    _FetchShakeDetectionEventsProvider._();

final class _FetchShakeDetectionEventsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ShakeDetectionEvent>>,
          List<ShakeDetectionEvent>,
          FutureOr<List<ShakeDetectionEvent>>
        >
    with
        $FutureModifier<List<ShakeDetectionEvent>>,
        $FutureProvider<List<ShakeDetectionEvent>> {
  const _FetchShakeDetectionEventsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_fetchShakeDetectionEventsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchShakeDetectionEventsHash();

  @$internal
  @override
  $FutureProviderElement<List<ShakeDetectionEvent>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ShakeDetectionEvent>> create(Ref ref) {
    return _fetchShakeDetectionEvents(ref);
  }
}

String _$fetchShakeDetectionEventsHash() =>
    r'f38c3e2f402f56379e8ee0ebb8c8eef755723690';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
