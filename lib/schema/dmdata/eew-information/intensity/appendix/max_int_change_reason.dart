enum MaxIntChangeReason {
  f0(0, '変化なし'),
  f1(1, '主としてＭが変化したため(1.0以上)'),
  f2(2, '主として震央位置が変化したため(10.0km以上)'),
  f3(3, 'M及び震央位置が変化したため(1と2の複合条件)'),
  f4(4, '震源の深さが変化したため(上記のいずれにもあてはまらず、30.0km以上の変化)'),
  f9(9, 'PLUM法による予測により変化したため'),
  unknown(-1, '不明');

  const MaxIntChangeReason(this.code, this.description);
  final int code;
  final String description;
}
