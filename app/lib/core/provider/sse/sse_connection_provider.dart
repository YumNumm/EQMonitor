import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sse_connection_provider.g.dart';

enum SseConnectionState {
  connecting,
  connected,
  disconnected,
}

/// eqmonitor-backend `GET /v2/realtime/stream`（`api/api/src/features/realtime/routes/realtime.ts`）:
/// `text/event-stream` で `event: snapshot` / `event: realtime` と `data: <JSON>`、25秒ごとの `: ping`。
@Riverpod(keepAlive: true)
class SseConnection extends _$SseConnection {
  CancelToken? _cancelToken;

  @override
  Stream<Map<String, dynamic>> build() async* {
    final controller = StreamController<Map<String, dynamic>>();

    ref.onDispose(() {
      _cancelToken?.cancel('disposed');
      unawaited(controller.close());
    });

    ref.listen(appLifecycleProvider, (_, next) {
      if (next == AppLifecycleState.paused) {
        _cancelToken?.cancel('paused');
        log('SSE connection cancelled (paused)');
      }
      if (next == AppLifecycleState.resumed) {
        ref.invalidateSelf();
      }
    });

    unawaited(_connect(controller));
    yield* controller.stream;
  }

  Future<void> _connect(
    StreamController<Map<String, dynamic>> controller,
  ) async {
    _cancelToken = CancelToken();
    try {
      final dio = await ref.read(dioProvider.future);
      final response = await dio.get<ResponseBody>(
        '/v2/realtime/stream',
        options: Options(
          responseType: ResponseType.stream,
          headers: {
            'Accept': 'text/event-stream',
            'Cache-Control': 'no-cache',
          },
        ),
        cancelToken: _cancelToken,
      );

      final stream = response.data?.stream;
      if (stream == null) {
        talker.error('SSE: response stream is null');
        return;
      }

      talker.debug('SSE connection established');

      final buffer = StringBuffer();
      await for (final chunk in stream) {
        if (controller.isClosed) {
          break;
        }
        buffer.write(utf8.decode(chunk));
        var content = buffer.toString();
        buffer.clear();

        while (true) {
          final sep = content.indexOf('\n\n');
          if (sep == -1) {
            buffer.write(content);
            break;
          }
          final frame = content.substring(0, sep);
          content = content.substring(sep + 2);
          _dispatchSseFrame(frame, controller);
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        talker.debug('SSE connection cancelled');
        return;
      }
      talker.error('SSE connection error: $e');
    } finally {
      if (!controller.isClosed) {
        unawaited(controller.close());
      }
    }
  }

  void _dispatchSseFrame(
    String frame,
    StreamController<Map<String, dynamic>> controller,
  ) {
    final normalized = frame.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    if (normalized.isEmpty) {
      return;
    }
    final lines = normalized.split('\n');
    String? event;
    final dataLines = <String>[];
    for (final line in lines) {
      if (line.isEmpty || line.startsWith(':')) {
        continue;
      }
      if (line.startsWith('event:')) {
        event = line.substring(6).trim();
        continue;
      }
      if (line.startsWith('data:')) {
        dataLines.add(line.substring(5).trimLeft());
      }
    }
    if (dataLines.isEmpty) {
      return;
    }
    final raw = dataLines.join('\n');
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        talker.log('SSE message ($event): $raw');
        controller.add(decoded);
      }
    } on FormatException catch (e) {
      talker.warning('SSE: invalid JSON: $e');
    }
  }
}

@Riverpod(keepAlive: true)
class SseConnectionStatus extends _$SseConnectionStatus {
  @override
  SseConnectionState build() {
    final asyncValue = ref.watch(sseConnectionProvider);
    return switch (asyncValue) {
      AsyncLoading() => SseConnectionState.connecting,
      AsyncData() => SseConnectionState.connected,
      AsyncError() => SseConnectionState.disconnected,
    };
  }
}
