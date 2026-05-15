import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'start_repository.g.dart';

const _kEtagKey = 'start_etag';
const _kBodyKey = 'start_body';

@Riverpod(keepAlive: true)
Future<StartRepository> startRepository(Ref ref) async =>
    StartRepository(
      await ref.watch(apiClientProvider.future),
      await SharedPreferences.getInstance(),
    );

class StartRepository {
  StartRepository(this._api, this._prefs);

  final api.ApiClient _api;
  final SharedPreferences _prefs;

  /// Start APIを取得し、304なら有効なキャッシュを返す。
  /// ネットワーク失敗時もキャッシュがあればそれを返す。
  Future<Result<api.StartResponse, Exception>> fetch() async {
    final cachedEtag = _prefs.getString(_kEtagKey);
    try {
      final response = await _api.start.getV1Start(ifNoneMatch: cachedEtag);
      final etag = response.response.headers.value('etag');
      if (etag != null) {
        await _prefs.setString(_kEtagKey, etag);
      }
      final body = jsonEncode(response.data.toJson());
      await _prefs.setString(_kBodyKey, body);
      return Success(response.data);
    } on DioException catch (e, st) {
      if (e.response?.statusCode == 304) {
        final cached = _tryReadCache();
        if (cached != null) {
          return Success(cached);
        }
      }
      final cached = _tryReadCache();
      if (cached != null) {
        return Success(cached);
      }
      return Failure(e, st);
    } on Exception catch (e, st) {
      final cached = _tryReadCache();
      if (cached != null) {
        return Success(cached);
      }
      return Failure(e, st);
    }
  }

  api.StartResponse? _tryReadCache() {
    final body = _prefs.getString(_kBodyKey);
    if (body == null) {
      return null;
    }
    try {
      return api.StartResponse.fromJson(
        jsonDecode(body) as Map<String, Object?>,
      );
    } on FormatException {
      return null;
    }
  }
}
