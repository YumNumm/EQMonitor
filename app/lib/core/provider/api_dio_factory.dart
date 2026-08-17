import 'dart:io';

import 'package:cache/cache.dart';
import 'package:dio/dio.dart';
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

part 'api_dio_factory.g.dart';

final class ApiDioFactory {
  const new({
    required this.baseUrl,
    required this.headers,
    required this.baseInterceptors,
  });

  final String baseUrl;
  final Map<String, String> headers;
  final List<Interceptor> baseInterceptors;

  Dio build({HttpCacheStore? httpCacheStore}) {
    final dio = Dio(DioBaseOptionsFactory.build(baseUrl: baseUrl));
    dio.options
      ..headers.addAll(headers)
      ..connectTimeout = const Duration(seconds: 10)
      ..sendTimeout = const Duration(seconds: 10);
    dio.interceptors.addAll(baseInterceptors);
    if (httpCacheStore != null) {
      dio.interceptors.add(HttpCacheInterceptor(httpCacheStore));
    }
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
}

@Riverpod(keepAlive: true)
Future<ApiDioFactory> apiDioFactory(Ref ref) async {
  final package = ref.watch(packageInfoProvider);
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final baseInterceptors = <Interceptor>[
    ref.watch(appCheckInterceptorProvider),
    await ref.watch(deviceIdInterceptorProvider.future),
    await ref.watch(deviceAuthTokenInterceptorProvider.future),
  ];
  if (chuckBuildModePolicy.captureTraffic) {
    baseInterceptors.add(ref.watch(chuckProvider).dioInterceptor);
  }
  return ApiDioFactory(
    baseUrl: telegramUrl.restApiUrl,
    headers: {
      'x-eqmonitor-version': '${package.version}+${package.buildNumber}',
      'x-eqmonitor-platform': Platform.isAndroid ? 'android' : 'ios',
    },
    baseInterceptors: baseInterceptors,
  );
}
