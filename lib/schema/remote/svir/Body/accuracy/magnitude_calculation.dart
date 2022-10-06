/// マグニチュードの精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
enum MagnitudeCalculation {
  f0,
  f2,
  f3,
  f4,
  f5,
  f6,
  f8,
  undefined,
}

extension magnitudeCalculationToString on MagnitudeCalculation {
  String get description {
    switch (this) {
      case MagnitudeCalculation.f0:
        return '不明';
      case MagnitudeCalculation.f2:
        return '防災科研システム(Hi-netデータ)';
      case MagnitudeCalculation.f3:
        return 'P相/全相混在';
      case MagnitudeCalculation.f4:
        return 'P相';
      case MagnitudeCalculation.f5:
        return '全点全相';
      case MagnitudeCalculation.f6:
        return 'EPOS';
      case MagnitudeCalculation.f8:
        return 'P波/S波レベル越え、または「仮定震源要素」の場合';
      case MagnitudeCalculation.undefined:
        return '不明';
    }
  }
}

extension intToMagnitudeCalculation on int {
  MagnitudeCalculation get getMagnitudeCalculation {
    switch (this) {
      case 0:
        return MagnitudeCalculation.f0;
      case 2:
        return MagnitudeCalculation.f2;
      case 3:
        return MagnitudeCalculation.f3;
      case 4:
        return MagnitudeCalculation.f4;
      case 5:
        return MagnitudeCalculation.f5;
      case 6:
        return MagnitudeCalculation.f6;
      case 8:
        return MagnitudeCalculation.f8;
      default:
        return MagnitudeCalculation.undefined;
    }
  }
}
