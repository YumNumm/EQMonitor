enum MaxIntChange {
  f0,
  f1,
  f2,
  undefined,
}

extension ToMaxIntChange on int {
  MaxIntChange get toMaxIntChange {
    switch (this) {
      case 0:
        return MaxIntChange.f0;
      case 1:
        return MaxIntChange.f1;
      case 2:
        return MaxIntChange.f2;
      default:
        return MaxIntChange.undefined;
    }
  }
}

extension MaxIntChangeToStr on MaxIntChange {
  String get description {
    switch (this) {
      case MaxIntChange.f0:
        return 'ほとんど変化なし';
      case MaxIntChange.f1:
        return '最大予測震度が1.0以上大きくなった';
      case MaxIntChange.f2:
        return '最大予測震度が1.0以上小さくなった';
      case MaxIntChange.undefined:
        return '不明';
    }
  }
}
