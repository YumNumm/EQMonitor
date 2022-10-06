enum MaxIntChange {
  f0(0, 'ほとんど変化なし'),
  f1(1, '最大予測震度が1.0以上大きくなった'),
  f2(2, '最大予測震度が1.0以上小さくなった'),
  unknown(-1, '不明');

  const MaxIntChange(this.code, this.description);

  final int code;
  final String description;
}
