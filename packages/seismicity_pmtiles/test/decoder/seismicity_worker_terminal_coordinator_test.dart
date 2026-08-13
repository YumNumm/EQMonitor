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
  test('terminal coordinator covers sticky first-result transition table', () {
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
    expect(lateCancel.outcome, same(success.outcome));

    final repeated = coordinator.handle(
      signal: const SeismicityWorkerTerminalCloseSignal<String>(),
    );
    expect(repeated.completePending, isFalse);
    expect(repeated.closePort, isFalse);
    expect(repeated.killIsolate, isFalse);
    expect(repeated.retire, isFalse);
    expect(repeated.preserveFailure, isTrue);
    expect(repeated.outcome, same(success.outcome));
  });

  test('terminal coordinator decides crash port-close cancel and failures', () {
    final probe = _RecordingProbe();
    final coordinator = SeismicityWorkerTerminalCoordinator<int>(probe: probe);

    final beforeReady = coordinator.handle(
      signal: const SeismicityWorkerTerminalGracefulExitSignal<int>(),
    );
    expect(beforeReady.completePending, isTrue);
    expect(beforeReady.closePort, isTrue);
    expect(beforeReady.killIsolate, isFalse);
    expect(beforeReady.retire, isTrue);
    expect(
      beforeReady.outcome,
      isA<SeismicityWorkerTerminalFailureOutcome<int>>().having(
        (outcome) => outcome.error,
        'error',
        isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
          (error) => error.reason,
          'reason',
          'graceful_exit_before_terminal',
        ),
      ),
    );
    expect(probe.counters.exitCount, 1);

    final sticky = SeismicityWorkerTerminalCoordinator<int>(
      probe: _RecordingProbe(),
    );
    final crash = sticky.handle(
      signal: const SeismicityWorkerTerminalCrashSignal<int>(message: 'boom'),
    );
    expect(crash.killIsolate, isTrue);
    expect(crash.closePort, isTrue);
    expect(crash.probeTransition, SeismicityWorkerTerminalTransition.error);
    expect(
      crash.outcome,
      isA<SeismicityWorkerTerminalFailureOutcome<int>>().having(
        (outcome) => outcome.error,
        'error',
        isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
          (error) => error.reason,
          'reason',
          'crash:boom',
        ),
      ),
    );

    final portClose =
        SeismicityWorkerTerminalCoordinator<int>(
          probe: _RecordingProbe(),
        ).handle(
          signal:
              const SeismicityWorkerTerminalUnexpectedPortCloseSignal<int>(),
        );
    expect(portClose.killIsolate, isTrue);
    expect(portClose.closePort, isTrue);
    expect(
      portClose.outcome,
      isA<SeismicityWorkerTerminalFailureOutcome<int>>().having(
        (outcome) => outcome.error,
        'error',
        isA<SeismicityPmTilesDecoderWorkerFailedException>().having(
          (error) => error.reason,
          'reason',
          'unexpected_port_close',
        ),
      ),
    );

    final failure =
        SeismicityWorkerTerminalCoordinator<int>(
          probe: _RecordingProbe(),
        ).handle(
          signal: const SeismicityWorkerTerminalFailureSignal<int>(
            error: SeismicityPmTilesException.decoderWorkerFailed(
              reason: 'finish_failed',
            ),
          ),
        );
    expect(failure.killIsolate, isTrue);
    expect(failure.completePending, isTrue);

    final cancel = SeismicityWorkerTerminalCoordinator<int>(
      probe: _RecordingProbe(),
    ).handle(signal: const SeismicityWorkerTerminalCancelSignal<int>());
    expect(cancel.killIsolate, isTrue);
    expect(cancel.closePort, isTrue);
    expect(
      cancel.outcome,
      isA<SeismicityWorkerTerminalCancelledOutcome<int>>(),
    );

    final close = SeismicityWorkerTerminalCoordinator<int>(
      probe: _RecordingProbe(),
    ).handle(signal: const SeismicityWorkerTerminalCloseSignal<int>());
    expect(close.killIsolate, isTrue);
    expect(close.outcome, isA<SeismicityWorkerTerminalCancelledOutcome<int>>());
  });
}
