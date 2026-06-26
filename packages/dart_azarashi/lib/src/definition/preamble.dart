/// QZSS DCR Preamble definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-1.
/// Preamble is 8 bits.
enum QzssDcrPreamble {
  a(0x53, 'A'), // 01010011
  b(0x9A, 'B'), // 10011010
  c(0xC6, 'C'); // 11000110

  const QzssDcrPreamble(this.code, this.symbol);

  final int code;
  final String symbol;

  static QzssDcrPreamble fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
