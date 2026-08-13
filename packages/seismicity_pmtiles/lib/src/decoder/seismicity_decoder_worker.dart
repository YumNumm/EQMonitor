import 'dart:async';
import 'dart:isolate';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_isolate_launcher.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_entry.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_factory.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_finisher.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_router.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_worker_terminal_coordinator.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_worker_terminal_probe.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityWorkerNoOpTerminalProbe
    implements SeismicityWorkerTerminalProbe {
  const SeismicityWorkerNoOpTerminalProbe();

  @override
  SeismicityWorkerTerminalCounters get counters => (
    errorCount: 0,
    exitCount: 0,
  );

  @override
  void recordTransition({
    required SeismicityWorkerTerminalTransition transition,
  }) {}
}

final class IsolateSeismicityDecoderWorkerFactory
    implements SeismicityDecoderWorkerFactory {
  IsolateSeismicityDecoderWorkerFactory({
    SeismicityDecoderIsolateLauncher? launcher,
    SeismicityWorkerTerminalProbe? probe,
    this.workerMain = seismicityDecoderWorkerEntry,
    this.finisher = const SeismicityDecoderWorkerFinisher(),
  }) : launcher = launcher ?? DartSeismicityDecoderIsolateLauncher(),
       probe = probe ?? const SeismicityWorkerNoOpTerminalProbe();

  final SeismicityDecoderIsolateLauncher launcher;
  final SeismicityWorkerTerminalProbe probe;
  final SeismicityDecoderWorkerMain workerMain;
  final SeismicityDecoderWorkerFinisher finisher;

  @override
  Future<SeismicityDecoderWorkerHandle> spawn({
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
    required int chunkCapacity,
  }) async {
    final endpoint = await launcher.launch(workerMain: workerMain);
    final handle = IsolateSeismicityDecoderWorkerHandle(
      endpoint: endpoint,
      acceptedDescriptor: acceptedDescriptor,
      probe: probe,
      finisher: finisher,
    );
    await handle.bootstrap(chunkCapacity: chunkCapacity);
    return handle;
  }
}

