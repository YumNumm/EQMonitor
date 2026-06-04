import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'changelog_repository.g.dart';

@Riverpod(keepAlive: true)
Future<ChangelogRepository> changelogRepository(Ref ref) async =>
    ChangelogRepository(
      await ref.watch(apiClientProvider.future),
      await SharedPreferences.getInstance(),
    );

class ChangelogRepository {
  ChangelogRepository(this._api, this._prefs);

  final api.ApiClient _api;
  final SharedPreferences _prefs;

  Future<Result<api.ChangelogResponse, Exception>> fetch() async {
    final cachedEtag = _prefs.getString(SharedPreferencesKey.changelogEtag.key);
    try {
      final response = await _api.changelog.getV1Changelog(
        ifNoneMatch: cachedEtag,
      );
      final etag = response.response.headers.value('etag');
      if (etag != null) {
        await _prefs.setString(SharedPreferencesKey.changelogEtag.key, etag);
      }
      final body = jsonEncode(response.data.toJson());
      await _prefs.setString(SharedPreferencesKey.changelogBody.key, body);
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

  api.ChangelogResponse? _tryReadCache() {
    final body = _prefs.getString(SharedPreferencesKey.changelogBody.key);
    if (body == null) {
      return null;
    }
    try {
      return api.ChangelogResponse.fromJson(
        jsonDecode(body) as Map<String, Object?>,
      );
    } on Object {
      return null;
    }
  }
}
