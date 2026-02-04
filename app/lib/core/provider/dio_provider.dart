import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final package = ref.watch(packageInfoProvider);

  final dio = Dio(
    BaseOptions(
      headers: {
        'user-agent':
            '${package.packageName}/${package.version}+${package.buildNumber}',
      },
      baseUrl: ref.watch(telegramUrlProvider).restApiUrl,
      contentType: ContentType.json.value,
      connectTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 5000),
    ),
  );
  dio.interceptors.add(
    TalkerDioLogger(
      settings: TalkerDioLoggerSettings(
        errorPen: AnsiPen()..red(),
        requestPen: AnsiPen()..yellow(),
        responsePen: AnsiPen()..green(),
        printResponseData: false,
        printErrorMessage: false,
      ),
      talker: talker,
    ),
  );
  return dio;
}
