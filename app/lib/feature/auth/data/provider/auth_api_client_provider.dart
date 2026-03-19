import 'package:better_auth_api_client/export.dart' as auth_api;
import 'package:dio/dio.dart';
import 'package:eqmonitor/core/util/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_api_client_provider.g.dart';

@Riverpod(keepAlive: true)
auth_api.ApiClient authApiClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      // ignore: avoid_redundant_argument_values
      baseUrl: Env.betterAuthUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  return auth_api.ApiClient(dio);
}
