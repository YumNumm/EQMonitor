/// JMA Information Type definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-5.
enum JmaInformationType {
  issue(0, '発表', 'Issue'),
  correction(1, '訂正', 'Correction'),
  cancellation(2, '取消', 'Cancellation')
  ;

  const JmaInformationType(this.code, this.nameJa, this.nameEn);

  final int code;
  final String nameJa;
  final String nameEn;

  static JmaInformationType fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
