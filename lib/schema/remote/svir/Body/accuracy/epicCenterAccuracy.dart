/// 震央位置の精度値
class EpicCenters {
  EpicCenters({
    required this.epicCenterAccuracy,
    required this.hypoCenterAccuracy,
  });
  EpicCenters.fromList(List<int> l)
      : epicCenterAccuracy = l[0].getEpicCenterAccuracy,
        hypoCenterAccuracy = l[1].getHypoCenterAccuracy;

  /// 震央位置の精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
  /// `epiccenters[0]`
  final EpicCenterAccuracy epicCenterAccuracy;

  /// 震源位置の精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
  /// `epiccenters[1]`
  final HypoCenterAccuracy hypoCenterAccuracy;
}

/// 震央位置の精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
/// `epiccenters[0]`
enum EpicCenterAccuracy {
  f0,
  f1,
  f2,
  f3,
  f4,
  f5,
  f6,
  f7,
  f8,
  undefined,
}

extension epicCenterAccuracyToString on EpicCenterAccuracy {
  String get description {
    switch (this) {
      case EpicCenterAccuracy.f0:
        return '不明';
      case EpicCenterAccuracy.f1:
        return 'P波/S波レベル越え、IPF法(1点)、または仮定震源要素';
      case EpicCenterAccuracy.f2:
        return 'IPF法(2点)(気象庁データ)';
      case EpicCenterAccuracy.f3:
        return 'IPF法(3,4点)(気象庁データ)';
      case EpicCenterAccuracy.f4:
        return 'IPF法(5点以上)(気象庁データ)';
      case EpicCenterAccuracy.f5:
        return '防災科研システム(4点以下または精度情報なし)';
      case EpicCenterAccuracy.f6:
        return '防災科研システム(5点以上)(Hi-netデータ)';
      case EpicCenterAccuracy.f7:
        return 'EPOS(海域,観測網外)';
      case EpicCenterAccuracy.f8:
        return 'EPOS(内陸,観測網内)';
      case EpicCenterAccuracy.undefined:
        return '不明';
    }
  }
}

extension intToEpicCenterAccuracy on int {
  EpicCenterAccuracy get getEpicCenterAccuracy {
    switch (this) {
      case 0:
        return EpicCenterAccuracy.f0;
      case 1:
        return EpicCenterAccuracy.f1;
      case 2:
        return EpicCenterAccuracy.f2;
      case 3:
        return EpicCenterAccuracy.f3;
      case 4:
        return EpicCenterAccuracy.f4;
      case 5:
        return EpicCenterAccuracy.f5;
      case 6:
        return EpicCenterAccuracy.f6;
      case 7:
        return EpicCenterAccuracy.f7;
      case 8:
        return EpicCenterAccuracy.f8;
      default:
        return EpicCenterAccuracy.undefined;
    }
  }
}

/// 震源位置の精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
/// `epiccenters[1]`
enum HypoCenterAccuracy {
  f0,
  f1,
  f2,
  f3,
  f4,
  f9,
  undefined,
}

extension hypoCenterAccuracyToString on HypoCenterAccuracy {
  String get description {
    switch (this) {
      case HypoCenterAccuracy.f0:
        return '不明';
      case HypoCenterAccuracy.f1:
        return 'P/S波レベル越え, IPF法(1点),仮定震源要素';
      case HypoCenterAccuracy.f2:
        return 'IPF法(2点)';
      case HypoCenterAccuracy.f3:
        return 'IPF法(3,4点)';
      case HypoCenterAccuracy.f4:
        return 'IPF法(5点以上)';
      case HypoCenterAccuracy.f9:
        return '震源とマグニチュードに基づく震度予測手法での精度が最終報相当';
      //(推定震源とマグニチュードはこれ以降変化しません。ただし、PLUM法により予測震度が今後変化する可能性はあります。)
      case HypoCenterAccuracy.undefined:
        return '不明';
    }
  }
}

extension intToHypoCenterAccuracy on int {
  HypoCenterAccuracy get getHypoCenterAccuracy {
    switch (this) {
      case 0:
        return HypoCenterAccuracy.f0;
      case 1:
        return HypoCenterAccuracy.f1;
      case 2:
        return HypoCenterAccuracy.f2;
      case 3:
        return HypoCenterAccuracy.f3;
      case 4:
        return HypoCenterAccuracy.f4;
      case 9:
        return HypoCenterAccuracy.f9;
      default:
        return HypoCenterAccuracy.undefined;
    }
  }
}
