import 'dart:isolate';

import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_dataset.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';

abstract interface class SeismicityDecoderWorkerFactory {
  Future<SeismicityDecoderWorkerHandle> spawn({
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
    required int chunkCapacity,
  });
}

abstract interface class SeismicityDecoderWorkerHandle {
  Future<SeismicityPmTilesDecodeProgress> decode({
    required int tileId,
    required TransferableTypedData tileBytes,
  });
  Future<SeismicityPmTilesDataset> finish();
  Future<void> cancel();
  Future<void> close();
  Future<void> get retired;
}
