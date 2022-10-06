/// ## リアルタイム画像の種類
// ignore_for_file: constant_identifier_names

enum RealtimeDataType {
  /// 震度
  Shindo('jma'),

  /// 最大加速度
  Pga('acmap'),

  /// 最大速度
  Pgv('vcmap'),

  /// 最大変位
  Pgd('dcmap'),

  /// 速度応答0.125Hz
  Response_0_125Hz('rsp0125'),

  /// 速度応答0.25Hz
  Response_0_25Hz('rsp0250'),

  /// 速度応答0.5Hz
  Response_0_5Hz('rsp0500'),

  /// 速度応答1Hz
  Response_1Hz('rsp1000'),

  /// 速度応答2Hz
  Response_2Hz('rsp2000'),

  /// 速度応答4Hz
  Response_4Hz('rsp4000'),

  /// 長周期地震動階級
  /// Lpgm系列でのみ利用可
  Abrspmx('abrspmx'),

  /// 階級データ(周期1秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_1s('abrsp1s'),

  /// 階級データ(周期2秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_2s('abrsp2s'),

  /// 階級データ(周期3秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_3s('abrsp3s'),

  /// 階級データ(周期4秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_4s('abrsp4s'),

  /// 階級データ(周期5秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_5s('abrsp5s'),

  /// 階級データ(周期6秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_6s('abrsp6s'),

  /// 階級データ(周期7秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_7s('abrsp7s');

  const RealtimeDataType(this.urlString);
  final String urlString;
}
