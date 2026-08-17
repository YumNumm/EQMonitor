/// JMA Marine Warning Code.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-54.
enum JmaMarineWarningCode {
  warningCancelled(0, '海上警報解除'),
  icingWarning(10, '海上着氷警報'),
  fogWarning(11, '海上濃霧警報'),
  swellWarning(12, '海上うねり警報'),
  windWarning(20, '海上風警報'),
  galeWarning(21, '海上強風警報'),
  stormWarning(22, '海上暴風警報'),
  typhoonWarning(23, '海上台風警報'),
  other(31, 'その他の警報等情報要素 海上警報');

  new(this.code, this.nameJa);

  final int code;
  final String nameJa;

  /// Returns the marine warning code for the given code.
  ///
  /// Returns null if not found.
  static JmaMarineWarningCode? fromCode(int code) =>
      JmaMarineWarningCode.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '警報等情報要素_海上警報(コード番号：$code)';
}
