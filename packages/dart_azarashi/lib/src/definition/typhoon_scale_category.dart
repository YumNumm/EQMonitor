/// JMA Typhoon Scale Category.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-51.
enum JmaTyphoonScaleCategory {
  none(0, 'なし'),
  large(1, '大型'),
  veryLarge(2, '超大型'),
  other(15, 'その他の大きさ階級分類');

  new(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the typhoon scale category for the given code.
  ///
  /// Returns null if not found.
  static JmaTyphoonScaleCategory? fromCode(int code) =>
      JmaTyphoonScaleCategory.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '大きさ階級分類(コード番号：$code)';
}
