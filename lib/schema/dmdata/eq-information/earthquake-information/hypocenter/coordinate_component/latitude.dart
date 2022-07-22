class Latitude {
  Latitude({
    required this.text,
    required this.value,
  });

  factory Latitude.fromJson(Map<String, dynamic> j) => Latitude(
        text: j['text'].toString(),
        value: double.parse(j['value'].toString()),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': text,
        'value': value,
      };

  /// 緯度をテキスト文で表現する
  final String text;

  /// 緯度を10進数法、単位度で表現する
  final double value;
}
