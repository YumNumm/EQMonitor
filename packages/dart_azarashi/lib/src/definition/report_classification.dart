/// JMA Report Classification definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-4.
enum JmaReportClassification {
  normal(0, '通常', 'Normal'),
  priority(1, '優先', 'Priority'),
  maximumPriority(2, '最優先', 'Maximum Priority'),
  // 3-6: Unused
  trainingTest(7, '訓練/試験', 'Training/Test')
  ;

  const JmaReportClassification(this.code, this.nameJa, this.nameEn);

  final int code;
  final String nameJa;
  final String nameEn;

  static JmaReportClassification fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
