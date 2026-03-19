import 'package:better_auth_api_client/export.dart' as auth_api;
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/util/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'auth_api_client_provider.g.dart';

@Riverpod(keepAlive: true)
auth_api.ApiClient authApiClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      // ignore: avoid_redundant_argument_values
      baseUrl: Env.betterAuthUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      // POSTリクエストの307/308リダイレクトはDioが正しく処理できないため、
      // インターセプターで手動処理する
      followRedirects: false,
    ),
  );
  // 307/308リダイレクトをPOSTでも正しく処理するインターセプター
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) {
        final response = error.response;
        if (response != null &&
            (response.statusCode == 307 || response.statusCode == 308)) {
          final redirectUrl = response.headers.value('location');
          if (redirectUrl != null) {
            final options = error.requestOptions;
            options.path = redirectUrl;
            dio.fetch<dynamic>(options).then(
              handler.resolve,
              onError: (Object e) {
                if (e is DioException) {
                  handler.reject(e);
                } else {
                  handler.reject(
                    DioException(
                      requestOptions: options,
                      error: e,
                    ),
                  );
                }
              },
            );
            return;
          }
        }
        handler.next(error);
      },
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
  return auth_api.ApiClient(dio);
}
