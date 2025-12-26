import 'package:freezed_annotation/freezed_annotation.dart';

part 'depth.freezed.dart';
part 'depth.g.dart';

/// 震源の深さ
@Freezed(unionKey: 'type')
sealed class Depth with _$Depth {
  /// ごく浅い
  @FreezedUnionValue('SHALLOW')
  const factory Depth.shallow() = DepthShallow;

  /// 10~700km
  @FreezedUnionValue('NORMAL')
  const factory Depth.normal({
    required int value,
  }) = DepthNormal;

  /// 700km以上
  @FreezedUnionValue('OVER_700')
  const factory Depth.over700() = DepthOver700;

  /// 不明
  @FreezedUnionValue('UNKNOWN')
  const factory Depth.unknown() = DepthUnknown;

  factory Depth.fromJson(Map<String, dynamic> json) => _$DepthFromJson(json);
}
