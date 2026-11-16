// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_settings.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShakeDetectionSettings)
final shakeDetectionSettingsProvider = ShakeDetectionSettingsProvider._();

final class ShakeDetectionSettingsProvider
    extends
        $AsyncNotifierProvider<
          ShakeDetectionSettings,
          ShakeDetectionSettingsModel
        > {
  ShakeDetectionSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionSettingsHash();

  @$internal
  @override
  ShakeDetectionSettings create() => ShakeDetectionSettings();
}

String _$shakeDetectionSettingsHash() =>
    r'27d8ccd24d7784b4bff364135a910a6d80ab9001';

abstract class _$ShakeDetectionSettings
    extends $AsyncNotifier<ShakeDetectionSettingsModel> {
  FutureOr<ShakeDetectionSettingsModel> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              AsyncValue<ShakeDetectionSettingsModel>,
              ShakeDetectionSettingsModel
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<ShakeDetectionSettingsModel>,
                ShakeDetectionSettingsModel
              >,
              AsyncValue<ShakeDetectionSettingsModel>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
