// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_event_assembler.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionEventAssembler)
final shakeDetectionEventAssemblerProvider =
    ShakeDetectionEventAssemblerProvider._();

final class ShakeDetectionEventAssemblerProvider
    extends
        $FunctionalProvider<
          ShakeDetectionEventAssembler,
          ShakeDetectionEventAssembler,
          ShakeDetectionEventAssembler
        >
    with $Provider<ShakeDetectionEventAssembler> {
  ShakeDetectionEventAssemblerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionEventAssemblerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionEventAssemblerHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionEventAssembler> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionEventAssembler create(Ref ref) {
    return shakeDetectionEventAssembler(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionEventAssembler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionEventAssembler>(value),
    );
  }
}

String _$shakeDetectionEventAssemblerHash() =>
    r'1fe740e35ce065d31aeeb622bbf52fde01964877';
