import 'package:dio/dio.dart';
import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/common/provider/dio_provider.dart';
import 'package:eqmonitor/feature/earthquake_history/model/data/telegram_history.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../home/features/telegram_url/provider/telegram_url_provider.dart';

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
    return compute(
      TelegramHistoryV3.fromJson,
      data,
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
