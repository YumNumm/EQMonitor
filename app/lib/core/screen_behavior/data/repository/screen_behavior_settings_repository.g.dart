// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'screen_behavior_settings_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(screenBehaviorSettingsRepository)
final screenBehaviorSettingsRepositoryProvider =
    ScreenBehaviorSettingsRepositoryProvider._();

final class ScreenBehaviorSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<ScreenBehaviorSettingsRepository>,
          ScreenBehaviorSettingsRepository,
          FutureOr<ScreenBehaviorSettingsRepository>
        >
    with
        $FutureModifier<ScreenBehaviorSettingsRepository>,
        $FutureProvider<ScreenBehaviorSettingsRepository> {
  ScreenBehaviorSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenBehaviorSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenBehaviorSettingsRepositoryHash();

  @$internal
  @override
  $FutureProviderElement<ScreenBehaviorSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ScreenBehaviorSettingsRepository> create(Ref ref) {
    return screenBehaviorSettingsRepository(ref);
  }
}

String _$screenBehaviorSettingsRepositoryHash() =>
    r'ef0eb6f6553242d001c99be0ff36692eee702514';
