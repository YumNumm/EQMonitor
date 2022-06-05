/// ## 7.4.7.2.depth
/// 深さの精度値を記載します。
/// `0`から`9`までの整数値を使用し、精度を表現します。
enum DepthCalculation {
  undefined,
  f1,
  f2,
  f3,
  f4,
  f5,
  f6,
  f7,
  f8,
}

extension depthCalculationToString on DepthCalculation {
  String get description {
    switch (this) {
      case DepthCalculation.undefined:
        return '不明';
      case DepthCalculation.f1:
        return 'P波/S波レベル越え、IPF法(1点)、または「仮定震源要素」の場合';
      case DepthCalculation.f2:
        return 'IPF法(2点)';
      case DepthCalculation.f3:
        return 'IPF法(3点/4点)';
      case DepthCalculation.f4:
        return 'IPF法(5点以上)';
      case DepthCalculation.f5:
        return '防災科研システム(4点以下、または精度情報なし)';
      case DepthCalculation.f6:
        return '防災科研システム(5点以上)（Hi-netデータ）';
      case DepthCalculation.f7:
        return 'EPOS(海域[観測網外])';
      case DepthCalculation.f8:
        return 'EPOS(内陸[観測網内])';
    }
  }
}

extension intToDepthCalculation on int {
  DepthCalculation get getDepthCalculation {
    switch (this) {
      case 0:
        return DepthCalculation.undefined;
      case 1:
        return DepthCalculation.f1;
      case 2:
        return DepthCalculation.f2;
      case 3:
        return DepthCalculation.f3;
      case 4:
        return DepthCalculation.f4;
      case 5:
        return DepthCalculation.f5;
      case 6:
        return DepthCalculation.f6;
      case 7:
        return DepthCalculation.f7;
      case 8:
        return DepthCalculation.f8;
      default:
        return DepthCalculation.undefined;
    }
  }
}
