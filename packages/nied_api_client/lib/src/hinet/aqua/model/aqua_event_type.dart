import 'package:json_annotation/json_annotation.dart';

/// AQUA解析タイプ
enum AquaEventType(
  /// 解析タイプコード
  final String code,

  /// フルネーム
  final String fullName,
) {
  /// AQUA-CMT (Centroid Moment Tensor)
  @JsonValue('C')
  cmt('C', 'AQUA-CMT'),

  /// AQUA-MT (Moment Tensor)
  @JsonValue('M')
  mt('M', 'AQUA-MT');

  /// コードから解析タイプを取得
  static AquaEventType fromCode(String code) {
    return AquaEventType.values.firstWhere(
      (type) => type.code == code,
      orElse: () => throw ArgumentError('Invalid AquaEventType code: $code'),
    );
  }
}
