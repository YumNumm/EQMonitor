import 'auxiliary/distance.dart';

/// ## 震源位置の補足情報。
/// 対象の地震により津波注意報などが発表される状況下で、`VXSE53`または`VTSE41`,`VTSE51`,`VTSE52`のみに出現する。
class Auxiliary {
  Auxiliary({
    required this.text,
    required this.code,
    required this.name,
    required this.direction,
    required this.distance,
  });

  Auxiliary.fromJson(Map<String, dynamic> j)
      : text = j['text'].toString(),
        code = int.parse(j['code'].toString()),
        name = j['name'].toString(),
        direction = j['direction'].toString(),
        distance = Distance.fromJson(j['distance'] as Map<String, dynamic>);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': text,
        'code': code,
        'name': name,
        'direction': direction,
        'distance': distance.toJson(),
      };

  /// 震源位置の捕捉位置を記載
  final String text;

  /// 震源位置の捕捉位置を表現する代表地域コード
  /// コードは、気象庁防災情報XMLフォーマット
  /// コード表 地震火山関連コード表 による
  final int code;

  /// 震源位置の捕捉位置を表現する代表地域名
  final String name;

  /// 代表地域から震源への方角を16方位で表現
  final String direction;

  /// 代表地域と震源の距離情報
  final Distance distance;
}
