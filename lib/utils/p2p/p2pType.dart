import 'package:intl/intl.dart';

class P2PJsonApiv2 {
  /// 情報を一意に識別するID
  final String id;

  /// ## 情報コード
  /// - `551` 地震情報
  /// - `552` 津波予報
  /// - `554` 緊急地震速報 発表検出
  /// - `555` 各地域ピア数
  /// - `561` 地震感知情報
  /// - `9611` 地震感知情報 解析結果
  final int code;

  /// 受信日付
  final DateTime time;
  P2PJsonApiv2({
    required this.id,
    required this.code,
    required this.time,
  });
  P2PJsonApiv2.fromJson(Map<String, dynamic> j)
      : id = j['id'].toString(),
        code = int.parse(j['code'].toString()),
        time = DateFormat('yyyy/MM/dd HH:mm.SSS').parse(j['time'].toString());


}
