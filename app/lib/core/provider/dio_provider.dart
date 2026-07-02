import 'dart:io';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/http_cache_store_provider.dart';
import 'package:eqmonitor/core/provider/chuck_provider.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/interceptor/app_check_interceptor.dart';
import 'package:eqmonitor/core/provider/interceptor/device_auth_token_interceptor.dart';
import 'package:eqmonitor/core/provider/interceptor/device_id_interceptor.dart';
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
  final appCheckInterceptor = ref.watch(appCheckInterceptorProvider);
  final deviceIdInterceptor = await ref.watch(
    deviceIdInterceptorProvider.future,
  );
  final deviceAuthTokenInterceptor = await ref.watch(
    deviceAuthTokenInterceptorProvider.future,
  );

  final dio = Dio(buildApiBaseOptions(baseUrl: telegramUrl.restApiUrl));
  dio.options.headers.addAll({
    'x-eqmonitor-version': '${package.version}+${package.buildNumber}',
    'x-eqmonitor-platform': Platform.isAndroid ? 'android' : 'ios',
  });
  dio.options.connectTimeout = const Duration(milliseconds: 10000);
  dio.options.sendTimeout = const Duration(milliseconds: 10000);
  dio.interceptors.add(appCheckInterceptor);
  dio.interceptors.add(deviceIdInterceptor);
  dio.interceptors.add(deviceAuthTokenInterceptor);

  final chuck = ref.watch(chuckProvider);
  dio.interceptors.add(chuck.dioInterceptor);

  final httpCache = await ref.watch(httpCacheStoreProvider.future);
  dio.interceptors.add(HttpCacheInterceptor(httpCache));
  dio.interceptors.add(
    TalkerDioLogger(
      settings: TalkerDioLoggerSettings(
        errorPen: AnsiPen()..red(),
        requestPen: AnsiPen()..yellow(),
        responsePen: AnsiPen()..green(),
        printRequestHeaders: true,
        hiddenHeaders: {'X-Firebase-AppCheck', 'Authorization'},
        printResponseData: false,
        printErrorMessage: false,
      ),
      talker: talker,
    ),
  );
  return dio;
}
