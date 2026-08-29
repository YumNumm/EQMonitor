import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/auth_request_executor.dart';

final class UserJsonRequestExecutor {
  const new({
    this.authRequestExecutor = const AuthRequestExecutor(),
  });

  final AuthRequestExecutor authRequestExecutor;

  Future<Result<Map<String, dynamic>, AuthFailure>> perform({
    required Dio dio,
    required String method,
    required String path,
    required String jwt,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) => authRequestExecutor.capture(() async {
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
}
