import 'package:seismicity_pmtiles/src/decoder/seismicity_worker_terminal_coordinator.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_worker_terminal_probe.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

final class _RecordingProbe implements SeismicityWorkerTerminalProbe {
  final transitions = <SeismicityWorkerTerminalTransition>[];

  @override
  SeismicityWorkerTerminalCounters get counters => (
    errorCount: transitions
        .where((value) => value == SeismicityWorkerTerminalTransition.error)
        .length,
    exitCount: transitions
        .where((value) => value == SeismicityWorkerTerminalTransition.exit)
        .length,
  );

  @override
  void recordTransition({
    required SeismicityWorkerTerminalTransition transition,
  }) {
    transitions.add(transition);
  }
}

void main() {
  test('terminal coordinator sticky success then late cleanup', () {
    final probe = _RecordingProbe();
    final coordinator = SeismicityWorkerTerminalCoordinator<String>(
      probe: probe,
    );

    final success = coordinator.handle(
      signal: const SeismicityWorkerTerminalSuccessSignal<String>(
        value: 'dataset',
      ),
    );
    expect(success.completePending, isTrue);
    expect(success.closePort, isTrue);
    expect(success.killIsolate, isFalse);
    expect(success.retire, isTrue);
    expect(success.preserveFailure, isFalse);
    expect(success.probeTransition, isNull);
    expect(
      success.outcome,
      isA<SeismicityWorkerTerminalSuccessOutcome<String>>().having(
        (outcome) => outcome.value,
        'value',
        'dataset',
      ),
    );

    final lateExit = coordinator.handle(
      signal: const SeismicityWorkerTerminalGracefulExitSignal<String>(),
    );
    expect(lateExit.completePending, isFalse);
    expect(lateExit.closePort, isFalse);
    expect(lateExit.killIsolate, isFalse);
    expect(lateExit.retire, isFalse);
    expect(lateExit.preserveFailure, isTrue);
    expect(lateExit.probeTransition, SeismicityWorkerTerminalTransition.exit);
    expect(lateExit.outcome, same(success.outcome));
    expect(probe.counters.exitCount, 1);

    final lateCancel = coordinator.handle(
      signal: const SeismicityWorkerTerminalCancelSignal<String>(),
    );
    expect(lateCancel.completePending, isFalse);
    expect(lateCancel.closePort, isFalse);
    expect(lateCancel.killIsolate, isTrue);
    expect(lateCancel.retire, isFalse);
    expect(lateCancel.preserveFailure, isTrue);
    expect(lateCancel.probeTransition, isNull);
    expect(lateCancel.outcome, same(success.outcome));

    final repeated = coordinator.handle(
      signal: const SeismicityWorkerTerminalCloseSignal<String>(),
    );
    expect(repeated.completePending, isFalse);
    expect(repeated.closePort, isFalse);
    expect(repeated.killIsolate, isFalse);
    expect(repeated.retire, isFalse);
    expect(repeated.preserveFailure, isTrue);
    expect(repeated.probeTransition, isNull);
    expect(repeated.outcome, same(success.outcome));
  });

  test('terminal coordinator first-signal matrix', () {
    const finishError = SeismicityPmTilesException.decoderWorkerFailed(
      reason: 'finish_failed',
    );

    final cases =
        <
          ({
            SeismicityWorkerTerminalSignal<int> signal,
            Matcher outcome,
            bool killIsolate,
            SeismicityWorkerTerminalTransition? probeTransition,
          })
        >[
          (
            signal: const SeismicityWorkerTerminalFailureSignal<int>(
              error: finishError,
            ),
            outcome: isA<SeismicityWorkerTerminalFailureOutcome<int>>().having(
              (value) => value.error,
              'error',
              same(finishError),
            ),
            killIsolate: true,
            probeTransition: null,
          ),
          (
            signal: const SeismicityWorkerTerminalCrashSignal<int>(
              message: 'boom',
            ),
            outcome: isA<SeismicityWorkerTerminalFailureOutcome<int>>().having(
              (value) => value.error,
              'error',
              isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
                (error) => error.reason,
                'reason',
                'crash:boom',
              ),
            ),
            killIsolate: true,
            probeTransition: SeismicityWorkerTerminalTransition.error,
          ),
          (
            signal:
                const SeismicityWorkerTerminalUnexpectedPortCloseSignal<int>(),
            outcome: isA<SeismicityWorkerTerminalFailureOutcome<int>>().having(
              (value) => value.error,
              'error',
              isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
                (error) => error.reason,
                'reason',
                'unexpected_port_close',
              ),
            ),
            killIsolate: true,
            probeTransition: null,
          ),
          (
            signal: const SeismicityWorkerTerminalGracefulExitSignal<int>(),
            outcome: isA<SeismicityWorkerTerminalFailureOutcome<int>>().having(
              (value) => value.error,
              'error',
              isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
                (error) => error.reason,
                'reason',
                'graceful_exit_before_terminal',
              ),
            ),
            killIsolate: false,
            probeTransition: SeismicityWorkerTerminalTransition.exit,
          ),
          (
            signal: const SeismicityWorkerTerminalCancelSignal<int>(),
            outcome: isA<SeismicityWorkerTerminalCancelledOutcome<int>>(),
            killIsolate: true,
            probeTransition: null,
          ),
          (
            signal: const SeismicityWorkerTerminalCloseSignal<int>(),
            outcome: isA<SeismicityWorkerTerminalCancelledOutcome<int>>(),
            killIsolate: true,
            probeTransition: null,
          ),
        ];

    for (final testCase in cases) {
      final probe = _RecordingProbe();
      final decision = SeismicityWorkerTerminalCoordinator<int>(
        probe: probe,
      ).handle(signal: testCase.signal);
      expect(decision.completePending, isTrue);
      expect(decision.closePort, isTrue);
      expect(decision.killIsolate, testCase.killIsolate);
      expect(decision.retire, isTrue);
      expect(decision.preserveFailure, isFalse);
      expect(decision.probeTransition, testCase.probeTransition);
      expect(decision.outcome, testCase.outcome);
      expect(
        probe.counters,
        (
          errorCount:
              testCase.probeTransition ==
                  SeismicityWorkerTerminalTransition.error
              ? 1
              : 0,
          exitCount:
              testCase.probeTransition ==
                  SeismicityWorkerTerminalTransition.exit
              ? 1
              : 0,
        ),
      );
    }
  });
}
