// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_settings_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(shakeDetectionSettingsRepository)
final shakeDetectionSettingsRepositoryProvider =
    ShakeDetectionSettingsRepositoryProvider._();

final class ShakeDetectionSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ShakeDetectionSettingsRepository>,
          ShakeDetectionSettingsRepository,
          FutureOr<ShakeDetectionSettingsRepository>
        >
    with
        $FutureModifier<ShakeDetectionSettingsRepository>,
        $FutureProvider<ShakeDetectionSettingsRepository> {
  ShakeDetectionSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionSettingsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ShakeDetectionSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ShakeDetectionSettingsRepository> create(Ref ref) {
    return shakeDetectionSettingsRepository(ref);
  }
}

String _$shakeDetectionSettingsRepositoryHash() =>
    r'a39ee4b590a593397965c33575bc99bc66070571';
