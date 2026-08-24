import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/dio_base_options.dart';
import 'package:eqmonitor/core/provider/telegram_url/provider/telegram_url_provider.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/provider/user_jwt_provider.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_api_client.dart';
import 'package:eqmonitor/feature/auth/data/repository/better_auth_session_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_api_client.g.dart';

@Riverpod(keepAlive: true)
Future<UserApiClient> userApiClient(Ref ref) async {
  final telegramUrl = await ref.watch(telegramUrlProvider.future);
  return UserApiClient(
    dio: Dio(
      DioBaseOptionsFactory.build(baseUrl: telegramUrl.restApiUrl),
    ),
    jwtProvider: await ref.watch(userJwtServiceProvider.future),
    sessionRepository: await ref.watch(
      betterAuthSessionRepositoryProvider.future,
    ),
  );
}

final class UserApiClient {
  const new({
    required Dio dio,
    required UserJwtProvider jwtProvider,
    required BetterAuthSessionRepository sessionRepository,
  }) : _dio = dio,
       _jwtProvider = jwtProvider,
       _sessionRepository = sessionRepository;

  final Dio _dio;
  final UserJwtProvider _jwtProvider;
  final BetterAuthSessionRepository _sessionRepository;

  Future<Result<Map<String, dynamic>, AuthFailure>> getJson({
    required String path,
    Map<String, dynamic>? queryParameters,
  }) => requestJson(
    method: 'GET',
    path: path,
    queryParameters: queryParameters,
  );

  Future<Result<Map<String, dynamic>, AuthFailure>> requestJson({
    required String method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) async {
    final initialJwt = await _jwtProvider.getValidJwt();
    if (initialJwt case Failure(:final exception, :final stackTrace)) {
      if (exception.kind == AuthFailureKind.unauthorized) {
        await _sessionRepository.clearSession();
        _jwtProvider.clearJwt();
      }
      return Failure(exception, stackTrace);
    }
    final first = await performUserJsonRequest(
      dio: _dio,
      method: method,
      path: path,
      jwt: initialJwt.unwrap(),
      queryParameters: queryParameters,
      data: data,
    );
    if (first case Failure(:final exception)
        when exception.kind == AuthFailureKind.unauthorized) {
      final refreshedJwt = await _jwtProvider.getValidJwt(forceRefresh: true);
      if (refreshedJwt case Failure(
        :final exception,
        :final stackTrace,
      )) {
        if (exception.kind == AuthFailureKind.unauthorized) {
          await _sessionRepository.clearSession();
          _jwtProvider.clearJwt();
        }
        return Failure(exception, stackTrace);
      }
      final retry = await performUserJsonRequest(
        dio: _dio,
        method: method,
        path: path,
        jwt: refreshedJwt.unwrap(),
        queryParameters: queryParameters,
        data: data,
      );
      if (retry case Failure(:final exception)
          when exception.kind == AuthFailureKind.unauthorized) {
        await _sessionRepository.clearSession();
        _jwtProvider.clearJwt();
      }
      return retry;
    }
    return first;
  }
}

Future<Result<Map<String, dynamic>, AuthFailure>> performUserJsonRequest({
  required Dio dio,
  required String method,
  required String path,
  required String jwt,
  Map<String, dynamic>? queryParameters,
  Map<String, dynamic>? data,
}) => captureAuthRequest(() async {
  final response = await dio.request<Map<String, dynamic>>(
    path,
    data: data,
    queryParameters: queryParameters,
    options: Options(
      method: method,
      headers: {'Authorization': 'Bearer $jwt'},
    ),
  );
  return switch (response.data) {
    final Map<String, dynamic> value => value,
    _ => throw const AuthFailure(kind: AuthFailureKind.invalidResponse),
  };
});
