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
    cookieJar: CookieJar(),
  );
}

final class BetterAuthApiClient {
  new({
    required Dio dio,
    required BetterAuthSessionRepository sessionRepository,
    required CookieJar cookieJar,
  }) : _dio = dio,
       _sessionRepository = sessionRepository,
       _cookieJar = cookieJar {
    _dio.interceptors.addAll([
      CookieManager(cookieJar),
      BetterAuthSessionInterceptor(sessionRepository: sessionRepository),
    ]);
  }

  final Dio _dio;
  final BetterAuthSessionRepository _sessionRepository;
  final CookieJar _cookieJar;

  Future<Result<void, AuthFailure>> signInSocial({
    required String provider,
    required String idToken,
    String? nonce,
  }) {
    final sessionGeneration = _sessionRepository.generation;
    return captureAuthRequest(() async {
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
        expectedGeneration: sessionGeneration,
      );
    });
  }

  Future<Result<String, AuthFailure>> fetchJwt() {
    final sessionGeneration = _sessionRepository.generation;
    return captureAuthRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/auth/token',
      );
      await persistBetterAuthSessionToken(
        response: response,
        sessionRepository: _sessionRepository,
        expectedGeneration: sessionGeneration,
      );
      return switch (response.data?['token']) {
        final String token when token.isNotEmpty => token,
        _ => throw const AuthFailure(kind: AuthFailureKind.invalidResponse),
      };
    });
  }

  Future<Result<void, AuthFailure>> signOut() async {
    final sessionGeneration = _sessionRepository.generation;
    final remoteResult = await captureAuthRequest(
      () async {
        final response = await _dio.post<void>('/api/auth/sign-out');
        await persistBetterAuthSessionToken(
          response: response,
          sessionRepository: _sessionRepository,
          expectedGeneration: sessionGeneration,
        );
      },
    );
    final cookieResult = await clearCookies();
    return switch (remoteResult) {
      Failure(:final exception, :final stackTrace) => Failure(
        exception,
        stackTrace,
      ),
      Success() => cookieResult,
    };
  }

  Future<Result<void, AuthFailure>> clearCookies() => captureAuthRequest(
    _cookieJar.deleteAll,
  );

  Future<Result<bool, AuthFailure>> getSession() {
    final sessionGeneration = _sessionRepository.generation;
    return captureAuthRequest(() async {
      final response = await _dio.get<Map<String, dynamic>>(
        '/api/auth/get-session',
      );
      await persistBetterAuthSessionToken(
        response: response,
        sessionRepository: _sessionRepository,
        expectedGeneration: sessionGeneration,
      );
      return response.data?['session'] is Map<String, dynamic>;
    });
  }
}

final class BetterAuthSessionInterceptor extends Interceptor {
  new({required this.sessionRepository});

  final BetterAuthSessionRepository sessionRepository;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokenResult = await sessionRepository.readSessionToken();
    switch (tokenResult) {
      case Success(:final value):
        if (value != null && isSafeBetterAuthSessionToken(value)) {
          options.headers['Authorization'] = 'Bearer $value';
        }
        handler.next(options);
      case Failure(:final exception, :final stackTrace):
        handler.reject(
          DioException(
            requestOptions: options,
            error: exception,
            stackTrace: stackTrace,
          ),
        );
    }
  }
}

Future<void> persistBetterAuthSessionToken<T>({
  required Response<T> response,
  required BetterAuthSessionRepository sessionRepository,
  required int expectedGeneration,
}) async {
  final tokenHeaders = response.headers.map['set-auth-token'];
  if (tokenHeaders == null || tokenHeaders.length != 1) {
    return;
  }
  final token = tokenHeaders.single;
  if (isSafeBetterAuthSessionToken(token)) {
    final saveResult = await sessionRepository.saveSessionToken(
      token: token,
      expectedGeneration: expectedGeneration,
    );
    if (saveResult case Failure(:final exception)) {
      throw exception;
    }
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
  } on Exception catch (_, stackTrace) {
    return Failure(
      const AuthFailure(kind: AuthFailureKind.unknown),
      stackTrace,
    );
  }
}

AuthFailure authFailureFromDio(DioException exception) {
  if (exception.error case final AuthFailure failure) {
    return failure;
  }
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
