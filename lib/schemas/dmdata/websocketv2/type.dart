enum DmDataWebSocketType {
  start,
  ping,
  pong,
  data,
  error,
}

extension on String {
  DmDataWebSocketType toWebSocketTypeEnum() {
    return DmDataWebSocketType.values.firstWhere((e) => e.name == this);
  }
}

/// データ種別コード
enum DmDssEarthQuakeDataType {
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

extension on String {
  DmDssEarthQuakeDataType ToDmDssEarthQuakeDataType() {
    return DmDssEarthQuakeDataType.values.firstWhere((e) => e.name == this);
  }
}

extension on DmDssEarthQuakeDataType {
  static final toNameStringMap = <DmDssEarthQuakeDataType, String>{
    DmDssEarthQuakeDataType.VZSE40: '地震・津波に関するお知らせ',
    DmDssEarthQuakeDataType.VTSE41: '津波警報・注意報・予報',
    DmDssEarthQuakeDataType.VTSE51: '津波情報',
    DmDssEarthQuakeDataType.VTSE52: '沖合の津波情報',
    DmDssEarthQuakeDataType.WEPA60: '国際津波関連情報(国内向け)',
    DmDssEarthQuakeDataType.VXSE51: '震度速報',
    DmDssEarthQuakeDataType.VXSE52: '震源に関する情報',
    DmDssEarthQuakeDataType.VXSE53: '震源・震度に関する情報',
    DmDssEarthQuakeDataType.VXSE56: '地震の活動状況等に関する情報',
    DmDssEarthQuakeDataType.VXSE60: '地震回数に関する情報',
    DmDssEarthQuakeDataType.VXSE61: '顕著な地震の震源要素更新のお知らせ',
    DmDssEarthQuakeDataType.VXSE62: '長周期地震動に関する観測情報',
    DmDssEarthQuakeDataType.VYSE50: '南海トラフ地震臨時情報',
    DmDssEarthQuakeDataType.VYSE51: '南海トラフ地震関連解説情報(定例外)',
    DmDssEarthQuakeDataType.VYSE52: '南海トラフ地震関連解説情報(定例)',
  };

  String get ToName {
    if (toNameStringMap[this] == null) {
      throw Exception('不明なDataTypeが指定されています。');
    } else {
      return toNameStringMap[this]!;
    }
  }
}
