import 'package:dio/dio.dart';
import 'package:eqapi_schema/eqapi_schema.dart';
import 'package:eqmonitor/common/provider/dio_provider.dart';
import 'package:eqmonitor/feature/debug/earthquake_history/model/data/telegram_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:web_socket_client/web_socket_client.dart';

part 'telegram_history_data_source.g.dart';

@Riverpod(keepAlive: true)
TelegramHistoryDataSource telegramHistoryDataSource(
  TelegramHistoryDataSourceRef ref,
) =>
    TelegramHistoryDataSource(
      host: 'https://api.eqmonitor.app',
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
      options: Options(
        validateStatus: (status) => status! == 200,
      ),
    );
    return TelegramHistoryV3.fromJson(response.data!);
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

  /// 電文リアルタイム取得エンドポイントへの接続
  /// [timeOut] は接続タイムアウト時間（秒）
  WebSocket connectToTelegramWebSocketV3({
    int timeOut = 10,
  }) {
    final url = '$host/v3/realtime';
    final webSocket = WebSocket(
      Uri.parse(url),
      timeout: Duration(seconds: timeOut),
    );
    return webSocket;
  }
}
