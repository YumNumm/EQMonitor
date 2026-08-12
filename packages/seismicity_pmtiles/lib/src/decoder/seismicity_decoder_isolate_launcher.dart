import 'dart:isolate';

import 'package:seismicity_pmtiles/src/decoder/seismicity_decoder_worker_protocol.dart';

typedef SeismicityDecoderWorkerMain = void Function(SendPort initialReplyTo);

abstract interface class SeismicityDecoderIsolateLauncher {
  Future<SeismicityDecoderWorkerEndpoint> launch({
    required SeismicityDecoderWorkerMain workerMain,
  });
}

abstract interface class SeismicityDecoderWorkerEndpoint {
  Stream<SeismicityDecoderWorkerResponse> get responses;
  Stream<SeismicityDecoderWorkerError> get errors;
  Stream<SeismicityDecoderWorkerExit> get exits;
  Future<void> get exited;

  void send({required SeismicityDecoderWorkerRequest request});
  void closeReceivePort();
  void kill();
}

final class SeismicityDecoderWorkerError {
  const SeismicityDecoderWorkerError({required this.message});

  final String message;
}

final class SeismicityDecoderWorkerExit {
  const SeismicityDecoderWorkerExit();
}
