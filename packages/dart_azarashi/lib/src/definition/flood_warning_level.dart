/// JMA Flood Warning Level.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-46.
enum JmaFloodWarningLevel {
  warningCancelled(1, '警報解除'),
  floodWarning(2, '氾濫警戒情報'),
  floodDanger(3, '氾濫危険情報'),
  floodOccurred(4, '氾濫発生情報'),
  other(15, 'その他の警戒レベル');

  new(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the flood warning level for the given code.
  ///
  /// Returns null if not found.
  static JmaFloodWarningLevel? fromCode(int code) =>
      JmaFloodWarningLevel.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '警戒レベル(コード番号：$code)';
}
