import 'package:freezed_annotation/freezed_annotation.dart';

part 'magnitude.freezed.dart';
part 'magnitude.g.dart';

/// 地震の規模を表すマグニチュード
@Freezed(unionKey: 'type')
sealed class Magnitude with _$Magnitude {
  /// 通常のマグニチュード値
  @FreezedUnionValue('NORMAL')
  const factory Magnitude.normal({
    required double value,
  }) = MagnitudeNormal;

  /// M不明
  @FreezedUnionValue('UNKNOWN')
  const factory Magnitude.unknown() = MagnitudeUnknown;

  /// M8を超える巨大地震
  @FreezedUnionValue('OVER_M8')
  const factory Magnitude.overM8() = MagnitudeOverM8;

  factory Magnitude.fromJson(Map<String, dynamic> json) =>
      _$MagnitudeFromJson(json);
}
