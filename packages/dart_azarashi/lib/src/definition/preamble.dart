/// QZSS DCR Preamble definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-1.
enum QzssDcrPreamble {
  a(0x15, 'A'),
  b(0x1A, 'B'),
  c(0x26, 'C'),
  d(0x31, 'D');

  const QzssDcrPreamble(this.code, this.symbol);

  final int code;
  final String symbol;

  static QzssDcrPreamble fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
