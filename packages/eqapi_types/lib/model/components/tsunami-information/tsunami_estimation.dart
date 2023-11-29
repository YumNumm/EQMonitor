import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_estimation.freezed.dart';
part 'tsunami_estimation.g.dart';

@freezed
class TsunamiEstimation with _$TsunamiEstimation {
  const factory TsunamiEstimation({
    required String code,
    required String name,
    required DateTime? firstHeightTime,
    required TsunamiEstimationFirstHeightCondition? firstHeightCondition,
    required DateTime? maxHeightTime,
    required double? maxHeightValue,
    required bool? maxHeightIsOver,
    required TsunamiEstimationMaxHeightCondition? maxHeightCondition,
    required bool? isObserving,
  }) = _TsunamiEstimation;

  factory TsunamiEstimation.fromJson(Map<String, dynamic> json) =>
      _$TsunamiEstimationFromJson(json);
}

@JsonEnum(valueField: 'type')
enum TsunamiEstimationFirstHeightCondition {
  /// 早いところでは既に津波到達と推定
  already('早いところでは既に津波到達と推定');

  const TsunamiEstimationFirstHeightCondition(this.type);
  final String type;
}

@JsonEnum(valueField: 'type')
enum TsunamiEstimationMaxHeightCondition {
  high('高い'),
  huge('巨大');

  const TsunamiEstimationMaxHeightCondition(this.type);
  final String type;
}
