import 'dart:async';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_isolate_launcher.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_worker_terminal_probe.dart';
import 'package:test/test.dart';

void main() {
  test('launcher endpoint and terminal probe expose typed seams', () async {
    final seam = RecordingWorkerSeam();
    final endpoint = await seam.launch(workerMain: (_) {});

    endpoint.send(
      request: const SeismicityDecoderWorkerRequest.finish(requestId: 7),
    );

    expect(seam.sent.single.requestId, 7);
    expect((await endpoint.responses.first).requestId, 7);
    expect((await endpoint.errors.first).message, 'boom');
    expect(await endpoint.exits.first, isA<SeismicityDecoderWorkerExit>());

    endpoint
      ..closeReceivePort()
      ..kill();
    await endpoint.exited;
    seam
      ..recordTransition(transition: .error)
      ..recordTransition(transition: .exit)
      ..recordTransition(transition: .exit);

    expect(seam.receivePortClosed, isTrue);
    expect(seam.counters, (errorCount: 1, exitCount: 2));
  });
}

final class RecordingWorkerSeam
    implements
        SeismicityDecoderIsolateLauncher,
        SeismicityDecoderWorkerEndpoint,
        SeismicityWorkerTerminalProbe {
  final sent = <SeismicityDecoderWorkerRequest>[];
  final exitCompleter = Completer<void>();
  @override
  var counters = (errorCount: 0, exitCount: 0);
  var receivePortClosed = false;

  @override
  Future<SeismicityDecoderWorkerEndpoint> launch({
    required SeismicityDecoderWorkerMain workerMain,
  }) async => this;

  @override
  Stream<SeismicityDecoderWorkerResponse> get responses =>
      Stream.value(const SeismicityDecoderWorkerResponse.ready(requestId: 7));
  @override
  Stream<SeismicityDecoderWorkerError> get errors =>
      Stream.value(const SeismicityDecoderWorkerError(message: 'boom'));
  @override
  Stream<SeismicityDecoderWorkerExit> get exits =>
      Stream.value(const SeismicityDecoderWorkerExit());
  @override
  Future<void> get exited => exitCompleter.future;

  @override
  void send({required SeismicityDecoderWorkerRequest request}) =>
      sent.add(request);
  @override
  void closeReceivePort() => receivePortClosed = true;
  @override
  void kill() => exitCompleter.complete();

  @override
  void recordTransition({
    required SeismicityWorkerTerminalTransition transition,
  }) => counters = switch (transition) {
    .error => (
      errorCount: counters.errorCount + 1,
      exitCount: counters.exitCount,
    ),
    .exit => (
      errorCount: counters.errorCount,
      exitCount: counters.exitCount + 1,
    ),
  };
}
