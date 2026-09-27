import 'package:seismicity_pmtiles/src/decoder/seismicity_worker_terminal_probe.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

sealed class const SeismicityWorkerTerminalOutcome<T>();

final class const SeismicityWorkerTerminalSuccessOutcome<T>({
  required final T value,
}) extends SeismicityWorkerTerminalOutcome<T>;

final class const SeismicityWorkerTerminalFailureOutcome<T>({
  required final SeismicityPmTilesException error,
}) extends SeismicityWorkerTerminalOutcome<T>;

final class const SeismicityWorkerTerminalCancelledOutcome<T>()
    extends SeismicityWorkerTerminalOutcome<T>;

sealed class const SeismicityWorkerTerminalSignal<T>();

final class const SeismicityWorkerTerminalSuccessSignal<T>({
  required final T value,
}) extends SeismicityWorkerTerminalSignal<T>;

final class const SeismicityWorkerTerminalFailureSignal<T>({
  required final SeismicityPmTilesException error,
}) extends SeismicityWorkerTerminalSignal<T>;

final class const SeismicityWorkerTerminalCrashSignal<T>({
  required final String message,
}) extends SeismicityWorkerTerminalSignal<T>;

final class const SeismicityWorkerTerminalUnexpectedPortCloseSignal<T>()
    extends SeismicityWorkerTerminalSignal<T>;

final class const SeismicityWorkerTerminalGracefulExitSignal<T>()
    extends SeismicityWorkerTerminalSignal<T>;

final class const SeismicityWorkerTerminalCancelSignal<T>()
    extends SeismicityWorkerTerminalSignal<T>;

final class const SeismicityWorkerTerminalCloseSignal<T>()
    extends SeismicityWorkerTerminalSignal<T>;

final class const SeismicityWorkerTerminalDecision<T>({
  required final SeismicityWorkerTerminalOutcome<T> outcome,
  required final bool completePending,
  required final bool closePort,
  required final bool killIsolate,
  required final bool retire,
  required final bool preserveFailure,
  required final SeismicityWorkerTerminalTransition? probeTransition,
});

final class SeismicityWorkerTerminalCoordinator<T> {
  new({required this.probe});

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
