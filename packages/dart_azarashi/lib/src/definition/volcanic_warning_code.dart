/// JMA Volcanic Warning Code.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-35.
enum JmaVolcanicWarningCode {
  level1(11, 'レベル1(活火山であることに留意)'),
  level2(12, 'レベル2(火口周辺規制)'),
  level3(13, 'レベル3(入山規制)'),
  level4(14, 'レベル4(高齢者等避難)'),
  level5(15, 'レベル5(避難)'),
  activeVolcano(21, '活火山であることに留意'),
  craterVicinity(22, '火口周辺危険'),
  mountainEntry(23, '入山危険'),
  foothillsWarning(24, '山麓厳重警戒'),
  residentialAreaWarning(25, '居住地域厳重警戒'),
  activeSubmarineVolcano(35, '活火山であることに留意(海底火山)'),
  surroundingSeaWarning(36, '周辺海域警戒'),
  eruption(52, '噴火'),
  possibleEruption(62, '噴火したもよう'),
  other(127, 'その他の防災気象情報要素');

  const JmaVolcanicWarningCode(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the volcanic warning code for the given code.
  ///
  /// Returns null if not found.
  static JmaVolcanicWarningCode? fromCode(int code) =>
      JmaVolcanicWarningCode.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '防災気象情報要素(コード番号：$code)';
}
