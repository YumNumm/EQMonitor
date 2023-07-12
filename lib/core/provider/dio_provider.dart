import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:eqmonitor/feature/home/features/telegram_url/provider/telegram_url_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final key = ref.watch(telegramUrlProvider).apiAuthorization;
  final authorization = key != null ? 'Bearer $key' : null;
  final dio = Dio(
    BaseOptions(
      headers: {
        'user-agent': 'eqmonitor-${Platform.version}',
        'x-operation-system-version': Platform.operatingSystemVersion,
        if (authorization != null) 'authorization': authorization,
      },
    ),
  )..httpClientAdapter = Http2Adapter(
      ConnectionManager(
        idleTimeout: const Duration(seconds: 10),
        // debug時は証明書の検証を行わない
        onClientCreate: (_, config) =>
            config.onBadCertificate = (_) => kDebugMode,
      ),
    );
  return dio;
}
