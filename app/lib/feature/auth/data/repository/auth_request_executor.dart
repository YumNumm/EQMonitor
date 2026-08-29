import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';

final class AuthRequestExecutor {
  const new({
    this.failureMapper = const DioAuthFailureMapper(),
  });

  final DioAuthFailureMapper failureMapper;

  Future<Result<T, AuthFailure>> capture<T>(
    FutureOr<T> Function() request,
  ) async {
    try {
      return Success(await request());
    } on AuthFailure catch (failure, stackTrace) {
      return Failure(failure, stackTrace);
    } on DioException catch (exception, stackTrace) {
      return Failure(failureMapper.map(exception), stackTrace);
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
}

final class DioAuthFailureMapper {
  const new();

  AuthFailure map(DioException exception) {
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
    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return AuthFailure(
        kind: AuthFailureKind.invalidResponse,
        statusCode: statusCode,
      );
    }
    if (statusCode != null && statusCode >= 500) {
      return AuthFailure(
        kind: AuthFailureKind.server,
        statusCode: statusCode,
      );
    }
    if (exception.type
        case DioExceptionType.connectionTimeout ||
            DioExceptionType.sendTimeout ||
            DioExceptionType.receiveTimeout) {
      return AuthFailure(
        kind: AuthFailureKind.timeout,
        statusCode: statusCode,
      );
    }
    if (exception.type case DioExceptionType.connectionError) {
      return AuthFailure(
        kind: AuthFailureKind.network,
        statusCode: statusCode,
      );
    }
    return AuthFailure(
      kind: AuthFailureKind.unknown,
      statusCode: statusCode,
    );
  }
}
