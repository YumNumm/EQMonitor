import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/first_height_condition.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/revise.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_station_forecast.freezed.dart';

@freezed
abstract class TsunamiStationForecast with _$TsunamiStationForecast {
  const factory({
    required DateTime highTideAt,
    required TsunamiForecastFirstHeight? firstHeight,
  }) = _TsunamiStationForecast;
}

extension TsunamiStationForecastApiExt on api.TsunamiStationForecast {
  TsunamiStationForecast toDomain() => TsunamiStationForecast(
    highTideAt: highTideAt,
    firstHeight: firstHeight?.toDomainFromFirstHeight2(),
  );
}

extension _FirstHeight2ApiExt on api.TsunamiStationForecastFirstHeight {
  TsunamiForecastFirstHeight toDomainFromFirstHeight2() =>
      TsunamiForecastFirstHeight(
        arrivalTime: arrivalTime,
        condition: condition?.toDomain(),
        revise: revise?.toDomain(),
      );
}
