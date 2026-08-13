import 'dart:async';
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

final class DartSeismicityDecoderIsolateLauncher
    implements SeismicityDecoderIsolateLauncher {
  @override
  Future<SeismicityDecoderWorkerEndpoint> launch({
    required SeismicityDecoderWorkerMain workerMain,
  }) async {
    final responsePort = ReceivePort();
    final errorPort = ReceivePort();
    final exitPort = ReceivePort();
    final workerPort = Completer<SendPort?>();
    final exited = Completer<void>();
    // ignore: close_sinks - the endpoint owns this controller after launch.
    final responses = StreamController<SeismicityDecoderWorkerResponse>();
    final errors = StreamController<SeismicityDecoderWorkerError>();
    final exits = StreamController<SeismicityDecoderWorkerExit>();
    responsePort.listen((message) {
      switch (message) {
        case SendPort() when !workerPort.isCompleted:
          workerPort.complete(message);
        case SeismicityDecoderWorkerResponse():
          responses.add(message);
      }
    });
    errorPort.listen((message) {
      final errorMessage = switch (message) {
        [final error, ...] => error.toString(),
        _ => message.toString(),
      };
      if (!workerPort.isCompleted) {
        workerPort.complete(null);
      }
      errors.add(SeismicityDecoderWorkerError(message: errorMessage));
    });
    exitPort.listen((_) {
      if (!workerPort.isCompleted) {
        workerPort.complete(null);
      }
      exits.add(const SeismicityDecoderWorkerExit());
      if (!exited.isCompleted) {
        exited.complete();
      }
      unawaited(errors.close());
      unawaited(exits.close());
      errorPort.close();
      exitPort.close();
    });
    final isolate = await Isolate.spawn(
      workerMain,
      responsePort.sendPort,
      onError: errorPort.sendPort,
      onExit: exitPort.sendPort,
    );

    return _DartSeismicityDecoderWorkerEndpoint(
      isolate: isolate,
      workerPort: workerPort.future,
      responsePort: responsePort,
      responsesController: responses,
      errors: errors.stream,
      exits: exits.stream,
      exited: exited.future,
    );
  }
}

final class _DartSeismicityDecoderWorkerEndpoint
    implements SeismicityDecoderWorkerEndpoint {
  _DartSeismicityDecoderWorkerEndpoint({
    required this._isolate,
    required this._workerPort,
    required this._responsePort,
    required this._responsesController,
    required this.errors,
    required this.exits,
    required this.exited,
  });

  final Isolate _isolate;
  final Future<SendPort?> _workerPort;
  final ReceivePort _responsePort;
  final StreamController<SeismicityDecoderWorkerResponse> _responsesController;
  @override
  final Stream<SeismicityDecoderWorkerError> errors;
  @override
  final Stream<SeismicityDecoderWorkerExit> exits;
  @override
  final Future<void> exited;
  var _receivePortClosed = false;
  var _killed = false;

  @override
  Stream<SeismicityDecoderWorkerResponse> get responses =>
      _responsesController.stream;

  @override
  void send({required SeismicityDecoderWorkerRequest request}) {
    unawaited(
      _workerPort.then((port) {
        if (port != null) {
          port.send(request);
        }
      }),
    );
  }

  @override
  void closeReceivePort() {
    if (_receivePortClosed) {
      return;
    }
    _receivePortClosed = true;
    _responsePort.close();
    unawaited(_responsesController.close());
  }

  @override
  void kill() {
    if (_killed) {
      return;
    }
    _killed = true;
    _isolate.kill(priority: Isolate.immediate);
  }
}
