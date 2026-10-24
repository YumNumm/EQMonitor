// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'local_shake_detection_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localShakeDetection)
final localShakeDetectionProvider = LocalShakeDetectionProvider._();

final class LocalShakeDetectionProvider
    extends
        $FunctionalProvider<
          AsyncValue<NativeShakeSnapshot?>,
          NativeShakeSnapshot?,
          Stream<NativeShakeSnapshot?>
        >
    with
        $FutureModifier<NativeShakeSnapshot?>,
        $StreamProvider<NativeShakeSnapshot?> {
  LocalShakeDetectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localShakeDetectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localShakeDetectionHash();

  @$internal
  @override
  $StreamProviderElement<NativeShakeSnapshot?> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<NativeShakeSnapshot?> create(Ref ref) {
    return localShakeDetection(ref);
  }
}

String _$localShakeDetectionHash() =>
    r'76d6a818f74add187307eda0d49abbced827f133';
