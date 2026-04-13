import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'websocket_provider.g.dart';

enum SseConnectionState {
  connecting,
  connected,
  disconnected,
}

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

    await _connect(controller);

    yield* controller.stream;
  }

  Future<void> _connect(StreamController<Map<String, dynamic>> controller) async {
    final restApiUrl = ref.read(
      telegramUrlProvider.select((v) => v.requireValue.restApiUrl),
    );
    final uri = Uri.parse(restApiUrl).replace(
      path: '/v2/realtime/stream',
    );

    _cancelToken = CancelToken();
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.getUri<ResponseBody>(
        uri,
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
        controller.addError(
          StateError('SSE: response stream is null'),
        );
        return;
      }

      talker.debug('SSE connection established');

      final buffer = StringBuffer();
      await for (final chunk in stream) {
        if (controller.isClosed) {
          break;
        }
        buffer.write(utf8.decode(chunk));
        final lines = buffer.toString().split('\n');
        buffer.clear();
        if (lines.last.isNotEmpty) {
          buffer.write(lines.removeLast());
        } else {
          lines.removeLast();
        }

        for (final line in lines) {
          if (line.startsWith('data:')) {
            final data = line.substring(5).trim();
            if (data.isEmpty) {
              continue;
            }
            try {
              final decoded = jsonDecode(data);
              if (decoded is Map<String, dynamic>) {
                talker.log('SSE message: $data');
                controller.add(decoded);
              }
            } on FormatException catch (e) {
              talker.warning('SSE: invalid JSON: $e');
            }
          }
        }
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        talker.debug('SSE connection cancelled');
        return;
      }
      talker.error('SSE connection error: $e');
      controller.addError(e);
    } catch (e, stackTrace) {
      talker.error('Unexpected SSE connection error: $e', stackTrace);
      controller.addError(e, stackTrace);
    }
  }

  void emit(Map<String, dynamic> data) {
    // no-op: SSEはサーバーからの一方向通信
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
