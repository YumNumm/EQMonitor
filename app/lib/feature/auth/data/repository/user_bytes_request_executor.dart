import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/auth/data/repository/auth_request_executor.dart';

final class const UserBytesRequestExecutor({
  final AuthRequestExecutor authRequestExecutor = const AuthRequestExecutor(),
}) {
  Future<Result<Uint8List, AuthFailure>> perform({
    required Dio dio,
    required String path,
    required String jwt,
  }) => authRequestExecutor.capture(() async {
    final response = await dio.get<List<int>>(
      path,
      options: Options(
        responseType: ResponseType.bytes,
        headers: {'Authorization': 'Bearer $jwt'},
      ),
    );
    return switch (response.data) {
      final List<int> value => Uint8List.fromList(value),
      _ => throw const AuthFailure(kind: AuthFailureKind.invalidResponse),
    };
  });
}
