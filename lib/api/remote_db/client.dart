// ignore_for_file: inference_failure_on_function_invocation

import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart' hide Response;
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:eqmonitor/api/dio_firebase_performance.dart';
import 'package:http/http.dart';

class SupabaseHttpsClientWithDioAndFirebase implements Client {
  final Dio dio = Dio()
    ..options.connectTimeout = 5000
    ..interceptors.add(DioFirebasePerformanceInterceptor())
    ..httpClientAdapter = Http2Adapter(
      ConnectionManager(),
    );

  @override
  void close() {}

  @override
  Future<Response> delete(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final res = await dio.deleteUri(
      url,
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    return res as Response;
  }

  @override
  Future<Response> get(Uri url, {Map<String, String>? headers}) async {
    final res = await dio.getUri(
      url,
      options: Options(
        headers: headers,
      ),
    );
    return res as Response;
  }

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) async {
    final res = await dio.headUri(
      url,
      options: Options(
        headers: headers,
      ),
    );
    return res as Response;
  }

  @override
  Future<Response> patch(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final res = await dio.patchUri(
      url,
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    return res as Response;
  }

  @override
  Future<Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final res = await dio.postUri(
      url,
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    return res as Response;
  }

  @override
  Future<Response> put(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    final res = await dio.putUri(
      url,
      data: body,
      options: Options(
        headers: headers,
      ),
    );
    return res as Response;
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    final res = await dio.getUri(
      url,
      options: Options(
        headers: headers,
      ),
    );
    return res.data as String;
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    final res = await dio.getUri(
      url,
      options: Options(
        headers: headers,
        responseType: ResponseType.bytes,
      ),
    );
    return res.data;
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    throw UnimplementedError();
  }
}
