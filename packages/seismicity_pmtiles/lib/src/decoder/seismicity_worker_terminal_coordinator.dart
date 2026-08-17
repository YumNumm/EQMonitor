import 'package:seismicity_pmtiles/src/decoder/seismicity_worker_terminal_probe.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

sealed class SeismicityWorkerTerminalOutcome<T> {
  const SeismicityWorkerTerminalOutcome();
}

final class SeismicityWorkerTerminalSuccessOutcome<T>
    extends SeismicityWorkerTerminalOutcome<T> {
  const SeismicityWorkerTerminalSuccessOutcome({required this.value});

  final T value;
}

final class SeismicityWorkerTerminalFailureOutcome<T>
    extends SeismicityWorkerTerminalOutcome<T> {
  const SeismicityWorkerTerminalFailureOutcome({required this.error});

  final SeismicityPmTilesException error;
}

final class SeismicityWorkerTerminalCancelledOutcome<T>
    extends SeismicityWorkerTerminalOutcome<T> {
  const SeismicityWorkerTerminalCancelledOutcome();
}

sealed class SeismicityWorkerTerminalSignal<T> {
  const SeismicityWorkerTerminalSignal();
}

final class SeismicityWorkerTerminalSuccessSignal<T>
    extends SeismicityWorkerTerminalSignal<T> {
  const SeismicityWorkerTerminalSuccessSignal({required this.value});

  final T value;
}

final class SeismicityWorkerTerminalFailureSignal<T>
    extends SeismicityWorkerTerminalSignal<T> {
  const SeismicityWorkerTerminalFailureSignal({required this.error});

  final SeismicityPmTilesException error;
}

final class SeismicityWorkerTerminalCrashSignal<T>
    extends SeismicityWorkerTerminalSignal<T> {
  const SeismicityWorkerTerminalCrashSignal({required this.message});

  final String message;
}

final class SeismicityWorkerTerminalUnexpectedPortCloseSignal<T>
    extends SeismicityWorkerTerminalSignal<T> {
  const SeismicityWorkerTerminalUnexpectedPortCloseSignal();
}

final class SeismicityWorkerTerminalGracefulExitSignal<T>
    extends SeismicityWorkerTerminalSignal<T> {
  const SeismicityWorkerTerminalGracefulExitSignal();
}

final class SeismicityWorkerTerminalCancelSignal<T>
    extends SeismicityWorkerTerminalSignal<T> {
  const SeismicityWorkerTerminalCancelSignal();
}

final class SeismicityWorkerTerminalCloseSignal<T>
    extends SeismicityWorkerTerminalSignal<T> {
  const SeismicityWorkerTerminalCloseSignal();
}

final class SeismicityWorkerTerminalDecision<T> {
  const SeismicityWorkerTerminalDecision({
    required this.outcome,
    required this.completePending,
    required this.closePort,
    required this.killIsolate,
    required this.retire,
    required this.preserveFailure,
    required this.probeTransition,
  });

  final SeismicityWorkerTerminalOutcome<T> outcome;
  final bool completePending;
  final bool closePort;
  final bool killIsolate;
  final bool retire;
  final bool preserveFailure;
  final SeismicityWorkerTerminalTransition? probeTransition;
}

final class SeismicityWorkerTerminalCoordinator<T> {
  SeismicityWorkerTerminalCoordinator({required this.probe});

  final SeismicityWorkerTerminalProbe probe;
  SeismicityWorkerTerminalOutcome<T>? _outcome;
  var _closedPort = false;
  var _killed = false;
  var _retired = false;

  SeismicityWorkerTerminalDecision<T> handle({
    required SeismicityWorkerTerminalSignal<T> signal,
  }) {
    final prior = _outcome;
    final firstTerminal = prior == null;
    final nextOutcome = switch ((prior, signal)) {
      (final existing?, _) => existing,
      (null, SeismicityWorkerTerminalSuccessSignal<T>(:final value)) =>
        SeismicityWorkerTerminalSuccessOutcome<T>(value: value),
      (null, SeismicityWorkerTerminalFailureSignal<T>(:final error)) =>
        SeismicityWorkerTerminalFailureOutcome<T>(error: error),
      (null, SeismicityWorkerTerminalCrashSignal<T>(:final message)) =>
        SeismicityWorkerTerminalFailureOutcome<T>(
          error: SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'crash:$message',
          ),
        ),
      (null, SeismicityWorkerTerminalUnexpectedPortCloseSignal<T>()) =>
        SeismicityWorkerTerminalFailureOutcome<T>(
          error: const SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'unexpected_port_close',
          ),
        ),
      (null, SeismicityWorkerTerminalGracefulExitSignal<T>()) =>
        SeismicityWorkerTerminalFailureOutcome<T>(
          error: const SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'graceful_exit_before_terminal',
          ),
        ),
      (
        null,
        SeismicityWorkerTerminalCancelSignal<T>() ||
            SeismicityWorkerTerminalCloseSignal<T>(),
      ) =>
        SeismicityWorkerTerminalCancelledOutcome<T>(),
    };
    _outcome = nextOutcome;

    final closePort = !_closedPort;
    _closedPort = true;

    final requiresKill = switch (signal) {
      SeismicityWorkerTerminalGracefulExitSignal<T>() => false,
      SeismicityWorkerTerminalSuccessSignal<T>() => false,
      _ => true,
    };
    final killIsolate = requiresKill && !_killed;
    if (killIsolate) {
      _killed = true;
    }

    final retire = !_retired;
    _retired = true;

    final probeTransition = switch (signal) {
      SeismicityWorkerTerminalCrashSignal<T>() =>
        SeismicityWorkerTerminalTransition.error,
      SeismicityWorkerTerminalGracefulExitSignal<T>() =>
        SeismicityWorkerTerminalTransition.exit,
      _ => null,
    };
    if (probeTransition != null) {
      probe.recordTransition(transition: probeTransition);
    }

    return SeismicityWorkerTerminalDecision<T>(
      outcome: nextOutcome,
      completePending: firstTerminal,
      closePort: closePort,
      killIsolate: killIsolate,
      retire: retire,
      preserveFailure: !firstTerminal,
      probeTransition: probeTransition,
    );
  }
}
