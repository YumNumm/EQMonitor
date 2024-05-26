import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  final key = ref.watch(telegramUrlProvider).apiAuthorization;
  final authorization = key != null ? 'Bearer $key' : null;
  final dio = Dio(
    BaseOptions(
      headers: {
        'user-agent': 'eqmonitor-${kIsWeb ? "web" : Platform.version}',
        'x-operation-system-version':
            kIsWeb ? 'web' : Platform.operatingSystemVersion,
        if (authorization != null) 'authorization': authorization,
      },
      baseUrl: ref.watch(telegramUrlProvider).restApiUrl,
      contentType: ContentType.json.value,
      connectTimeout: const Duration(milliseconds: 5000),
      sendTimeout: const Duration(milliseconds: 5000),
    ),
  );
  if (ref.watch(isDioProxyEnabledProvider) || kDebugMode) {
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () =>
          HttpClient()..findProxy = (url) => 'PROXY 192.168.151.154:9090',
    );
  }
  HttpOverrides.global = _HttpOverrides();
  dio.interceptors.add(
    TalkerDioLogger(
      settings: TalkerDioLoggerSettings(
        errorPen: AnsiPen()..red(),
        requestPen: AnsiPen()..yellow(),
        responsePen: AnsiPen()..green(),
      ),
      talker: ref.watch(talkerProvider),
    ),
  );
  return dio;
}

class _HttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..findProxy = (url) => 'PROXY 192.168.151.154:9090';
  }
}

@Riverpod(keepAlive: true)
class IsDioProxyEnabled extends _$IsDioProxyEnabled {
  @override
  bool build() {
    if (kIsWeb || !kDebugMode) {
      return false;
    }
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(_key) ?? false;
  }

  Future<void> set({required bool value}) async {
    state = value;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_key, value);
  }

  static const String _key = 'is_dio_proxy_enabled';
}
