// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ShakeDetectionSettingsNotifier)
final shakeDetectionSettingsProvider =
    ShakeDetectionSettingsNotifierProvider._();

final class ShakeDetectionSettingsNotifierProvider
    extends
        $AsyncNotifierProvider<
          ShakeDetectionSettingsNotifier,
          ShakeDetectionState
        > {
  ShakeDetectionSettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionSettingsNotifierHash();

  @$internal
  @override
  ShakeDetectionSettingsNotifier create() => ShakeDetectionSettingsNotifier();
}

String _$shakeDetectionSettingsNotifierHash() =>
    r'0fdf9627fc6827e3d721f971bfdb5b10fe68513c';

abstract class _$ShakeDetectionSettingsNotifier
    extends $AsyncNotifier<ShakeDetectionState> {
  FutureOr<ShakeDetectionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ShakeDetectionState>, ShakeDetectionState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ShakeDetectionState>, ShakeDetectionState>,
              AsyncValue<ShakeDetectionState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
