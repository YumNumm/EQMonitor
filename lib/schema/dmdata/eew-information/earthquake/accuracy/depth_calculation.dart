/// ## 7.4.7.2.depth
/// 深さの精度値を記載します。
/// `0`から`9`までの整数値を使用し、精度を表現します。
enum DepthCalculation {
  unknown('不明', 0),
  f1('P波/S波レベル越え、IPF法(1点)、または「仮定震源要素」の場合', 1),
  f2('IPF法(2点)', 2),
  f3('IPF法(3点/4点)', 3),
  f4('IPF法(5点以上)', 4),
  f5('防災科研システム(4点以下、または精度情報なし)', 5),
  f6('防災科研システム(5点以上)(Hi-netデータ)', 6),
  f7('EPOS(海域[観測網外])', 7),
  f8('EPOS(内陸[観測網内])', 8);

  const DepthCalculation(this.description, this.code);

  final String description;
  final int code;
}
