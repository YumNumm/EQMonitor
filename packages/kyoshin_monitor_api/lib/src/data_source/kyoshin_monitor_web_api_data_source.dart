import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:kyoshin_monitor_api/src/api/kyoshin_monitor_web_api_client.dart';
import 'package:kyoshin_monitor_api/src/model/web_api/data_time.dart';
import 'package:kyoshin_monitor_api/src/model/web_api/maintenance_message.dart';

class KyoshinMonitorWebApiDataSource {
  KyoshinMonitorWebApiDataSource({
    required KyoshinMonitorWebApiClient client,
  }) : _client = client;

  final KyoshinMonitorWebApiClient _client;

  /// データ時間
  Future<DataTime> getLatestDataTime() async =>
      _client.getLatestDataTime();

  /// メンテナンスメッセージ
  Future<MaintenanceMessage>
  getMaintenanceMessage() async =>
      _client.getMaintenanceMessage();

  /// ベース画像
  Future<List<int>> getBaseMapImageData(
    BaseMapTheme theme,
  ) async =>
      _client.getBaseMapImageData(theme: theme.urlString);

  /// スケール
  Future<List<int>> getScaleImageData(
    RealtimeDataType type,
    RealtimeLayer layer,
    BaseMapTheme theme,
  ) async => _client.getScaleImageData(
    type: type.urlString,
    layer: layer.urlString,
    theme: theme.urlString,
  );

  /// PsWaveImg
  Future<List<int>> getPsWaveImageData(
    DateTime dateTime,
  ) async => _client.getPsWaveImageData(
    date: dateFormat.format(dateTime),
    dateTime: dateTimeFormat.format(dateTime),
  );

  /// RealtimeImg
  Future<List<int>> getRealtimeImageData({
    required DateTime dateTime,
    required RealtimeLayer layer,
    required RealtimeDataType type,
  }) async {
    assert(
      !type.isLpgm,
      'LPGM系列の場合はLpgmKyoshinMonitorWebApiDataSourceを使用してください',
    );
    return _client.getRealtimeImageData(
      type: type.urlString,
      layer: layer.urlString,
      date: dateFormat.format(dateTime),
      dateTime: dateTimeFormat.format(dateTime),
    );
  }

  /// 予想震度
  Future<List<int>> getEstShindoImageData(
    DateTime dateTime,
  ) async => _client.getEstShindoImageData(
    date: dateFormat.format(dateTime),
    dateTime: dateTimeFormat.format(dateTime),
  );

  static DateFormat get dateFormat =>
      DateFormat('yyyyMMdd');
  static DateFormat get dateTimeFormat =>
      DateFormat('yyyyMMddHHmmss');
}

/// リアルタイム画像の種類
@JsonEnum(valueField: 'urlString')
enum RealtimeDataType {
  /// 震度
  shindo('震度', 'jma', false),

  /// 最大加速度
  pga('最大加速度', 'acmap', false),

  /// 最大速度
  pgv('最大速度', 'vcmap', false),

  /// 最大変位
  pgd('最大変位', 'dcmap', false),

  /// 速度応答0.125Hz
  response0125Hz('速度応答0.125Hz', 'rsp0125', false),

  /// 速度応答0.25Hz
  response025Hz('速度応答0.25Hz', 'rsp0250', false),

  /// 速度応答0.5Hz
  response05Hz('速度応答0.5Hz', 'rsp0500', false),

  /// 速度応答1Hz
  response1Hz('速度応答1Hz', 'rsp1000', false),

  /// 速度応答2Hz
  response2Hz('速度応答2Hz', 'rsp2000', false),

  /// 速度応答4Hz
  response4Hz('速度応答4Hz', 'rsp4000', false),

  /// 長周期地震動階級
  /// Lpgm系列でのみ利用可
  abrspmx('長周期地震動階級', 'abrspmx', true),

  /// 階級データ(周期1秒台)
  /// Lpgm系列でのみ利用可
  abrsp1s('階級データ(周期1秒台)', 'abrsp1s', true),

  /// 階級データ(周期2秒台)
  /// Lpgm系列でのみ利用可
  abrsp2s('階級データ(周期2秒台)', 'abrsp2s', true),

  /// 階級データ(周期3秒台)
  /// Lpgm系列でのみ利用可
  abrsp3s('階級データ(周期3秒台)', 'abrsp3s', true),

  /// 階級データ(周期4秒台)
  /// Lpgm系列でのみ利用可
  abrsp4s('階級データ(周期4秒台)', 'abrsp4s', true),

  /// 階級データ(周期5秒台)
  /// Lpgm系列でのみ利用可
  abrsp5s('階級データ(周期5秒台)', 'abrsp5s', true),

  /// 階級データ(周期6秒台)
  /// Lpgm系列でのみ利用可
  abrsp6s('階級データ(周期6秒台)', 'abrsp6s', true),

  /// 階級データ(周期7秒台)
  /// Lpgm系列でのみ利用可
  abrsp7s('階級データ(周期7秒台)', 'abrsp7s', true);

  // ignore: avoid_positional_boolean_parameters
  const RealtimeDataType(
    this.displayName,
    this.urlString,
    this.isLpgm,
  );

  /// 表示名
  final String displayName;

  /// URLに使用する文字列
  final String urlString;

  /// LPGM系列の場合はtrue
  final bool isLpgm;
}

enum RealtimeLayer {
  /// 地上
  surface('地上', 's'),

  /// 地下
  underground('地下', 'b');

  const RealtimeLayer(this.displayName, this.urlString);

  /// 表示名
  final String displayName;

  /// URLに使用する文字列
  final String urlString;
}

enum BaseMapTheme {
  white('白', 'w'),
  gray('グレー', 'b');

  const BaseMapTheme(this.displayName, this.urlString);

  final String displayName;
  final String urlString;
}
