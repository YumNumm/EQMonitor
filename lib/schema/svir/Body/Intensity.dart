class SvirBodyEQIntensity {
  SvirBodyEQIntensity({
    required this.maxInt,
    required this.textInt,
    required this.intnum,
  });
  SvirBodyEQIntensity.fromJson(Map<String, dynamic> j)
      : maxInt = j['MaxInt'].toString(),
        textInt = j['TextInt'].toString(),
        intnum = StrToint(j['MaxInt'].toString());

  /// 最大予測震度
  final String maxInt;

  /// テキストの予測最大震度
  final String textInt;

  // 最大震度(数値化)
  final int intnum;
}

int StrToint(String maxInt) {
  switch (maxInt) {
    case '0':
      return 0;
    case '1':
      return 1;
    case '2':
      return 2;
    case '3':
      return 3;
    case '4':
      return 4;
    case '5-':
      return 5;
    case '5+':
      return 6;
    case '6-':
      return 7;
    case '6+':
      return 8;
    case '7':
      return 9;

    default:
      return 0; // 不明時
  }
}
