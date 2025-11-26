/// JMA Ash Fall Warning Code.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-39.
enum JmaAshFallWarningCode {
  lightAshFall(1, '少量の降灰'),
  moderateAshFall(2, 'やや多量の降灰'),
  heavyAshFall(3, '多量の降灰'),
  smallLapilliFall(4, '小さな噴石の落下'),
  other(7, 'その他の防災気象情報要素2');

  const JmaAshFallWarningCode(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the ash fall warning code for the given code.
  ///
  /// Returns null if not found.
  static JmaAshFallWarningCode? fromCode(int code) =>
      JmaAshFallWarningCode.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '防災気象情報要素2(コード番号：$code)';
}
