/// JMA Northwest Pacific Tsunami Height.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-27.
enum JmaNorthwestPacificTsunamiHeight {
  from03mTo1m(1, '0.3m~1m'),
  from1mTo3m(2, '1m~3m'),
  from3mTo5m(3, '3m~5m'),
  from5mTo10m(4, '5m~10m'),
  moreThan10m(508, 'More than 10m'),
  huge(509, 'Huge'),
  high(510, 'High'),
  unknown(511, 'Unknown');

  new(this.code, this.descriptionEn);

  final int code;
  final String descriptionEn;

  /// Returns the tsunami height for the given code.
  ///
  /// Returns null if not found.
  static JmaNorthwestPacificTsunamiHeight? fromCode(int code) =>
      JmaNorthwestPacificTsunamiHeight.values
          .where((e) => e.code == code)
          .firstOrNull;

  /// Returns a description for undefined codes.
  static String undefinedDescription(int code) =>
      'Undefined Tsunami Height (Code: $code)';
}
