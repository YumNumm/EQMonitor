import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/data/network/native_dio_factory.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/api_user_agent_provider.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_session.dart';
import 'package:eqmonitor/feature/auth/data/notifier/auth_session_notifier.dart';
import 'package:eqmonitor/feature/auth/data/provider/user_jwt_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/user_bytes_request_executor.dart';
import 'package:eqmonitor/feature/auth/data/repository/user_json_request_executor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_api_client.g.dart';

@Riverpod(keepAlive: true)
Future<UserApiGateway> userApiClient(Ref ref) async {
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  final dio = const NativeDioFactory().build(
    options: DioBaseOptionsFactory.build(baseUrl: telegramUrl.restApiUrl),
  );
  dio.options.headers[HttpHeaders.userAgentHeader] = ref.watch(
    apiUserAgentProvider,
  );
  ref.onDispose(() => dio.close(force: true));
  return UserApiClient(
    dio: dio,
    jwtProvider: await ref.watch(userJwtServiceProvider.future),
    invalidateSession: () =>
        ref.read(authSessionProvider.notifier).invalidate(),
  );
}

typedef AuthSessionInvalidator =
    Future<Result<AuthSession, AuthFailure>> Function();

abstract interface class UserApiGateway {
  Future<Result<Map<String, dynamic>, AuthFailure>> getJson({
    required String path,
    Map<String, dynamic>? queryParameters,
  });

  Future<Result<Uint8List, AuthFailure>> getBytes({required String path});
}

final class const UserApiClient({
  required Dio dio,
  required UserJwtProvider jwtProvider,
  required AuthSessionInvalidator invalidateSession,
}) implements UserApiGateway {
  final Dio _dio = dio;
  final UserJwtProvider _jwtProvider = jwtProvider;
  final AuthSessionInvalidator _invalidateSession = invalidateSession;

  @override
  Future<Result<Map<String, dynamic>, AuthFailure>> getJson({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) => requestJson(
    method: 'GET',
    path: path,
    queryParameters: queryParameters,
  );

  @override
  Future<Result<Uint8List, AuthFailure>> getBytes({required String path}) =>
      authorized(
        request: (jwt) => const UserBytesRequestExecutor().perform(
          dio: _dio,
          path: path,
          jwt: jwt,
        ),
      );

  Future<Result<Map<String, dynamic>, AuthFailure>> requestJson({
    required String method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) => authorized(
    request: (jwt) => const UserJsonRequestExecutor().perform(
      dio: _dio,
      method: method,
      path: path,
      jwt: jwt,
      queryParameters: queryParameters,
      data: data,
    ),
  );

  Future<Result<T, AuthFailure>> authorized<T>({
    required Future<Result<T, AuthFailure>> Function(String jwt) request,
  }) async {
    final initialJwt = await _jwtProvider.getValidJwt();
    if (initialJwt case Failure(:final exception, :final stackTrace)) {
      if (exception.kind == AuthFailureKind.unauthorized) {
        await _invalidateSession();
      }
      return Failure(exception, stackTrace);
    }
    final first = await request(initialJwt.unwrap());
    if (first case Failure(:final exception)
        when exception.kind == AuthFailureKind.unauthorized) {
      final refreshedJwt = await _jwtProvider.getValidJwt(forceRefresh: true);
      if (refreshedJwt case Failure(
        :final exception,
        :final stackTrace,
      )) {
        if (exception.kind == AuthFailureKind.unauthorized) {
          await _invalidateSession();
        }
        return Failure(exception, stackTrace);
      }
      final retry = await request(refreshedJwt.unwrap());
      if (retry case Failure(:final exception)
          when exception.kind == AuthFailureKind.unauthorized) {
        await _invalidateSession();
      }
      return retry;
    }
    return first;
  }
}