final class IsolateSeismicityDecoderWorkerHandle
    implements SeismicityDecoderWorkerHandle {
  IsolateSeismicityDecoderWorkerHandle({
    required this.endpoint,
    required this.acceptedDescriptor,
    required SeismicityWorkerTerminalProbe probe,
    required this.finisher,
  }) : router = SeismicityDecoderWorkerRouter(),
       coordinator =
           SeismicityWorkerTerminalCoordinator<SeismicityPmTilesDataset>(
             probe: probe,
           );

  final SeismicityDecoderWorkerEndpoint endpoint;
  final SeismicityPmTilesArchiveDescriptor acceptedDescriptor;
  final SeismicityDecoderWorkerFinisher finisher;
  final SeismicityDecoderWorkerRouter router;
  final SeismicityWorkerTerminalCoordinator<SeismicityPmTilesDataset>
  coordinator;
  final _ready = Completer<void>();
  final _finish = Completer<SeismicityPmTilesDataset>();
  final _retired = Completer<void>();
  final _subscriptions = <StreamSubscription<void>>[];
  final _initializeReplyPort = ReceivePort();
  var _bootstrapped = false;
  var _cancelStarted = false;
  var _closeStarted = false;
  var _finishRequested = false;
  var _terminalApplied = false;
  var _retireScheduled = false;

  Future<void> bootstrap({required int chunkCapacity}) async {
    if (_bootstrapped) {
      return;
    }
    _bootstrapped = true;
    _subscriptions.add(
      endpoint.responses.listen(
        (response) {
          switch (response) {
            case SeismicityDecoderWorkerReadyResponse():
            case SeismicityDecoderWorkerProgressResponse():
              try {
                router.handleResponse(response: response);
                if (response is SeismicityDecoderWorkerReadyResponse &&
                    !_ready.isCompleted) {
                  _ready.complete();
                }
              } on SeismicityPmTilesException catch (error) {
                failFinish(error: error);
              }
            case SeismicityDecoderWorkerFinishedResponse(
              :final datasetTransfer,
            ):
              try {
                final dataset = finisher.materialize(
                  transfer: datasetTransfer,
                  acceptedDescriptor: acceptedDescriptor,
                );
                if (!_finish.isCompleted) {
                  _finish.complete(dataset);
                }
                applyTerminalDecision(
                  decision: coordinator.handle(
                    signal: SeismicityWorkerTerminalSuccessSignal(
                      value: dataset,
                    ),
                  ),
                );
              } on SeismicityPmTilesException catch (error) {
                failFinish(error: error);
              }
            case SeismicityDecoderWorkerFailureResponse(:final error):
              failFinish(error: error);
          }
        },
        onDone: () {
          if (_terminalApplied) {
            return;
          }
          applyTerminalDecision(
            decision: coordinator.handle(
              signal: const SeismicityWorkerTerminalUnexpectedPortCloseSignal(),
            ),
          );
        },
      ),
    );
    _subscriptions.add(
      endpoint.errors.listen((error) {
        applyTerminalDecision(
          decision: coordinator.handle(
            signal: SeismicityWorkerTerminalCrashSignal(
              message: error.message,
            ),
          ),
        );
      }),
    );
    _subscriptions.add(
      endpoint.exits.listen((_) {
        applyTerminalDecision(
          decision: coordinator.handle(
            signal: const SeismicityWorkerTerminalGracefulExitSignal(),
          ),
        );
      }),
    );

    final initializeRequestId = router.registerInitialize();
    endpoint.send(
      request: SeismicityDecoderWorkerRequest.initialize(
        requestId: initializeRequestId,
        responsePort: _initializeReplyPort.sendPort,
        acceptedDescriptor: acceptedDescriptor,
        chunkCapacity: chunkCapacity,
      ),
    );
    await _ready.future;
  }

  void failFinish({required SeismicityPmTilesException error}) {
    if (_finishRequested && !_finish.isCompleted) {
      _finish.completeError(error);
    }
    applyTerminalDecision(
      decision: coordinator.handle(
        signal: SeismicityWorkerTerminalFailureSignal(error: error),
      ),
    );
  }

  void applyTerminalDecision({
    required SeismicityWorkerTerminalDecision<SeismicityPmTilesDataset>
    decision,
  }) {
    _terminalApplied = true;
    router.markTerminal();
    if (decision.completePending) {
      final error = switch (decision.outcome) {
        SeismicityWorkerTerminalFailureOutcome<SeismicityPmTilesDataset>(
          :final error,
        ) =>
          error,
        SeismicityWorkerTerminalCancelledOutcome<SeismicityPmTilesDataset>() =>
          const SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'cancelled',
          ),
        SeismicityWorkerTerminalSuccessOutcome<SeismicityPmTilesDataset>() =>
          null,
      };
      if (error != null) {
        if (!_ready.isCompleted) {
          _ready.completeError(error);
        }
        router.failPending(error: error);
        if (_finishRequested && !_finish.isCompleted) {
          _finish.completeError(error);
        }
      }
    }
    if (decision.closePort) {
      endpoint.closeReceivePort();
      _initializeReplyPort.close();
    }
    if (decision.killIsolate) {
      endpoint.kill();
    }
    if (decision.retire) {
      scheduleRetirement(awaitExited: decision.killIsolate);
    }
  }

  void scheduleRetirement({required bool awaitExited}) {
    if (_retireScheduled) {
      return;
    }
    _retireScheduled = true;
    if (!awaitExited) {
      if (!_retired.isCompleted) {
        _retired.complete();
      }
      return;
    }
    unawaited(
      endpoint.exited.then((_) {
        if (!_retired.isCompleted) {
          _retired.complete();
        }
      }),
    );
  }

  @override
  Future<SeismicityPmTilesDecodeProgress> decode({
    required TransferableTypedData tileBytes,
  }) {
    final pending = router.registerDecode();
    endpoint.send(
      request: SeismicityDecoderWorkerRequest.decode(
        requestId: pending.requestId,
        tileBytes: tileBytes,
      ),
    );
    return pending.completion;
  }

  @override
  Future<SeismicityPmTilesDataset> finish() {
    _finishRequested = true;
    final requestId = router.allocateRequestId();
    endpoint.send(
      request: SeismicityDecoderWorkerRequest.finish(requestId: requestId),
    );
    return _finish.future;
  }

  @override
  Future<void> cancel() {
    if (!_cancelStarted) {
      _cancelStarted = true;
      applyTerminalDecision(
        decision: coordinator.handle(
          signal: const SeismicityWorkerTerminalCancelSignal(),
        ),
      );
    }
    return retired;
  }

  @override
  Future<void> close() {
    if (!_closeStarted) {
      _closeStarted = true;
      applyTerminalDecision(
        decision: coordinator.handle(
          signal: const SeismicityWorkerTerminalCloseSignal(),
        ),
      );
    }
    return retired;
  }

  @override
  Future<void> get retired => _retired.future;
}
