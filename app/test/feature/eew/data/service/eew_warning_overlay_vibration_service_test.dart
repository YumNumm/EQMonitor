import 'package:eqmonitor/feature/eew/data/service/eew_warning_overlay_vibration_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  test('custom vibration starts the finite requested pulse pattern', () async {
    final gateway = _FakeVibrationGateway(
      hasVibratorResult: true,
      hasCustomVibrationsSupportResult: true,
    );
    final service = EewWarningOverlayVibrationService(
      gateway: gateway,
      talker: Talker(),
    );

    await service.start();

    expect(gateway.pattern, eewWarningOverlayVibrationPattern);
    expect(gateway.vibrateCalls, 1);
    expect(gateway.vibrateOnceCalls, 0);
    expect(eewWarningOverlayVibrationPattern, const <int>[
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
    ]);
    expect(eewWarningOverlayVibrationPattern.reduce((a, b) => a + b), 9700);
  });

  test(
    'device without custom support uses one finite fallback pulse',
    () async {
      final gateway = _FakeVibrationGateway(
        hasVibratorResult: true,
        hasCustomVibrationsSupportResult: false,
      );

      await EewWarningOverlayVibrationService(
        gateway: gateway,
        talker: Talker(),
      ).start();

      expect(gateway.vibrateCalls, 0);
      expect(gateway.vibrateOnceCalls, 1);
      expect(gateway.durationMs, 700);
    },
  );

  test('unsupported device is ignored', () async {
    final gateway = _FakeVibrationGateway(hasVibratorResult: false);

    await EewWarningOverlayVibrationService(
      gateway: gateway,
      talker: Talker(),
    ).start();

    expect(gateway.vibrateCalls, 0);
    expect(gateway.vibrateOnceCalls, 0);
  });

  test('plugin errors from start and cancel do not escape', () async {
    final gateway = _FakeVibrationGateway(
      hasVibratorResult: true,
      error: StateError('disabled'),
    );
    final service = EewWarningOverlayVibrationService(
      gateway: gateway,
      talker: Talker(),
    );

    await expectLater(service.start(), completes);
    await expectLater(service.cancel(), completes);
  });

  test('cancel delegates to the gateway', () async {
    final gateway = _FakeVibrationGateway(hasVibratorResult: true);

    await EewWarningOverlayVibrationService(
      gateway: gateway,
      talker: Talker(),
    ).cancel();

    expect(gateway.cancelCalls, 1);
  });
}

final class _FakeVibrationGateway implements EewWarningOverlayVibrationGateway {
  _FakeVibrationGateway({
    required this.hasVibratorResult,
    this.hasCustomVibrationsSupportResult = false,
    this.error,
  });

  final bool hasVibratorResult;
  final bool hasCustomVibrationsSupportResult;
  final Object? error;

  int vibrateCalls = 0;
  int vibrateOnceCalls = 0;
  int cancelCalls = 0;
  List<int>? pattern;
  int? durationMs;

  @override
  Future<bool> hasCustomVibrationsSupport() async {
    final configuredError = error;
    if (configuredError != null) {
      throw configuredError;
    }
    return hasCustomVibrationsSupportResult;
  }

  @override
  Future<bool> hasVibrator() async {
    final configuredError = error;
    if (configuredError != null) {
      throw configuredError;
    }
    return hasVibratorResult;
  }

  @override
  Future<void> vibrate({required List<int> pattern}) async {
    final configuredError = error;
    if (configuredError != null) {
      throw configuredError;
    }
    vibrateCalls += 1;
    this.pattern = pattern;
  }

  @override
  Future<void> vibrateOnce({required int durationMs}) async {
    final configuredError = error;
    if (configuredError != null) {
      throw configuredError;
    }
    vibrateOnceCalls += 1;
    this.durationMs = durationMs;
  }

  @override
  Future<void> cancel() async {
    cancelCalls += 1;
    final configuredError = error;
    if (configuredError != null) {
      throw configuredError;
    }
  }
}
