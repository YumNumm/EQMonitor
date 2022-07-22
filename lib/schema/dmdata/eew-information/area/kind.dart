import 'last_kind.dart';

/// 警報の種別
class Kind {
  Kind({
    required this.code,
    required this.name,
    required this.last,
  });

  factory Kind.fromJson(Map<String, dynamic> j) => Kind(
        code: int.parse(j['code'].toString()),
        name: j['name'].toString(),
        last: LastKind.fromJson(j['lastKind'] as Map<String, dynamic>),
      );

  /// 警報の種別、コード 31 で固定
  final int code;

  /// 警報の種別、名称 緊急地震速報（警報） で固定
  final String name;

  /// このEventIdで前回の警報種別
  final LastKind last;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'code': code,
        'name': name,
        'lastKind': last.toJson(),
      };
}
