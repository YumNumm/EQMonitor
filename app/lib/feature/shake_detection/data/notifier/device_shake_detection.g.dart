// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'device_shake_detection.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 強震モニタの画像から端末内で検知した揺れの、最新フレームの結果。

@ProviderFor(DeviceShakeDetection)
final deviceShakeDetectionProvider = DeviceShakeDetectionProvider._();

/// 強震モニタの画像から端末内で検知した揺れの、最新フレームの結果。
final class DeviceShakeDetectionProvider
    extends
        $NotifierProvider<DeviceShakeDetection, DeviceShakeDetectionFrame?> {
  /// 強震モニタの画像から端末内で検知した揺れの、最新フレームの結果。
  DeviceShakeDetectionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceShakeDetectionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceShakeDetectionHash();

  @$internal
  @override
  DeviceShakeDetection create() => DeviceShakeDetection();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceShakeDetectionFrame? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceShakeDetectionFrame?>(value),
    );
  }
}

String _$deviceShakeDetectionHash() =>
    r'7613c63c2d92de41ca464ca94096118530de40d9';

/// 強震モニタの画像から端末内で検知した揺れの、最新フレームの結果。

abstract class _$DeviceShakeDetection
    extends $Notifier<DeviceShakeDetectionFrame?> {
  DeviceShakeDetectionFrame? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<DeviceShakeDetectionFrame?, DeviceShakeDetectionFrame?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                DeviceShakeDetectionFrame?,
                DeviceShakeDetectionFrame?
              >,
              DeviceShakeDetectionFrame?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
