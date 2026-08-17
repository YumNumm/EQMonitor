import 'package:eqmonitor/feature/tsunami/data/model/value/qualitative_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_forecast_max_height.freezed.dart';

@freezed
abstract class TsunamiForecastMaxHeight with _$TsunamiForecastMaxHeight {
  const factory({
    required double? value,
    required bool? isOver,
    required QualitativeHeight? qualitative,
    required bool? isImportant,
    required Revise? revise,
  }) = _TsunamiForecastMaxHeight;
}

extension TsunamiRegionForecastMaxHeightApiExt
    on api.TsunamiRegionForecastMaxHeight {
  TsunamiForecastMaxHeight toDomain() => TsunamiForecastMaxHeight(
    value: value?.toDouble(),
    isOver: isOver,
    qualitative: qualitative?.toDomain(),
    isImportant: isImportant,
    revise: revise?.toDomain(),
  );
}
