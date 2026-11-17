/// JMA Weather Warning State.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-42.
enum JmaWeatherWarningState(final int code, final String nameJa) {
  issued(1, '発表'),
  cancelled(2, '解除');

  /// Returns the weather warning state for the given code.
  ///
  /// Returns null if not found.
  static JmaWeatherWarningState? fromCode(int code) =>
      JmaWeatherWarningState.values.where((e) => e.code == code).firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) => '発表状況(コード番号：$code)';
}
