import 'package:intl/intl.dart';
import 'package:kyoshin_monitor_api/src/api/lpgm_kyoshin_monitor_web_api_client.dart';
import 'package:kyoshin_monitor_api/src/data_source/kyoshin_monitor_web_api_data_source.dart';

class LpgmKyoshinMonitorWebApiDataSource {
  LpgmKyoshinMonitorWebApiDataSource({
    required LpgmKyoshinMonitorWebApiClient client,
  }) : _client = client;

  final LpgmKyoshinMonitorWebApiClient _client;

  /// ベース画像
  Future<List<int>> getBaseMapImageData(BaseMapTheme theme) async =>
      _client.getBaseMapImageData(theme: theme.urlString);

  /// スケール
  Future<List<int>> getScaleImageData(
    RealtimeDataType type,
    RealtimeLayer layer,
    BaseMapTheme theme,
  ) async =>
      _client.getScaleImageData(
        type: type.urlString,
        layer: layer.urlString,
        theme: theme.urlString,
      );

  /// PsWaveImg
  Future<List<int>> getPsWaveImageData(DateTime dateTime) async =>
      _client.getPsWaveImageData(
        date: dateFormat.format(dateTime),
        dateTime: dateTimeFormat.format(dateTime),
      );

  /// RealtimeImg
  Future<List<int>> getRealtimeImageData(
    RealtimeDataType type,
    RealtimeLayer layer,
    DateTime dateTime,
  ) async =>
      _client.getRealtimeImageData(
        type: type.urlString,
        layer: layer.urlString,
        date: dateFormat.format(dateTime),
        dateTime: dateTimeFormat.format(dateTime),
      );

  static DateFormat get dateFormat => DateFormat('yyyyMMdd');
  static DateFormat get dateTimeFormat => DateFormat('yyyyMMddHHmmss');
}
