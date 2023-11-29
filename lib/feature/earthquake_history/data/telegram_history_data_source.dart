import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/dio_provider.dart';
import 'package:eqmonitor/feature/home/features/telegram_url/provider/telegram_url_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'telegram_history_data_source.g.dart';

@Riverpod(
  keepAlive: true,
  dependencies: [],
)
TelegramHistoryDataSource telegramHistoryDataSource(
  TelegramHistoryDataSourceRef ref,
) =>
    TelegramHistoryDataSource(
      host: ref.watch(telegramUrlProvider).restApiUrl,
      dio: ref.watch(dioProvider),
    );

class TelegramHistoryDataSource {
  TelegramHistoryDataSource({
    required this.host,
    required this.dio,
  });

  final String host;
  final Dio dio;

  /// EventIdごとに電文をまとめた電文履歴を取得する
  Future<TelegramHistoryV3> getTelegramHistoryV3({
    required bool includeEew,
    required int limit,
    required int offset,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      '$host/v3/telegram',
      queryParameters: {
        'includeEew': includeEew,
        'limit': limit,
        'offset': offset,
      },
    );
    final data = response.data;
    if (data == null) {
      throw Exception('data is null');
    }
    final meta = D1DbExecutionResult.fromJson(
      data['meta'] as Map<String, dynamic>,
    );
    final isSuccess = data['success'] as bool;
    final result = <String, List<TelegramV3>>{};
    final preResults = data['results'] as Map<String, dynamic>? ?? {};
    for (final e in preResults.entries) {
      final key = e.key;
      final value = e.value as List<dynamic>;
      final newValue = value
          .map((e) {
            try {
              return TelegramV3.fromJson(e as Map<String, dynamic>);
            } on CheckedFromJsonException catch (e) {
              FirebaseCrashlytics.instance.log(
                'TelegramV3.fromJson CheckedFromJsonException: '
                '${e.message} ${e.key}',
              );
              log('TelegramV3.fromJson CheckedFromJsonException: '
                  '${e.message} ${e.key}');
              return null;
              // ignore: avoid_catches_without_on_clauses
            } catch (e) {
              FirebaseCrashlytics.instance.log('TelegramV3.fromJson error: $e');
              log('TelegramV3.fromJson error: $e');
              return null;
            }
          })
          .whereType<TelegramV3>()
          .toList();
      result.addAll({
        key: newValue,
      });
    }
    return TelegramHistoryV3(
      results: result,
      success: isSuccess,
      meta: meta,
    );
  }

  /// EventIdで指定した電文を取得する
  Future<List<TelegramV3>> getTelegramV3({
    required String eventId,
  }) async {
    final response = await dio.get<Map<String, dynamic>>(
      '$host/v3/telegram/eventId/$eventId',
      options: Options(
        responseType: ResponseType.json,
      ),
    );
    final lists = response.data!['results'] as List<dynamic>;
    return lists
        .map((e) => TelegramV3.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
