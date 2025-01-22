import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

part 'kyoshin_monitor_dio.g.dart';

@Riverpod(keepAlive: true)
Dio kyoshinMonitorDio(Ref ref) => Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 2),
        receiveTimeout: const Duration(seconds: 2),
        sendTimeout: const Duration(seconds: 2),
        headers: {
          HttpHeaders.userAgentHeader:
              'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
          HttpHeaders.refererHeader: 'http://www.kmoni.bosai.go.jp/',
          HttpHeaders.hostHeader: 'www.kmoni.bosai.go.jp',
          HttpHeaders.cacheControlHeader: 'no-cache',
          HttpHeaders.acceptHeader:
              'image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8',
        },
      ),
    )..interceptors.addAll(
        [
          TalkerDioLogger(
            settings: const TalkerDioLoggerSettings(
              printResponseData: false,
            ),
            talker: talker,
          ),
        ],
      );
