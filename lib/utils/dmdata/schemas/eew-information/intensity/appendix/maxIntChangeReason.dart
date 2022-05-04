enum MaxIntChangeReason {
  f0,
  f1,
  f2,
  f3,
  f4,
  f9,
  undefined,
}

extension ToMaxIntChangeReason on int {
  MaxIntChangeReason get toMaxIntChangeReason {
    switch (this) {
      case 0:
        return MaxIntChangeReason.f0;
      case 1:
        return MaxIntChangeReason.f1;
      case 2:
        return MaxIntChangeReason.f2;
      case 3:
        return MaxIntChangeReason.f3;
      case 4:
        return MaxIntChangeReason.f4;
      default:
        return MaxIntChangeReason.undefined;
    }
  }
}

extension MaxIntChangeReasonToStr on MaxIntChangeReason {
  String get description {
    switch (this) {
      case MaxIntChangeReason.f0:
        return '変化なし';
      case MaxIntChangeReason.f1:
        return '主としてＭが変化したため(1.0以上)';
      case MaxIntChangeReason.f2:
        return '主として震央位置が変化したため(10.0km以上)';
      case MaxIntChangeReason.f3:
        return 'M及び震央位置が変化したため(1と2の複合条件)';
      case MaxIntChangeReason.f4:
        return '震源の深さが変化したため(上記のいずれにもあてはまらず、30.0km以上の変化)';
      case MaxIntChangeReason.f9:
        return 'PLUM法による予測により変化したため';
      case MaxIntChangeReason.undefined:
        return '不明';
    }
  }
}
