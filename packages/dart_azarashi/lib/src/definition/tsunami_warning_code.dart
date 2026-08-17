/// JMA Tsunami Warning Code definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-19.
enum JmaTsunamiWarningCode {
  noTsunami(1, '津波なし'),
  warningLifted(2, '警報解除'),
  tsunamiWarning(3, '津波警報'),
  majorTsunamiWarning(4, '大津波警報'),
  majorTsunamiWarningIssued(5, '大津波警報：発表'),
  other(15, 'その他の警報');

  new(this.code, this.name);

  final int code;
  final String name;

  static JmaTsunamiWarningCode fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
