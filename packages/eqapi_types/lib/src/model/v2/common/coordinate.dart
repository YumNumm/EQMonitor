import 'package:freezed_annotation/freezed_annotation.dart';

part 'coordinate.freezed.dart';
part 'coordinate.g.dart';

/// 震源座標
@Freezed(unionKey: 'type')
sealed class Coordinate with _$Coordinate {
  /// 緯度経度が存在する場合
  @FreezedUnionValue('LAT_LNG')
  const factory Coordinate.latLng({
    required double latitude,
    required double longitude,
  }) = CoordinateLatLng;

  /// 不明
  @FreezedUnionValue('UNKNOWN')
  const factory Coordinate.unknown({
    required String condition,
  }) = CoordinateUnknown;

  factory Coordinate.fromJson(Map<String, dynamic> json) =>
      _$CoordinateFromJson(json);
}
