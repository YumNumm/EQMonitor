import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_correlation_eew_factory.dart';
import 'package:eqmonitor/feature/shake_detection/data/logic/shake_detection_debug_report_builder.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_debug_report.dart';
import 'package:eqmonitor/feature/shake_detection/data/notifier/device_shake_detection.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_tuning_provider.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_eew_correlator_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shake_detection_debug_report_provider.g.dart';

/// デバッグ表示を出している間だけ計算する。
@riverpod
ShakeDetectionDebugReport shakeDetectionDebugReport(Ref ref) => ref
    .watch(shakeDetectionDebugReportBuilderProvider)
    .build(
      isEnabled: ref.watch(isDeviceShakeDetectionEnabledProvider),
      frame: ref.watch(deviceShakeDetectionProvider),
      stations:
          ref.watch(kyoshinImageObservationPointsProvider).value ?? const [],
      correlator: ref.watch(shakeEewCorrelatorProvider).value,
      eews: ref
          .watch(shakeCorrelationEewFactoryProvider)
          .create(ref.watch(eewAliveTelegramProvider) ?? const []),
    );
