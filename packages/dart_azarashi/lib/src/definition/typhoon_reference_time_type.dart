/// JMA Typhoon Reference Time Type.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-50.
enum JmaTyphoonReferenceTimeType {
  analysis(1, '実況'),
  estimation(2, '推定'),
  forecast(3, '予報');

  const JmaTyphoonReferenceTimeType(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the typhoon reference time type for the given code.
  ///
  /// Returns null if not found.
  static JmaTyphoonReferenceTimeType? fromCode(int code) =>
      JmaTyphoonReferenceTimeType.values
          .where((e) => e.code == code)
          .firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '基点時刻分類(コード番号：$code)';
}
