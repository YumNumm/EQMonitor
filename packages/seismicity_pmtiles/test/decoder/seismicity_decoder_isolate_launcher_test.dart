import 'dart:async';
import 'dart:isolate';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_isolate_launcher.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:test/test.dart';

void main() {
  test('dart launcher forwards typed response and exit once', () async {
    final launcher = DartSeismicityDecoderIsolateLauncher();
    final endpoint = await launcher.launch(workerMain: EchoWorkerIsolate.run);
    addTearDown(() async {
      endpoint.closeReceivePort();
      endpoint.kill();
      await endpoint.exited;
    });

    final events = <String>[];
    final responseFuture = endpoint.responses.first.then((response) {
      events.add('response:${response.requestId}');
      return response;
    });
    final exitFuture = endpoint.exits.first.then((exit) {
      events.add('exit');
      return exit;
    });

    endpoint.send(
      request: const SeismicityDecoderWorkerRequest.finish(requestId: 37),
    );

    expect(
      await responseFuture.timeout(const Duration(seconds: 3)),
      isA<SeismicityDecoderWorkerReadyResponse>().having(
        (response) => response.requestId,
        'requestId',
        37,
      ),
    );
    expect(
      await exitFuture.timeout(const Duration(seconds: 3)),
      isA<SeismicityDecoderWorkerExit>(),
    );
    await endpoint.exited.timeout(const Duration(seconds: 3));
    expect(events, ['response:37', 'exit']);

    endpoint
      ..closeReceivePort()
      ..closeReceivePort()
      ..kill()
      ..kill();
    await endpoint.exited.timeout(const Duration(seconds: 3));
  });
}

// Isolate.spawn needs a static entrypoint, while project rules avoid
// top-level helpers.
// ignore: avoid_classes_with_only_static_members
final class EchoWorkerIsolate {
  static Future<void> run(SendPort initialReplyTo) async {
    final inbox = ReceivePort();
    initialReplyTo.send(inbox.sendPort);
    await for (final request in inbox) {
      switch (request) {
        case SeismicityDecoderWorkerRequest(:final requestId):
          initialReplyTo.send(
            SeismicityDecoderWorkerResponse.ready(requestId: requestId),
          );
          inbox.close();
          Isolate.exit();
      }
    }
  }
}
