import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

import 'controlled_seismicity_decoder_worker_handle.dart';

void main() {
  test(
    'controls handle schedules and terminal futures deterministically',
    () async {
      const progress = SeismicityPmTilesDecodeProgress(
        decodedTileCount: 1,
        rawFeatureCount: 2,
        uniqueFeatureCount: 1,
      );
      const dataset = SeismicityPmTilesDataset(
        archiveRevision: 'revision-33',
        schemaVersion: 1,
        dataZoom: 14,
        featureCount: 0,
        chunks: [],
      );
      final handle = ControlledSeismicityDecoderWorkerHandle(
        captureTileBytes: true,
      );
      final firstTileBytes = TransferableTypedData.fromList([
        Uint8List.fromList([1]),
      ]);
      final secondTileBytes = TransferableTypedData.fromList([
        Uint8List.fromList([2]),
      ]);
      final decode = handle.decode(tileId: 0, tileBytes: firstTileBytes);
      unawaited(handle.decode(tileId: 0, tileBytes: secondTileBytes));
      final finish = handle.finish();
      await Future<void>.delayed(Duration.zero);

      expect(handle.decodeCount, 2);
      expect(handle.capturedTileBytes, [
        [1],
        [2],
      ]);
      expect(handle.finishCount, 1);

      handle.succeedDecode(progress: progress);
      handle.succeedFinish(dataset: dataset);

      expect(await decode, same(progress));
      expect(await finish, same(dataset));
      const failure = SeismicityPmTilesException.decoderWorkerFailed(
        reason: 'sticky failure',
      );
      final failingDecode = ControlledSeismicityDecoderWorkerHandle();
      failingDecode.failDecode(error: failure);
      final thirdTileBytes = TransferableTypedData.fromList([
        Uint8List.fromList([3]),
      ]);
      await expectLater(
        failingDecode.decode(tileId: 0, tileBytes: thirdTileBytes),
        throwsA(same(failure)),
      );
      expect(failingDecode.capturedTileBytes, isEmpty);

      final failingFinish = ControlledSeismicityDecoderWorkerHandle();
      failingFinish.failFinish(error: failure);
      await expectLater(failingFinish.finish(), throwsA(same(failure)));

      final cancelA = handle.cancel();
      final cancelB = handle.cancel();
      final closeA = handle.close();
      final closeB = handle.close();
      expect(cancelA, same(cancelB));
      expect(closeA, same(closeB));
      expect(handle.cancelCount, 2);
      expect(handle.closeCount, 2);

      handle.succeedCancel();
      handle.succeedClose();
      handle.succeedRetired();

      await Future.wait([cancelA, cancelB, closeA, closeB, handle.retired]);
    },
  );
}
