import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/interceptor/app_check_interceptor.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Dio> dio(Ref ref) async {
  final package = ref.watch(packageInfoProvider);
  final telegramUrl = await ref.watch(telegramUrlProvider.future);

  final dio = Dio(
    BaseOptions(
      headers: {
        'user-agent':
            '${package.packageName}/${package.version}+${package.buildNumber}',
      },
      baseUrl: telegramUrl.restApiUrl,
      contentType: ContentType.json.value,
      connectTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000),
      // バックエンドは query の配列を `key[]=a&key[]=b` 形式で受け取る。
      // `multi` の単一要素は `key=a` となりスカラー扱いで 400 になる。
      listFormat: ListFormat.multiCompatible,
    ),
  );
  dio.interceptors.add(
    AppCheckInterceptor(),
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
