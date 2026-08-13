import 'dart:async';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_isolate_launcher.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_worker_terminal_probe.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class ControlledSeismicityIsolateLauncher
    implements
        SeismicityDecoderIsolateLauncher,
        SeismicityDecoderWorkerEndpoint,
        SeismicityWorkerTerminalProbe {
  final _responses =
      StreamController<SeismicityDecoderWorkerResponse>.broadcast();
  final _errors = StreamController<SeismicityDecoderWorkerError>.broadcast();
  final _exits = StreamController<SeismicityDecoderWorkerExit>.broadcast();
  final _exited = Completer<void>();
  final sent = <SeismicityDecoderWorkerRequest>[];
  final events = <String>[];

  SeismicityWorkerTerminalCounters _counters = (errorCount: 0, exitCount: 0);
  var _launchCount = 0;
  var _closeReceivePortCount = 0;
  var _killCount = 0;
  var deferExitedUntilReleased = false;

  int get launchCount => _launchCount;
  int get closeReceivePortCount => _closeReceivePortCount;
  int get killCount => _killCount;
  bool get exitedIsCompleted => _exited.isCompleted;

  @override
  SeismicityWorkerTerminalCounters get counters => _counters;

  @override
  Stream<SeismicityDecoderWorkerResponse> get responses => _responses.stream;

  @override
  Stream<SeismicityDecoderWorkerError> get errors => _errors.stream;

  @override
  Stream<SeismicityDecoderWorkerExit> get exits => _exits.stream;

  @override
  Future<void> get exited => _exited.future;

  @override
  Future<SeismicityDecoderWorkerEndpoint> launch({
    required SeismicityDecoderWorkerMain workerMain,
  }) async {
    _launchCount++;
    events.add('launch');
    return this;
  }

  @override
  void send({required SeismicityDecoderWorkerRequest request}) {
    sent.add(request);
    events.add('send:${request.requestId}');
  }

  @override
  void closeReceivePort() {
    _closeReceivePortCount++;
    events.add('closeReceivePort');
  }

  @override
  void kill() {
    _killCount++;
    events.add('kill');
    if (!deferExitedUntilReleased && !_exited.isCompleted) {
      _exited.complete();
    }
  }

  void releaseExited() {
    if (!_exited.isCompleted) {
      _exited.complete();
    }
  }

  @override
  void recordTransition({
    required SeismicityWorkerTerminalTransition transition,
  }) {
    _counters = switch (transition) {
      .error => (
        errorCount: _counters.errorCount + 1,
        exitCount: _counters.exitCount,
      ),
      .exit => (
        errorCount: _counters.errorCount,
        exitCount: _counters.exitCount + 1,
      ),
    };
  }

  void emitResponse({required SeismicityDecoderWorkerResponse response}) {
    events.add('response:${response.requestId}');
    _responses.add(response);
  }

  void emitReady({required int requestId}) {
    emitResponse(
      response: SeismicityDecoderWorkerResponse.ready(requestId: requestId),
    );
  }

  void emitFailure({
    required int requestId,
    required SeismicityPmTilesException error,
  }) {
    emitResponse(
      response: SeismicityDecoderWorkerResponse.failure(
        requestId: requestId,
        error: error,
      ),
    );
  }

  void emitInvalidTransfer({
    required int requestId,
    required SeismicityPmTilesChunk invalidChunk,
  }) {
    emitResponse(
      response: SeismicityDecoderWorkerResponse.finished(
        requestId: requestId,
        datasetTransfer: SeismicityDatasetTransfer(
          archiveRevision: 'invalid-transfer',
          schemaVersion: 1,
          dataZoom: 0,
          featureCount: 1,
          chunks: [
            SeismicityChunkTransfer.fromChunk(chunk: invalidChunk),
          ],
        ),
      ),
    );
  }

  void crash({required String message}) {
    events.add('error:$message');
    recordTransition(transition: .error);
    _errors.add(SeismicityDecoderWorkerError(message: message));
  }

  void exit() {
    events.add('exit');
    recordTransition(transition: .exit);
    _exits.add(const SeismicityDecoderWorkerExit());
    if (!_exited.isCompleted) {
      _exited.complete();
    }
  }

  Future<void> closePorts() async {
    events.add('portsClosed');
    await Future.wait<void>([
      _responses.close(),
      _errors.close(),
      _exits.close(),
    ]);
  }
}
