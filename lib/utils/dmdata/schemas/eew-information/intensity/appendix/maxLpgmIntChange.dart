enum MaxLpgmIntChange {
  f0,
  f1,
  f2,
  undefined,
}

extension ToMaxLpgmIntChange on int {
  MaxLpgmIntChange get toMaxLpgmIntChange {
    switch (this) {
      case 0:
        return MaxLpgmIntChange.f0;
      case 1:
        return MaxLpgmIntChange.f1;
      case 2:
        return MaxLpgmIntChange.f2;
      default:
        return MaxLpgmIntChange.undefined;
    }
  }
}

extension MaxLpgmIntChangeToStr on MaxLpgmIntChange {
  String get description {
    switch (this) {
      case MaxLpgmIntChange.f0:
        return 'ほとんど変化なし';
      case MaxLpgmIntChange.f1:
        return '最大予測長周期地震動階級が1以上大きくなった';
      case MaxLpgmIntChange.f2:
        return '最大予測長周期地震動階級が1以上小さくなった';
      case MaxLpgmIntChange.undefined:
        return '不明';
    }
  }
}
