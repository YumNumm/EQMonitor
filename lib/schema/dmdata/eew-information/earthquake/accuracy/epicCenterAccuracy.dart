/// 震央位置の精度値
// ignore_for_file: file_names

class EpicCenters {
  EpicCenters({
    required this.epicCenterAccuracy,
    required this.hypoCenterAccuracy,
  });
  EpicCenters.fromList(List<int> l)
      : epicCenterAccuracy = EpicCenterAccuracy.values.firstWhere(
          (element) => element.code == l[0],
          orElse: () => EpicCenterAccuracy.unknown,
        ),
        hypoCenterAccuracy = HypoCenterAccuracy.values.firstWhere(
          (element) => element.code == l[1],
          orElse: () => HypoCenterAccuracy.unknown,
        );

  /// 震央位置の精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
  /// `epiccenters[0]`
  final EpicCenterAccuracy epicCenterAccuracy;

  /// 震源位置の精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
  /// `epiccenters[1]`
  final HypoCenterAccuracy hypoCenterAccuracy;

  List<int> toJson() => <int>[
        epicCenterAccuracy.code,
        hypoCenterAccuracy.code,
      ];
}

/// 震央位置の精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
/// `epiccenters[0]`
enum EpicCenterAccuracy {
  unknown('不明', 0),
  f1('P波/S波レベル越え、IPF法(1点)、または仮定震源要素', 1),
  f2('IPF法(2点)(気象庁データ)', 2),
  f3('IPF法(3,4点)(気象庁データ)', 3),
  f4('IPF法(5点以上)(気象庁データ)', 4),
  f5('防災科研システム(4点以下または精度情報なし)', 5),
  f6('防災科研システム(5点以上)(Hi-netデータ)', 6),
  f7('EPOS(海域,観測網外)', 7),
  f8('EPOS(内陸,観測網内)', 8);

  const EpicCenterAccuracy(this.description, this.code);

  final String description;
  final int code;
}

/// 震源位置の精度値を記載します。`0`から`9`までの整数値を使用し、精度を表現します。
/// `epiccenters[1]`
enum HypoCenterAccuracy {
  unknown('不明', 0),
  f1('P/S波レベル越え, IPF法(1点),仮定震源要素', 1),
  f2('IPF法(2点)', 2),
  f3('IPF法(3,4点)', 3),
  f4('IPF法(5点以上)', 4),
  f9('震源とマグニチュードに基づく震度予測手法での精度が最終報相当', 9);

  const HypoCenterAccuracy(this.description, this.code);

  final String description;
  final int code;
}
