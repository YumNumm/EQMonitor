import 'dart:async';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_decode_progress.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';

final class SeismicityDecoderWorkerPendingDecode {
  SeismicityDecoderWorkerPendingDecode({
    required this.requestId,
    required this.completion,
  });

  final int requestId;
  final Future<SeismicityPmTilesDecodeProgress> completion;
}

final class SeismicityDecoderWorkerRouter {
  final _pending = <int, Completer<SeismicityPmTilesDecodeProgress>>{};
  final forwardedProgress = <SeismicityPmTilesDecodeProgress>[];
  var _nextRequestId = 0;
  int? _initializeRequestId;
  var _ready = false;
  var _terminal = false;
  SeismicityPmTilesDecodeProgress? _lastProgress;

  int registerInitialize() {
    if (_terminal) {
      throw const SeismicityPmTilesException.decoderWorkerFailed(
        reason: 'registration_after_terminal',
      );
    }
    if (_initializeRequestId != null) {
      throw const SeismicityPmTilesException.decoderWorkerFailed(
        reason: 'unknown_or_duplicate_request_id',
      );
    }
    final requestId = _nextRequestId;
    _nextRequestId += 1;
    _initializeRequestId = requestId;
    return requestId;
  }

  SeismicityDecoderWorkerPendingDecode registerDecode() {
    if (_terminal) {
      throw const SeismicityPmTilesException.decoderWorkerFailed(
        reason: 'registration_after_terminal',
      );
    }
    final requestId = _nextRequestId;
    _nextRequestId += 1;
    final completer = Completer<SeismicityPmTilesDecodeProgress>();
    _pending[requestId] = completer;
    return SeismicityDecoderWorkerPendingDecode(
      requestId: requestId,
      completion: completer.future,
    );
  }

  void markTerminal() {
    _terminal = true;
  }

  int allocateRequestId() {
    if (_terminal) {
      throw const SeismicityPmTilesException.decoderWorkerFailed(
        reason: 'registration_after_terminal',
      );
    }
    final requestId = _nextRequestId;
    _nextRequestId += 1;
    return requestId;
  }

  void handleResponse({required SeismicityDecoderWorkerResponse response}) {
    switch (response) {
      case SeismicityDecoderWorkerReadyResponse(:final requestId):
        final expected = _initializeRequestId;
        if (_ready || expected == null || requestId != expected) {
          throw const SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'unknown_or_duplicate_request_id',
          );
        }
        _ready = true;
      case SeismicityDecoderWorkerProgressResponse(
        :final requestId,
        :final progress,
      ):
        if (!_ready) {
          throw const SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'acknowledgement_before_ready',
          );
        }
        final pending = _pending.remove(requestId);
        if (pending == null) {
          throw const SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'unknown_or_duplicate_request_id',
          );
        }
        final previous = _lastProgress;
        if (previous != null &&
            (progress.decodedTileCount < previous.decodedTileCount ||
                progress.rawFeatureCount < previous.rawFeatureCount ||
                progress.uniqueFeatureCount < previous.uniqueFeatureCount)) {
          throw const SeismicityPmTilesException.decoderWorkerFailed(
            reason: 'progress_regression',
          );
        }
        _lastProgress = progress;
        forwardedProgress.add(progress);
        pending.complete(progress);
      case SeismicityDecoderWorkerFinishedResponse():
      case SeismicityDecoderWorkerFailureResponse():
        throw const SeismicityPmTilesException.decoderWorkerFailed(
          reason: 'unexpected_terminal_response',
        );
    }
  }
}
