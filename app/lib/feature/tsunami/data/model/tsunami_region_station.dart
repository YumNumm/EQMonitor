import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_forecast.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_observation.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_region_station.freezed.dart';

/// 津波予報区に属する観測点のドメインモデル
@freezed
abstract class TsunamiRegionStation with _$TsunamiRegionStation {
  const factory TsunamiRegionStation({
    required String code,
    required String name,
    TsunamiStationForecast? forecast,
    TsunamiStationObservation? observation,
  }) = _TsunamiRegionStation;
}

extension TsunamiRegionStationApiExt on api.TsunamiRegionStation {
  TsunamiRegionStation toDomain() => TsunamiRegionStation(
    code: code,
    name: name,
    forecast: forecast?.toDomain(),
    observation: observation?.toDomain(),
  );
}
