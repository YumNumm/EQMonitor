// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'shake_detection_tuning_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 保存済みの設定。読み込みが終わるまでは初期値を返す。

@ProviderFor(shakeDetectionCurrentSettings)
final shakeDetectionCurrentSettingsProvider =
    ShakeDetectionCurrentSettingsProvider._();

/// 保存済みの設定。読み込みが終わるまでは初期値を返す。

final class ShakeDetectionCurrentSettingsProvider
    extends
        $FunctionalProvider<
          ShakeDetectionSettingsModel,
          ShakeDetectionSettingsModel,
          ShakeDetectionSettingsModel
        >
    with $Provider<ShakeDetectionSettingsModel> {
  /// 保存済みの設定。読み込みが終わるまでは初期値を返す。
  ShakeDetectionCurrentSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionCurrentSettingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionCurrentSettingsHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionSettingsModel> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionSettingsModel create(Ref ref) {
    return shakeDetectionCurrentSettings(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionSettingsModel value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionSettingsModel>(value),
    );
  }
}

String _$shakeDetectionCurrentSettingsHash() =>
    r'a11d9a113539e36f8b5bb88e161cae47d7f738a4';

@ProviderFor(shakeDetectionTuning)
final shakeDetectionTuningProvider = ShakeDetectionTuningProvider._();

final class ShakeDetectionTuningProvider
    extends
        $FunctionalProvider<
          ShakeDetectionTuning,
          ShakeDetectionTuning,
          ShakeDetectionTuning
        >
    with $Provider<ShakeDetectionTuning> {
  ShakeDetectionTuningProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shakeDetectionTuningProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shakeDetectionTuningHash();

  @$internal
  @override
  $ProviderElement<ShakeDetectionTuning> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShakeDetectionTuning create(Ref ref) {
    return shakeDetectionTuning(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShakeDetectionTuning value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShakeDetectionTuning>(value),
    );
  }
}

String _$shakeDetectionTuningHash() =>
    r'8968d64400a641efab21f9d624a75c332405839c';
