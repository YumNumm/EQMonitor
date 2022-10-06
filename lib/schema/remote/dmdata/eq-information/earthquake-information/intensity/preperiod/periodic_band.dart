class PeriodicBand {
  PeriodicBand({
    required this.unit,
    required this.value,
  });
  PeriodicBand.fromJson(Map<String, dynamic> j)
      : unit = j['unit'].toString(),
        value = int.parse(j['value'].toString());

  /// 対象とする周期帯情報の単位。
  /// `秒台`で固定
  final String unit;

  /// 対象とする周期帯の秒数を記載する、1秒～7秒の範囲
  final int value;
}

enum Revise {
  up,
  add,
}
