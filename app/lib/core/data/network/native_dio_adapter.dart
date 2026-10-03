import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/network/native_dio_io_adapter.dart';

/// Dioの終了と、native requestの実際の終了を分けて管理する。
final class NativeDioAdapter implements HttpClientAdapter {
  new({
    required this.adapter,
    required this.closeTransport,
  });

  final HttpClientAdapter adapter;
  final Future<void> Function() closeTransport;
  final _requests = <NativeDioRequest>{};
  final _closed = Completer<void>();
  bool _closing = false;
  bool _transportClosing = false;

  Future<void> get whenClosed => _closed.future;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    if (_closing) {
      throw StateError('Native Dio adapter is closed');
    }
    late final NativeDioRequest request;
    request = NativeDioRequest(
      adapter: adapter,
      options: options,
      requestStream: requestStream,
      cancelFuture: cancelFuture,
      onDone: () {
        _requests.remove(request);
        closeIfIdle();
      },
    );
    _requests.add(request);
    return request.fetch();
  }

  @override
  void close({bool force = false}) {
    _closing = true;
    if (force) {
      for (final request in _requests.toList()) {
        request.cancel();
      }
    }
    closeIfIdle();
  }

  void closeIfIdle() {
    if (!_closing || _requests.isNotEmpty || _transportClosing) {
      return;
    }
    _transportClosing = true;
    closeTransport().then(_closed.complete, onError: _closed.completeError);
  }
}

final class NativeDioRequest {
  new({
    required this.adapter,
    required this.options,
    required this.requestStream,
    required this.cancelFuture,
    required this.onDone,
  });

  final HttpClientAdapter adapter;
  final RequestOptions options;
  final Stream<Uint8List>? requestStream;
  final Future<void>? cancelFuture;
  final void Function() onDone;
  final _abort = Completer<void>();
  final _done = Completer<void>();

  Future<ResponseBody> fetch() {
    final response = fetchNative();
    final timeout =
        (options.connectTimeout ?? Duration.zero) +
        (options.receiveTimeout ?? Duration.zero);
    return timeout == Duration.zero
        ? response
        : response.timeout(
            timeout,
            onTimeout: () {
              cancel();
              throw DioException.receiveTimeout(
                timeout: timeout,
                requestOptions: options,
              );
            },
          );
  }

  Future<ResponseBody> fetchNative() async {
    try {
      final connectTimeout = options.connectTimeout ?? Duration.zero;
      final response = await adapter.fetch(
        // ヘッダーtimeoutは外側で通知し、nativeのabort完了まで追跡を続ける。
        options.copyWith(
          connectTimeout: Duration.zero,
          receiveTimeout: Duration.zero,
          extra: {
            ...options.extra,
            NativeDioIoAdapter.connectionTimeoutKey:
                connectTimeout > Duration.zero
                ? connectTimeout
                : connectTimeout + (options.receiveTimeout ?? Duration.zero),
          },
        ),
        requestStream,
        Future.any<void>([
          _abort.future,
          if (cancelFuture case final cancellation?) cancellation,
        ]),
      );
      var bodyCancelled = false;
      final controller = StreamController<Uint8List>(
        onCancel: () async {
          bodyCancelled = true;
          cancel();
          await _done.future;
        },
      );
      // source subscriptionをcancelするとCronetの終了を待てないため、
      // consumerのcancel後もnativeのterminal eventまで読み続ける。
      response.stream.listen(
        (data) {
          if (!bodyCancelled) {
            controller.add(data);
          }
        },
        onError: (error, stackTrace) {
          if (!bodyCancelled) {
            controller.addError(error, stackTrace);
          }
        },
        onDone: () {
          unawaited(controller.close());
          finish();
        },
      );
      response.stream = controller.stream;
      return response;
    } catch (_) {
      finish();
      rethrow;
    }
  }

  void cancel() {
    if (!_abort.isCompleted) {
      _abort.complete();
    }
  }

  void finish() {
    if (!_done.isCompleted) {
      cancel();
      _done.complete();
      onDone();
    }
  }
}
