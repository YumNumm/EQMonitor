import 'dart:convert';
import 'dart:typed_data';

import 'package:cache/src/http/http_cache_entry.dart';
import 'package:cache/src/http/http_cache_store.dart';
import 'package:cache/src/http/restore_response.dart';
import 'package:dio/dio.dart';

const _keyExtra = 'cache.key';

/// `HttpCacheInterceptor.onRequest` でこのキーが `true` に設定されている場合、
/// `if-none-match` ヘッダの付与をスキップする（200 保存は通常どおり行う）。
const kForceFreshExtra = 'cache.force_fresh';

class HttpCacheInterceptor extends Interceptor {
  new(this.store, {DateTime Function() now = DateTime.now}) : _now = now;

  final HttpCacheStore store;
  final DateTime Function() _now;

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
    options.validateStatus = (status) => status == 304 || base(status);

    // force-fresh: skip conditional headers, still save on 200
    if (options.extra[kForceFreshExtra] == true) {
      options.headers.remove('if-none-match');
      handler.next(options);
      return;
    }

    // 条件付きリクエスト(304)を許可する以上、304 が返ってきたら必ず
    // キャッシュから復元できる状態でなければならない。復元元が無い／壊れて
    // いる場合に if-none-match を付けると、復元不能な 304 が呼び出し側へ
    // 漏れてしまうため、その時はヘッダを除去してフルレスポンスを取得する。
    // 上流(リポジトリ等)が独自に付与した if-none-match もここで一元管理する。
    final HttpCacheEntry? cached;
    try {
      cached = await store.read(key);
    } catch (_) {
      options.headers.remove('if-none-match');
      options.headers.remove('if-modified-since');
      handler.next(options);
      return;
    }
    if (cached?.eTag != null && _isRestorable(options, cached!)) {
      options.headers['if-none-match'] = cached.eTag;
    } else {
      options.headers.remove('if-none-match');
    }
    handler.next(options);
  }

  /// キャッシュエントリが実際に復元(パース)可能かを検証する。
  bool _isRestorable(RequestOptions options, HttpCacheEntry entry) {
    try {
      restoreResponse(options, entry);
      return true;
    } on Object {
      return false;
    }
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
        // 復元元が消えた 304 (body なし) を成功として渡すとデシリアライズで
        // 失敗するため、応答エラーとして扱う。
        handler.reject(
          DioException.badResponse(
            statusCode: 304,
            requestOptions: response.requestOptions,
            response: response,
          ),
        );
        return;
      }
      try {
        await store.touch(
          key: key,
          updatedAtMs: _now().millisecondsSinceEpoch,
        );
      } catch (_) {
        // LRU の記録に失敗しても、復元できた応答は返す。
      }
      handler.resolve(restoreResponse(response.requestOptions, cached));
      return;
    }
    if (response.statusCode == 200) {
      final entry = _toEntry(key, response);
      if (entry != null) {
        try {
          await store.write(entry);
        } catch (_) {
          // キャッシュ障害で成功したネットワーク応答を失敗にしない。
        }
      }
    }
    handler.next(response);
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
      updatedAtMs: _now().millisecondsSinceEpoch,
    );
  }
}
