class SVA {
  SVA({
    required this.unit,
    required this.value,
  });

  SVA.fromJson(Map<String, dynamic> j)
      : unit = j['unit'].toString(),
        value = double.parse(j['value'].toString());

  /// 絶対速度応答スペクトル情報の単位。`cm/s`で固定
  final String unit;

  /// 絶対速度応答スペクトルの1.6秒～7.8秒周期帯における最大値を記載する
  final double value;
}
