// ignore_for_file: constant_identifier_names

enum DmDataWebSocketType {
  start,
  ping,
  pong,
  data,
  error,
}

/// データ種別コード
enum DmDssTelegramDataType {
  /// 緊急地震速報テスト
  VXSE42,

  /// 緊急地震速報（地震動予報）
  VXSE45,

  /// 緊急地震速報（予報）
  VXSE44,

  /// 地震・津波に関するお知らせ
  VZSE40,

  /// 津波警報・注意報・予報
  VTSE41,

  /// 津波情報
  VTSE51,

  /// 沖合の津波情報
  VTSE52,

  /// 国際津波関連情報(国内向け)
  WEPA60,

  /// 震度速報(震度3以上の地域を90秒程度で第1報を発表)
  VXSE51,

  /// 震源に関する情報
  VXSE52,

  /// 震源・震度に関する情報
  VXSE53,

  /// 地震の活動状況等に関する情報
  VXSE56,

  /// 地震回数に関する情報
  VXSE60,

  /// 顕著な地震の震源要素更新のお知らせ
  VXSE61,

  /// 長周期地震動に関する観測情報
  VXSE62,

  /// 南海トラフ地震臨時情報
  VYSE50,

  /// 南海トラフ地震関連解説情報(定例外)
  VYSE51,

  /// 南海トラフ地震関連解説情報(定例)
  VYSE52,
}

extension on DmDssTelegramDataType {
  static final toNameStringMap = <DmDssTelegramDataType, String>{
    DmDssTelegramDataType.VZSE40: '地震・津波に関するお知らせ',
    DmDssTelegramDataType.VTSE41: '津波警報・注意報・予報',
    DmDssTelegramDataType.VTSE51: '津波情報',
    DmDssTelegramDataType.VTSE52: '沖合の津波情報',
    DmDssTelegramDataType.WEPA60: '国際津波関連情報(国内向け)',
    DmDssTelegramDataType.VXSE51: '震度速報',
    DmDssTelegramDataType.VXSE52: '震源に関する情報',
    DmDssTelegramDataType.VXSE53: '震源・震度に関する情報',
    DmDssTelegramDataType.VXSE56: '地震の活動状況等に関する情報',
    DmDssTelegramDataType.VXSE60: '地震回数に関する情報',
    DmDssTelegramDataType.VXSE61: '顕著な地震の震源要素更新のお知らせ',
    DmDssTelegramDataType.VXSE62: '長周期地震動に関する観測情報',
    DmDssTelegramDataType.VYSE50: '南海トラフ地震臨時情報',
    DmDssTelegramDataType.VYSE51: '南海トラフ地震関連解説情報(定例外)',
    DmDssTelegramDataType.VYSE52: '南海トラフ地震関連解説情報(定例)',
  };

  String get ToName {
    if (toNameStringMap[this] == null) {
      throw Exception('不明なDataTypeが指定されています。');
    } else {
      return toNameStringMap[this]!;
    }
  }
}
