// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionRepository)
final shakeDetectionRepositoryProvider = ShakeDetectionRepositoryProvider._();

final class ShakeDetectionRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ShakeDetectionRepository>,
          ShakeDetectionRepository,
          FutureOr<ShakeDetectionRepository>
        >
    with
        $FutureModifier<ShakeDetectionRepository>,
        $FutureProvider<ShakeDetectionRepository> {
  ShakeDetectionRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ShakeDetectionRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ShakeDetectionRepository> create(Ref ref) {
    return shakeDetectionRepository(ref);
  }
}

String _$shakeDetectionRepositoryHash() =>
    r'91b5c6a71cce1fcc4cb87f556b7a155c9a36705a';
