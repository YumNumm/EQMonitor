import 'dart:convert';

import 'package:cache/src/http/http_cache_entry.dart';
import 'package:dio/dio.dart';

Response<dynamic> restoreResponse(
  RequestOptions options,
  HttpCacheEntry entry,
) {
  final dynamic data;
  switch (entry.responseType) {
    case 'bytes':
      data = entry.body;
    case 'plain':
      data = utf8.decode(entry.body);
    case 'json':
    default:
      data = jsonDecode(utf8.decode(entry.body));
  }
  return Response<dynamic>(
    requestOptions: options,
    statusCode: 200,
    data: data,
    headers: Headers.fromMap(entry.headers),
  );
}
