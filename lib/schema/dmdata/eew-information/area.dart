import 'area/kind.dart';

/// 緊急地震速報の警報が発表された地域を記載します。

/// VXSE43、VXSE45の場合のみ出現し、警報対象地域がない場合（取消報など）は出現しません。
class Area {
  Area({
    required this.code,
    required this.name,
    required this.kind,
  });

  factory Area.fromJson(Map<String, dynamic> j) => Area(
        code: j['code'].toString(),
        name: j['name'].toString(),
        kind: Kind.fromJson(j['kind'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
        'kind': kind.toJson(),
      };

  /// 地域コード
  final String code;

  /// 地域名
  final String name;

  /// 警報の種別
  final Kind kind;
}
