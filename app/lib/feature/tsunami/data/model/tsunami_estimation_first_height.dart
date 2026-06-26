import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_estimation_first_height.freezed.dart';

@freezed
abstract class TsunamiEstimationFirstHeight
    with _$TsunamiEstimationFirstHeight {
  const factory TsunamiEstimationFirstHeight({
    required DateTime? arrivalTime,
    required bool? isAlreadyArrived,
    required Revise? revise,
  }) = _TsunamiEstimationFirstHeight;
}

extension TsunamiEstimationFirstHeightApiExt
    on api.TsunamiRegionEstimationFirstHeight {
  TsunamiEstimationFirstHeight toDomain() => TsunamiEstimationFirstHeight(
    arrivalTime: arrivalTime,
    isAlreadyArrived: isAlreadyArrived as bool?,
    revise: revise?.toDomain(),
  );
}
