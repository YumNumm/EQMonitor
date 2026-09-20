import 'dart:isolate';

import 'package:seismicity_pmtiles/src/decoder/seismicity_dataset_transfer.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_archive_descriptor.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

sealed class const SeismicityDecoderWorkerRequest({
  required final int requestId,
}) {
  const factory initialize({
    required int requestId,
    required SendPort responsePort,
    required SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
    required int chunkCapacity,
  }) = SeismicityDecoderWorkerInitializeRequest;

  const factory decode({
    required int requestId,
    required int tileId,
    required TransferableTypedData tileBytes,
  }) = SeismicityDecoderWorkerDecodeRequest;

  const factory finish({
    required int requestId,
  }) = SeismicityDecoderWorkerFinishRequest;
}

final class const SeismicityDecoderWorkerInitializeRequest({
  required super.requestId,
  required final SendPort responsePort,
  required final SeismicityPmTilesArchiveDescriptor acceptedDescriptor,
  required final int chunkCapacity,
}) extends SeismicityDecoderWorkerRequest;

final class const SeismicityDecoderWorkerDecodeRequest({
  required super.requestId,
  required final int tileId,
  required final TransferableTypedData tileBytes,
}) extends SeismicityDecoderWorkerRequest;

final class const SeismicityDecoderWorkerFinishRequest({
  required super.requestId,
}) extends SeismicityDecoderWorkerRequest;

sealed class const SeismicityDecoderWorkerResponse({
  required final int requestId,
}) {
  const factory ready({
    required int requestId,
  }) = SeismicityDecoderWorkerReadyResponse;

  const factory progress({
    required int requestId,
    required SeismicityPmTilesDecodeProgress progress,
  }) = SeismicityDecoderWorkerProgressResponse;

  const factory finished({
    required int requestId,
    required SeismicityDatasetTransfer datasetTransfer,
  }) = SeismicityDecoderWorkerFinishedResponse;

  const factory failure({
    required int requestId,
    required SeismicityPmTilesException error,
  }) = SeismicityDecoderWorkerFailureResponse;
}

final class const SeismicityDecoderWorkerReadyResponse({
  required super.requestId,
}) extends SeismicityDecoderWorkerResponse;

final class const SeismicityDecoderWorkerProgressResponse({
  required super.requestId,
  required final SeismicityPmTilesDecodeProgress progress,
}) extends SeismicityDecoderWorkerResponse;

final class const SeismicityDecoderWorkerFinishedResponse({
  required super.requestId,
  required final SeismicityDatasetTransfer datasetTransfer,
}) extends SeismicityDecoderWorkerResponse;

final class const SeismicityDecoderWorkerFailureResponse({
  required super.requestId,
  required final SeismicityPmTilesException error,
}) extends SeismicityDecoderWorkerResponse;
