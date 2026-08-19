/// JMA Tsunami Height definitions.
///
/// See IS-QZSS-DCR-015 Table 4.1.2-20.
enum JmaTsunamiHeight {
  lessThan02m(1, '0.2m未満'),
  height1m(2, '1m'),
  height3m(3, '3m'),
  height5m(4, '5m'),
  height10m(5, '10m'),
  moreThan10m(6, '10m超'),
  unknown(14, '不明'),
  other(15, 'その他の津波の高さ');

  new(this.code, this.name);

  final int code;
  final String name;

  static JmaTsunamiHeight fromCode(int code) =>
      values.firstWhere((e) => e.code == code);
}
