class Height {
  Height({
    required this.type,
    required this.unit,
    required this.value,
  });

  Height.fromJson(Map<String, dynamic> j)
      : type = j['type'].toString(),
        unit = j['unit'].toString(),
        value = double.parse(j['value'].toString());

  Map<String, dynamic> toJson() =>
      <String, dynamic>{'type': type, 'unit': unit, 'value': value};

  /// `高さ`で固定
  final String type;

  /// 高さ情報の単位`m`で固定
  final String unit;

  /// 高さの数値
  final double value;
}
