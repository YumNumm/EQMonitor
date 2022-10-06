class Longitude {
  Longitude({
    required this.text,
    required this.value,
  });

  Longitude.fromJson(Map<String, dynamic> j)
      : text = j['text'].toString(),
        value = double.parse(j['value'].toString());

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': text,
        'value': value,
      };

  /// 経度をテキスト文で表現する
  final String text;

  /// 経度を10進数法、単位度で表現する
  final double value;
}
