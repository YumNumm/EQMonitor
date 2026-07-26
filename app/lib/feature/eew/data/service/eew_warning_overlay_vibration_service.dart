import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:vibration/vibration.dart';

part 'eew_warning_overlay_vibration_service.g.dart';

const eewWarningOverlayVibrationPattern = <int>[
  0,
  700,
  300,
  700,
  300,
  700,
  300,
  700,
  300,
  700,
  300,
  700,
  300,
  700,
  300,
  700,
  300,
  700,
  300,
  700,
];

abstract interface class EewWarningOverlayVibrationGateway {
  Future<bool> hasVibrator();

  Future<bool> hasCustomVibrationsSupport();

  Future<void> vibrate({required List<int> pattern});

  Future<void> vibrateOnce({required int durationMs});

  Future<void> cancel();
}

class VibrationPackageGateway implements EewWarningOverlayVibrationGateway {
  const VibrationPackageGateway();

  @override
  Future<bool> hasVibrator() => Vibration.hasVibrator();

  @override
  Future<bool> hasCustomVibrationsSupport() =>
      Vibration.hasCustomVibrationsSupport();

  @override
  Future<void> vibrate({required List<int> pattern}) =>
      Vibration.vibrate(pattern: pattern);

  @override
  Future<void> vibrateOnce({required int durationMs}) =>
      Vibration.vibrate(duration: durationMs);

  @override
  Future<void> cancel() => Vibration.cancel();
}

class EewWarningOverlayVibrationService {
  const EewWarningOverlayVibrationService({
    required EewWarningOverlayVibrationGateway gateway,
    required Talker talker,
  }) : _gateway = gateway,
       _talker = talker;

  final EewWarningOverlayVibrationGateway _gateway;
  final Talker _talker;

  Future<bool> start() async {
    try {
      if (!await _gateway.hasVibrator()) {
        return false;
      }
      if (await _gateway.hasCustomVibrationsSupport()) {
        await _gateway.vibrate(pattern: eewWarningOverlayVibrationPattern);
      } else {
        await _gateway.vibrateOnce(durationMs: 700);
      }
      return true;
    } on Object catch (error, stackTrace) {
      _talker.error(
        '[EEW warning overlay] vibration start failed',
        error,
        stackTrace,
      );
      return false;
    }
  }

  Future<void> cancel() async {
    try {
      await _gateway.cancel();
    } on Object catch (error, stackTrace) {
      _talker.error(
        '[EEW warning overlay] vibration cancel failed',
        error,
        stackTrace,
      );
    }
  }
}

@riverpod
EewWarningOverlayVibrationService eewWarningOverlayVibrationService(Ref ref) =>
    EewWarningOverlayVibrationService(
      gateway: const VibrationPackageGateway(),
      talker: talker,
    );
