import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_forecast_first_height.freezed.dart';

@freezed
abstract class TsunamiForecastFirstHeight with _$TsunamiForecastFirstHeight {
  const factory TsunamiForecastFirstHeight({
    required DateTime? arrivalTime,
    required FirstHeightCondition? condition,
    required Revise? revise,
  }) = _TsunamiForecastFirstHeight;
}

extension TsunamiRegionForecastFirstHeightApiExt
    on api.TsunamiRegionForecastFirstHeight {
  TsunamiForecastFirstHeight toDomain() => TsunamiForecastFirstHeight(
    arrivalTime: arrivalTime,
    condition: condition?.toDomain(),
    revise: revise?.toDomain(),
  );
}
