/// ## リアルタイム画像の種類
library;

enum RealtimeDataType {
  /// 震度
  shindo('jma'),

  /// 最大加速度
  pga('acmap'),

  /// 最大速度
  pgv('vcmap'),

  /// 最大変位
  pgd('dcmap'),

  /// 速度応答0.125Hz
  response_0_125Hz('rsp0125'),

  /// 速度応答0.25Hz
  response_0_25Hz('rsp0250'),

  /// 速度応答0.5Hz
  response_0_5Hz('rsp0500'),

  /// 速度応答1Hz
  response_1Hz('rsp1000'),

  /// 速度応答2Hz
  response_2Hz('rsp2000'),

  /// 速度応答4Hz
  response_4Hz('rsp4000'),

  /// 長周期地震動階級
  /// Lpgm系列でのみ利用可
  abrspmx('abrspmx'),

  /// 階級データ(周期1秒台)
  /// Lpgm系列でのみ利用可
  abrsp_1s('abrsp1s'),

  /// 階級データ(周期2秒台)
  /// Lpgm系列でのみ利用可
  abrsp_2s('abrsp2s'),

  /// 階級データ(周期3秒台)
  /// Lpgm系列でのみ利用可
  abrsp_3s('abrsp3s'),

  /// 階級データ(周期4秒台)
  /// Lpgm系列でのみ利用可
  abrsp_4s('abrsp4s'),

  /// 階級データ(周期5秒台)
  /// Lpgm系列でのみ利用可
  abrsp_5s('abrsp5s'),

  /// 階級データ(周期6秒台)
  /// Lpgm系列でのみ利用可
  abrsp_6s('abrsp6s'),

  /// 階級データ(周期7秒台)
  /// Lpgm系列でのみ利用可
  abrsp_7s('abrsp7s');

  const RealtimeDataType(this.url);
  final String url;
}
