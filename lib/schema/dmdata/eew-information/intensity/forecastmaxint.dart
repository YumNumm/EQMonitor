/// 最大予測震度を記載する
class ForecastMaxInt {
  ForecastMaxInt.fromJson(Map<String, dynamic> j)
      : from = j['from'].toString(),
        to = j['to'].toString();
  ForecastMaxInt({
    required this.from,
    required this.to,
  });
  final String from;
  final String to;
}
