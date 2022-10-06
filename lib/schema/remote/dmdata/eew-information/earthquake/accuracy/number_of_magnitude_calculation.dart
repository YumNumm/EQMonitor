enum NumberOfMagnitudeCalculation {
  unknown('不明', 0),
  f1('1点、P波/S波レベル越え、または「仮定震源要素」の場合', 1),
  f2('2点', 2),
  f3('3点', 3),
  f4('4点', 4),
  f5('5点以上', 5);

  const NumberOfMagnitudeCalculation(this.description, this.code);

  final String description;
  final int code;
}
