import 'dart:io';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kyoshin_monitor_dio.g.dart';

@Riverpod(keepAlive: true)
Dio kyoshinMonitorDio(Ref ref) => Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 2),
    receiveTimeout: const Duration(seconds: 2),
    sendTimeout: const Duration(seconds: 2),
    headers: {
      HttpHeaders.acceptHeader:
          'text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01',
      'Accept-Language': 'ja-JP,ja;q=0.9,en-JP;q=0.8,en;q=0.7,en-US;q=0.6',
      HttpHeaders.cacheControlHeader: 'no-cache',
      'Connection': 'keep-alive',
      'DNT': '1',
      'Pragma': 'no-cache',
      HttpHeaders.refererHeader: 'http://www.kmoni.bosai.go.jp/',
      HttpHeaders.userAgentHeader:
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36',
      'X-Requested-With': 'XMLHttpRequest',
    },
  ),
);
