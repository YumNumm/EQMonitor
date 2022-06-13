/// ## リアルタイム画像の種類
// ignore_for_file: constant_identifier_names

enum RealtimeDataType {
  /// 震度
  Shindo,

  /// 最大加速度
  Pga,

  /// 最大速度
  Pgv,

  /// 最大変位
  Pgd,

  /// 速度応答0.125Hz
  Response_0_125Hz,

  /// 速度応答0.25Hz
  Response_0_25Hz,

  /// 速度応答0.5Hz
  Response_0_5Hz,

  /// 速度応答1Hz
  Response_1Hz,

  /// 速度応答2Hz
  Response_2Hz,

  /// 速度応答4Hz
  Response_4Hz,

  /// 長周期地震動階級
  /// Lpgm系列でのみ利用可
  Abrspmx,

  /// 階級データ(周期1秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_1s,

  /// 階級データ(周期2秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_2s,

  /// 階級データ(周期3秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_3s,

  /// 階級データ(周期4秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_4s,

  /// 階級データ(周期5秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_5s,

  /// 階級データ(周期6秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_6s,

  /// 階級データ(周期7秒台)
  /// Lpgm系列でのみ利用可
  Abrsp_7s,
}

extension RealtimeDataTypeExt on RealtimeDataType {
  static final toUrlStringMap = <RealtimeDataType, String>{
    RealtimeDataType.Shindo: 'jma',
    RealtimeDataType.Pga: 'acmap',
    RealtimeDataType.Pgv: 'vcmap',
    RealtimeDataType.Pgd: 'dcmap',
    RealtimeDataType.Response_0_125Hz: 'rsp0125',
    RealtimeDataType.Response_0_25Hz: 'rsp0250',
    RealtimeDataType.Response_0_5Hz: 'rsp0500',
    RealtimeDataType.Response_1Hz: 'rsp1000',
    RealtimeDataType.Response_2Hz: 'rsp2000',
    RealtimeDataType.Response_4Hz: 'rsp4000',
    RealtimeDataType.Abrspmx: 'abrspmx',
    RealtimeDataType.Abrsp_1s: 'abrsp1s',
    RealtimeDataType.Abrsp_2s: 'abrsp2s',
    RealtimeDataType.Abrsp_3s: 'abrsp3s',
    RealtimeDataType.Abrsp_4s: 'abrsp4s',
    RealtimeDataType.Abrsp_5s: 'abrsp5s',
    RealtimeDataType.Abrsp_6s: 'abrsp6s',
    RealtimeDataType.Abrsp_7s: 'abrsp7s',
  };

  String get ToUrlString {
    if (toUrlStringMap[this] == null) {
      throw Exception('URLを生成できない`RealtimeDataType`が指定されています。');
    } else {
      return toUrlStringMap[this]!;
    }
  }
}
