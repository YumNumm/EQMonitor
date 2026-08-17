import 'package:eqmonitor/feature/tsunami/data/model/value/observation_max_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_observation_max_height.freezed.dart';

@freezed
abstract class TsunamiObservationMaxHeight with _$TsunamiObservationMaxHeight {
  const factory({
    required DateTime? dateTime,
    required double? value,
    required bool? isOver,
    required bool? isRising,
    required ObservationMaxHeightCondition? condition,
    required bool? isMissing,
    required Revise? revise,
  }) = _TsunamiObservationMaxHeight;
}

extension TsunamiStationObservationMaxHeightApiExt
    on api.TsunamiStationObservationMaxHeight {
  TsunamiObservationMaxHeight toDomain() => TsunamiObservationMaxHeight(
    dateTime: observedAt,
    value: value?.toDouble(),
    isOver: isOver,
    isRising: isRising,
    condition: condition?.toDomain(),
    isMissing: isMissing,
    revise: revise?.toDomain(),
  );
}
