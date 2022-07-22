/// マグニチュードの精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
enum MagnitudeCalculation {
  unknown('不明', 0),
  f2('防災科研システム(Hi-netデータ)', 2),
  f3('P相/全相混在', 3),
  f4('P相', 4),
  f5('全点全相', 5),
  f6('EPOS', 6),
  f8('P波/S波レベル越え、または「仮定震源要素」の場合', 8);

  const MagnitudeCalculation(this.description, this.code);

  final String description;
  final int code;
}
