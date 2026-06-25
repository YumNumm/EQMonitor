import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/src/http/http_cache_entry.dart';
import 'package:cache/src/http/http_cache_store.dart';
import 'package:dio/dio.dart';

const _keyExtra = 'cache.key';

class HttpCacheInterceptor extends Interceptor {
  HttpCacheInterceptor(this.store);

  final HttpCacheStore store;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.method.toUpperCase() != 'GET') {
      handler.next(options);
      return;
    }
    final key = store.primaryKeyForUrl(options);
    options.extra[_keyExtra] = key;
    final base = options.validateStatus;
    options.validateStatus = (status) =>
        status == 304 || base(status);
    final cached = await store.read(key);
    if (cached?.eTag != null) {
      options.headers['if-none-match'] = cached!.eTag;
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    final key = response.requestOptions.extra[_keyExtra] as String?;
    if (key == null) {
      handler.next(response);
      return;
    }
    if (response.statusCode == 304) {
      final cached = await store.read(key);
      if (cached == null) {
        handler.next(response);
        return;
      }
      handler.resolve(_restore(response.requestOptions, cached));
      return;
    }
    if (response.statusCode == 200) {
      final entry = _toEntry(key, response);
      if (entry != null) {
        await store.write(entry);
      }
    }
    handler.next(response);
  }

  Response<dynamic> _restore(RequestOptions options, HttpCacheEntry entry) {
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
      statusCode: entry.statusCode,
      data: data,
      headers: Headers.fromMap(entry.headers),
    );
  }

  HttpCacheEntry? _toEntry(String key, Response<dynamic> response) {
    final type = response.requestOptions.responseType;
    final Uint8List body;
    final String typeName;
    switch (type) {
      case ResponseType.bytes:
        body = Uint8List.fromList((response.data as List).cast<int>());
        typeName = 'bytes';
      case ResponseType.plain:
        body = Uint8List.fromList(utf8.encode(response.data as String));
        typeName = 'plain';
      case ResponseType.json:
        body = Uint8List.fromList(utf8.encode(jsonEncode(response.data)));
        typeName = 'json';
      case ResponseType.stream:
        return null;
    }
    return HttpCacheEntry(
      key: key,
      statusCode: response.statusCode ?? 200,
      eTag: response.headers.value('etag'),
      headers: response.headers.map,
      responseType: typeName,
      body: body,
      updatedAtMs: 0,
    );
  }
}
