// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:dio/dio.dart';

import 'clients/auth_api_client.dart';
import 'clients/anonymous_api_client.dart';

/// Better Auth `v1.1.0`.
///
/// API Reference for your Better Auth Instance.
class ApiClient {
  ApiClient(
    Dio dio, {
    String? baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String? _baseUrl;

  static String get version => '1.1.0';

  AuthApiClient? _auth;
  AnonymousApiClient? _anonymous;

  AuthApiClient get auth => _auth ??= AuthApiClient(_dio, baseUrl: _baseUrl);

  AnonymousApiClient get anonymous => _anonymous ??= AnonymousApiClient(_dio, baseUrl: _baseUrl);
}
