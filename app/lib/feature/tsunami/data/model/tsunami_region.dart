import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region_estimation.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region_forecast.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tsunami_region.freezed.dart';

/// 津波予報区のドメインモデル
@freezed
abstract class TsunamiRegion with _$TsunamiRegion {
  const factory({
    required String code,
    required String name,
    required TsunamiWarningKind kind,
    required TsunamiWarningKind lastKind,
    required List<TsunamiRegionStation> stations,
    TsunamiRegionForecast? forecast,
    TsunamiRegionEstimation? estimation,
  }) = _TsunamiRegion;
}

extension TsunamiRegionApiExt on api.TsunamiRegion {
  TsunamiRegion toDomain() => TsunamiRegion(
    code: code,
    name: name,
    kind: kind.toDomain(),
    lastKind: lastKind.toDomain(),
    stations: stations.map((e) => e.toDomain()).toList(),
    forecast: forecast?.toDomain(),
    estimation: estimation?.toDomain(),
  );
}
