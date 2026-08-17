import 'package:dio/dio.dart';

/// API 用 [Dio] の [BaseOptions] を組み立てるユーティリティ。
class DioBaseOptionsFactory {
  const new _();

  static BaseOptions build({required String baseUrl}) => BaseOptions(
    baseUrl: baseUrl,
    contentType: 'application/json',
    listFormat: ListFormat.multiCompatible,
  );
}
