enum MaxLpgmIntChange {
  f0(0, 'ほとんど変化なし'),
  f1(1, '最大予測長周期地震動階級が1以上大きくなった'),
  f2(2, '最大予測長周期地震動階級が1以上小さくなった'),
  unknown(-1, '不明');

  const MaxLpgmIntChange(this.code, this.description);

  final int code;
  final String description;
}
