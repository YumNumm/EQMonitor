import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_forecast_max_height.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_region_forecast.freezed.dart';

/// 津波予報区単位の予報のドメインモデル
@freezed
abstract class TsunamiRegionForecast with _$TsunamiRegionForecast {
  const factory TsunamiRegionForecast({
    TsunamiForecastFirstHeight? firstHeight,
    TsunamiForecastMaxHeight? maxHeight,
  }) = _TsunamiRegionForecast;
}

extension TsunamiRegionForecastApiExt on api.TsunamiRegionForecast {
  TsunamiRegionForecast toDomain() => TsunamiRegionForecast(
    firstHeight: firstHeight?.toDomain(),
    maxHeight: maxHeight?.toDomain(),
  );
}
