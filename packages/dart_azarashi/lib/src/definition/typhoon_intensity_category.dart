/// JMA Typhoon Intensity Category.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-52.
enum JmaTyphoonIntensityCategory {
  none(0, 'なし'),
  strong(1, '強い'),
  veryStrong(2, '非常に強い'),
  violent(3, '猛烈な'),
  other(15, 'その他の強さ階級分類')
  ;

  const JmaTyphoonIntensityCategory(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the typhoon intensity category for the given code.
  ///
  /// Returns null if not found.
  static JmaTyphoonIntensityCategory? fromCode(int code) =>
      JmaTyphoonIntensityCategory.values
          .where((e) => e.code == code)
          .firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '強さ階級分類(コード番号：$code)';
}
