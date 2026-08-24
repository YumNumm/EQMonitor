import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'better_auth_api_client.g.dart';

@Riverpod(keepAlive: true)
Future<BetterAuthApiClient> betterAuthApiClient(Ref ref) async {
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final sessionRepository = await ref.watch(
    betterAuthSessionRepositoryProvider.future,
  );
  return BetterAuthApiClient(
    dio: Dio(
      DioBaseOptionsFactory.build(baseUrl: telegramUrl.restApiUrl),
    ),
    sessionRepository: sessionRepository,
  );
}

final class BetterAuthApiClient {
  new({
    required Dio dio,
    required BetterAuthSessionRepository sessionRepository,
  }) : _dio = dio,
       _sessionRepository = sessionRepository {
    _dio.interceptors.addAll([
      CookieManager(CookieJar()),
      BetterAuthSessionInterceptor(sessionRepository: sessionRepository),
    ]);
  }

  final Dio _dio;
  final BetterAuthSessionRepository _sessionRepository;

  Future<Result<void, AuthFailure>> signInSocial({
    required String provider,
    required String idToken,
    String? nonce,
  }) => captureAuthRequest(() async {
    final response = await _dio.post<void>(
      '/api/auth/sign-in/social',
      data: <String, dynamic>{
        'provider': provider,
        'idToken': <String, dynamic>{
          'token': idToken,
          if (nonce != null && nonce.isNotEmpty) 'nonce': nonce,
        },
      },
    );
    await persistBetterAuthSessionToken(
      response: response,
      sessionRepository: _sessionRepository,
    );
  });

  Future<Result<String, AuthFailure>> fetchJwt() => captureAuthRequest(
    () async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/auth/token',
      );
      await persistBetterAuthSessionToken(
        response: response,
        sessionRepository: _sessionRepository,
      );
      return switch (response.data?['token']) {
        final String token when token.isNotEmpty => token,
        _ => throw const AuthFailure(kind: AuthFailureKind.invalidResponse),
      };
    },
  );

  Future<Result<void, AuthFailure>> signOut() => captureAuthRequest(
    () async {
      final response = await _dio.post<void>('/api/auth/sign-out');
      await persistBetterAuthSessionToken(
        response: response,
        sessionRepository: _sessionRepository,
      );
    },
  );

  Future<Result<bool, AuthFailure>> getSession() => captureAuthRequest(
    () async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/auth/get-session',
      );
      await persistBetterAuthSessionToken(
        response: response,
        sessionRepository: _sessionRepository,
      );
      return response.data?['session'] is Map<String, dynamic>;
    },
  );
}

final class BetterAuthSessionInterceptor extends Interceptor {
  new({required this.sessionRepository});

  final BetterAuthSessionRepository sessionRepository;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await sessionRepository.readSessionToken();
    if (token != null && isSafeBetterAuthSessionToken(token)) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

Future<void> persistBetterAuthSessionToken<T>({
  required Response<T> response,
  required BetterAuthSessionRepository sessionRepository,
}) async {
  final tokenHeaders = response.headers.map['set-auth-token'];
  if (tokenHeaders == null || tokenHeaders.length != 1) {
    return;
  }
  final token = tokenHeaders.single;
  if (isSafeBetterAuthSessionToken(token)) {
    await sessionRepository.saveSessionToken(token: token);
  }
}

bool isSafeBetterAuthSessionToken(String token) {
  if (token.isEmpty || token.trim() != token) {
    return false;
  }
  return !token.codeUnits.any((unit) => unit < 0x21 || unit == 0x7f);
}

Future<Result<T, AuthFailure>> captureAuthRequest<T>(
  FutureOr<T> Function() request,
) async {
  try {
    return Success(await request());
  } on AuthFailure catch (failure, stackTrace) {
    return Failure(failure, stackTrace);
  } on DioException catch (exception, stackTrace) {
    return Failure(authFailureFromDio(exception), stackTrace);
  } on FormatException catch (_, stackTrace) {
    return Failure(
      const AuthFailure(kind: AuthFailureKind.invalidResponse),
      stackTrace,
    );
  }
}

AuthFailure authFailureFromDio(DioException exception) {
  final statusCode = exception.response?.statusCode;
  if (statusCode == 401) {
    return const AuthFailure(
      kind: AuthFailureKind.unauthorized,
      statusCode: 401,
    );
  }
  if (statusCode == 429) {
    return const AuthFailure(
      kind: AuthFailureKind.rateLimited,
      statusCode: 429,
    );
  }
  if (statusCode != null && statusCode >= 500) {
    return AuthFailure(kind: AuthFailureKind.server, statusCode: statusCode);
  }
  if (exception.type
      case DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout) {
    return AuthFailure(kind: AuthFailureKind.timeout, statusCode: statusCode);
  }
  if (exception.type case DioExceptionType.connectionError) {
    return AuthFailure(kind: AuthFailureKind.network, statusCode: statusCode);
  }
  return AuthFailure(kind: AuthFailureKind.unknown, statusCode: statusCode);
}
