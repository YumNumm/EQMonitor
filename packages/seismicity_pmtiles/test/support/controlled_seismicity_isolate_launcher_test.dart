import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_isolate_launcher.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_chunk.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

import 'controlled_seismicity_isolate_launcher.dart';

void main() {
  test(
    'controls isolate endpoint events and records terminal handling',
    () async {
      final launcher = ControlledSeismicityIsolateLauncher();
      final endpoint = await launcher.launch(workerMain: (_) {});

      endpoint.send(
        request: const SeismicityDecoderWorkerRequest.finish(requestId: 3),
      );
      expect(launcher.launchCount, 1);
      expect(launcher.sent.single.requestId, 3);

      final progressResponse = endpoint.responses.first;
      launcher.emitResponse(
        response: const SeismicityDecoderWorkerResponse.progress(
          requestId: 4,
          progress: SeismicityPmTilesDecodeProgress(
            decodedTileCount: 1,
            rawFeatureCount: 2,
            uniqueFeatureCount: 1,
          ),
        ),
      );
      expect(
        await progressResponse,
        isA<SeismicityDecoderWorkerProgressResponse>().having(
          (response) => response.requestId,
          'requestId',
          4,
        ),
      );

      final invalidTransferResponse = endpoint.responses.first;
      launcher.emitInvalidTransfer(
        requestId: 5,
        invalidChunk: SeismicityPmTilesChunk(
          hypocenterIds: Uint8List.fromList(List.filled(16, 1)),
          latitudes: Float64List.fromList([35]),
          longitudes: Float64List.fromList([139, 140]),
          depthsKm: Float32List.fromList([10]),
          depthValidity: Uint8List.fromList([1]),
          magnitudes: Float32List.fromList([4.5]),
          magnitudeValidity: Uint8List.fromList([1]),
          originTimeUnixMilliseconds: Int64List.fromList([1]),
          maxIntensityDictionaryIndexes: Uint32List.fromList([0]),
          maxIntensityValidity: Uint8List.fromList([1]),
          maxIntensityDictionaryUtf8: Uint8List(0),
          maxIntensityDictionaryOffsets: Uint32List.fromList([0]),
        ),
      );
      final invalidResponse = await invalidTransferResponse;
      final roundTripped = await Isolate.run(() => invalidResponse);
      expect(
        roundTripped,
        isA<SeismicityDecoderWorkerFinishedResponse>()
            .having((response) => response.requestId, 'requestId', 5)
            .having(
              (response) => response.datasetTransfer.chunks.single.materialize,
              'materialize',
              throwsA(isA<SeismicityPmTilesCorruptArchiveException>()),
            ),
      );

      final crash = endpoint.errors.first;
      launcher.crash(message: 'boom');
      expect((await crash).message, 'boom');

      final exit = endpoint.exits.first;
      launcher.exit();
      expect(await exit, isA<SeismicityDecoderWorkerExit>());
      await endpoint.exited;
      expect(launcher.counters, (errorCount: 1, exitCount: 1));

      endpoint
        ..closeReceivePort()
        ..kill();
      expect(launcher.closeReceivePortCount, 1);
      expect(launcher.killCount, 1);

      final responsesClosed = endpoint.responses.drain<void>();
      final errorsClosed = endpoint.errors.drain<void>();
      final exitsClosed = endpoint.exits.drain<void>();
      final portsClosed = launcher.closePorts();
      await Future.wait<void>([
        responsesClosed,
        errorsClosed,
        exitsClosed,
        portsClosed,
      ]);
      expect(launcher.events, [
        'launch',
        'send:3',
        'response:4',
        'response:5',
        'error:boom',
        'exit',
        'closeReceivePort',
        'kill',
        'portsClosed',
      ]);
    },
  );
}
