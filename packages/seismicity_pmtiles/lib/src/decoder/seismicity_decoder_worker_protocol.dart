import 'dart:isolate';

import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

sealed class SeismicityDecoderWorkerRequest {
  const SeismicityDecoderWorkerRequest({required this.requestId});

  const factory SeismicityDecoderWorkerRequest.initialize({
    required int requestId,
    required SendPort responsePort,
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
    required int chunkCapacity,
  }) = SeismicityDecoderWorkerInitializeRequest;

  const factory SeismicityDecoderWorkerRequest.decode({
    required int requestId,
    required int tileId,
    required TransferableTypedData tileBytes,
  }) = SeismicityDecoderWorkerDecodeRequest;

  const factory SeismicityDecoderWorkerRequest.finish({
    required int requestId,
  }) = SeismicityDecoderWorkerFinishRequest;

  final int requestId;
}

final class SeismicityDecoderWorkerInitializeRequest
    extends SeismicityDecoderWorkerRequest {
  const SeismicityDecoderWorkerInitializeRequest({
    required super.requestId,
    required this.responsePort,
    required this.acceptedDescriptor,
    required this.chunkCapacity,
  });

  final SendPort responsePort;
  final SeismicityPmTilesArchiveDescriptor acceptedDescriptor;
  final int chunkCapacity;
}

final class SeismicityDecoderWorkerDecodeRequest
    extends SeismicityDecoderWorkerRequest {
  const SeismicityDecoderWorkerDecodeRequest({
    required super.requestId,
    required this.tileId,
    required this.tileBytes,
  });

  final int tileId;
  final TransferableTypedData tileBytes;
}

final class SeismicityDecoderWorkerFinishRequest
    extends SeismicityDecoderWorkerRequest {
  const SeismicityDecoderWorkerFinishRequest({required super.requestId});
}

sealed class SeismicityDecoderWorkerResponse {
  const SeismicityDecoderWorkerResponse({required this.requestId});

  const factory SeismicityDecoderWorkerResponse.ready({
    required int requestId,
  }) = SeismicityDecoderWorkerReadyResponse;

  const factory SeismicityDecoderWorkerResponse.progress({
    required int requestId,
    required SeismicityPmTilesDecodeProgress progress,
  }) = SeismicityDecoderWorkerProgressResponse;

  const factory SeismicityDecoderWorkerResponse.finished({
    required int requestId,
    required SeismicityDatasetTransfer datasetTransfer,
  }) = SeismicityDecoderWorkerFinishedResponse;

  const factory SeismicityDecoderWorkerResponse.failure({
    required int requestId,
    required SeismicityPmTilesException error,
  }) = SeismicityDecoderWorkerFailureResponse;

  final int requestId;
}

final class SeismicityDecoderWorkerReadyResponse
    extends SeismicityDecoderWorkerResponse {
  const SeismicityDecoderWorkerReadyResponse({required super.requestId});
}

final class SeismicityDecoderWorkerProgressResponse
    extends SeismicityDecoderWorkerResponse {
  const SeismicityDecoderWorkerProgressResponse({
    required super.requestId,
    required this.progress,
  });

  final SeismicityPmTilesDecodeProgress progress;
}

final class SeismicityDecoderWorkerFinishedResponse
    extends SeismicityDecoderWorkerResponse {
  const SeismicityDecoderWorkerFinishedResponse({
    required super.requestId,
    required this.datasetTransfer,
  });

  final SeismicityDatasetTransfer datasetTransfer;
}

final class SeismicityDecoderWorkerFailureResponse
    extends SeismicityDecoderWorkerResponse {
  const SeismicityDecoderWorkerFailureResponse({
    required super.requestId,
    required this.error,
  });

  final SeismicityPmTilesException error;
}
