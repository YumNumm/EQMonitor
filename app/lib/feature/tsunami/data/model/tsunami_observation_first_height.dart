import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/wave_initial.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_observation_first_height.freezed.dart';

@freezed
abstract class TsunamiObservationFirstHeight
    with _$TsunamiObservationFirstHeight {
  const factory({
    required DateTime? arrivalTime,
    required WaveInitial? initial,
    required bool? isUnidentifiable,
    required bool? isMissing,
    required Revise? revise,
  }) = _TsunamiObservationFirstHeight;
}

extension TsunamiStationObservationFirstHeightApiExt
    on api.TsunamiStationObservationFirstHeight {
  TsunamiObservationFirstHeight toDomain() => TsunamiObservationFirstHeight(
    arrivalTime: arrivalTime,
    initial: initial?.toDomain(),
    isUnidentifiable: isUnidentifiable,
    isMissing: isMissing,
    revise: revise?.toDomain(),
  );
}
