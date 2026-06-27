import 'package:dio/dio.dart';

BaseOptions buildApiBaseOptions({required String baseUrl}) => BaseOptions(
  baseUrl: baseUrl,
  contentType: 'application/json',
  listFormat: ListFormat.multiCompatible,
);
