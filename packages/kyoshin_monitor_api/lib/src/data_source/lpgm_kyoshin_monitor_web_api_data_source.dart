import 'package:intl/intl.dart';
import 'package:kyoshin_monitor_api/src/api/lpgm_kyoshin_monitor_web_api_client.dart';
import 'package:kyoshin_monitor_api/src/data_source/kyoshin_monitor_web_api_data_source.dart';

class LpgmKyoshinMonitorWebApiDataSource {
  new({
    required LpgmKyoshinMonitorWebApiClient client,
  }) : _client = client;

  final LpgmKyoshinMonitorWebApiClient _client;

  /// ベース画像
  Future<List<int>> getBaseMapImageData(BaseMapTheme theme) =>
      _client.getBaseMapImageData(theme: theme.urlString);

  /// スケール
  Future<List<int>> getScaleImageData(
    RealtimeDataType type,
    RealtimeLayer layer,
    BaseMapTheme theme,
  ) => _client.getScaleImageData(
    type: type.urlString,
    layer: layer.urlString,
    theme: theme.urlString,
  );

  /// PsWaveImg
  Future<List<int>> getPsWaveImageData(DateTime dateTime) =>
      _client.getPsWaveImageData(
        date: dateFormat.format(dateTime),
        dateTime: dateTimeFormat.format(dateTime),
      );

  /// RealtimeImg
  Future<List<int>> getRealtimeImageData({
    required RealtimeDataType type,
    required RealtimeLayer layer,
    required DateTime dateTime,
  }) {
    final date = dateFormat.format(dateTime);
    final formattedDateTime = dateTimeFormat.format(dateTime);
    if (type.isLpgm) {
      return _client.getLpgmRealtimeImageData(
        type: type.urlString,
        date: date,
        dateTime: formattedDateTime,
      );
    }
    return _client.getKyoshinRealtimeImageData(
      type: type.urlString,
      layer: layer.urlString,
      date: date,
      dateTime: formattedDateTime,
    );
  }

  static DateFormat get dateFormat => DateFormat('yyyyMMdd');
  static DateFormat get dateTimeFormat => DateFormat('yyyyMMddHHmmss');
}
