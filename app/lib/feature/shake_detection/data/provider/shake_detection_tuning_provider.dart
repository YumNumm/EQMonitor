import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_tuning_resolver.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_settings_model.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_tuning.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/shake_detection_settings.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_tuning_provider.g.dart';

/// 保存済みの設定。読み込みが終わるまでは初期値を返す。
@Riverpod(keepAlive: true)
ShakeDetectionSettingsModel shakeDetectionCurrentSettings(Ref ref) =>
    ref.watch(shakeDetectionSettingsProvider).value ??
    const ShakeDetectionSettingsModel();

/// 端末内の揺れ検知が有効かどうか。ビルド種別には依存しない。
@Riverpod(keepAlive: true)
bool isDeviceShakeDetectionEnabled(Ref ref) => ref.watch(
  shakeDetectionCurrentSettingsProvider.select(
    (settings) => settings.isEnabled,
  ),
);

@Riverpod(keepAlive: true)
ShakeDetectionTuning shakeDetectionTuning(Ref ref) => ref
    .watch(shakeDetectionTuningResolverProvider)
    .resolve(
      ref.watch(
        shakeDetectionCurrentSettingsProvider.select(
          (settings) => settings.parameterOverrides,
        ),
      ),
    );
