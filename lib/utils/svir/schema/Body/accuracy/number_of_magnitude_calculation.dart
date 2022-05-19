enum NumberOfMagnitudeCalculation {
  undefined,
  f1,
  f2,
  f3,
  f4,
  f5,
}

extension NumberOfMagnitudeCalculationToString on NumberOfMagnitudeCalculation {
  String get description {
    switch (this) {
      case NumberOfMagnitudeCalculation.undefined:
        return '不明';
      case NumberOfMagnitudeCalculation.f1:
        return '1点、P波/S波レベル越え、または「仮定震源要素」の場合';
      case NumberOfMagnitudeCalculation.f2:
        return '2点';
      case NumberOfMagnitudeCalculation.f3:
        return '3点';
      case NumberOfMagnitudeCalculation.f4:
        return '4点';
      case NumberOfMagnitudeCalculation.f5:
        return '5点以上';
    }
  }
}

extension IntToNumberOfMagnitudeCalculation on int {
  NumberOfMagnitudeCalculation get getNumberOfMagnitudeCalculation {
    switch (this) {
      case 1:
        return NumberOfMagnitudeCalculation.f1;
      case 2:
        return NumberOfMagnitudeCalculation.f2;
      case 3:
        return NumberOfMagnitudeCalculation.f3;
      case 4:
        return NumberOfMagnitudeCalculation.f4;
      case 5:
        return NumberOfMagnitudeCalculation.f5;
      default:
        return NumberOfMagnitudeCalculation.undefined;
    }
  }
}
