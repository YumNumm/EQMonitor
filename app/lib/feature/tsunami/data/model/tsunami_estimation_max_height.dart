import 'package:eqmonitor/feature/tsunami/data/model/value/qualitative_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_estimation_max_height.freezed.dart';

@freezed
abstract class TsunamiEstimationMaxHeight with _$TsunamiEstimationMaxHeight {
  const factory TsunamiEstimationMaxHeight({
    required DateTime? dateTime,
    required double? value,
    required bool? isOver,
    required QualitativeHeight? qualitative,
    required bool? isObserving,
    required Revise? revise,
  }) = _TsunamiEstimationMaxHeight;
}

extension TsunamiEstimationMaxHeightApiExt
    on api.TsunamiRegionEstimationMaxHeight {
  TsunamiEstimationMaxHeight toDomain() => TsunamiEstimationMaxHeight(
    dateTime: observedAt,
    value: value?.toDouble(),
    isOver: isOver as bool?,
    qualitative: qualitative?.toDomain(),
    isObserving: isObserving as bool?,
    revise: revise?.toDomain(),
  );
}
