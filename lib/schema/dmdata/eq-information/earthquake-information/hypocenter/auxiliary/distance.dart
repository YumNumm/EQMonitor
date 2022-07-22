/// ## 代表地域と震源の距離情報
class Distance {
  Distance({
    required this.unit,
    required this.value,
  });

  Distance.fromJson(Map<String, dynamic> j)
      : unit = j['unit'].toString(),
        value = int.parse(j['value'].toString());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'unit': unit,
        'value': value,
      };

  /// 距離情報の単位。`km`で固定
  final String unit;

  /// 代表地域と震源の距離
  final int value;
}
