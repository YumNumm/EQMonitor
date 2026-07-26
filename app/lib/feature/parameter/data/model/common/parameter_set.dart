import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/jma_code_table/jma_code_table_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/kyoshin/kyoshin_observation_points_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/model/tsunami/tsunami_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'parameter_set.freezed.dart';

@freezed
abstract class ParameterSet with _$ParameterSet {
  const factory ParameterSet({
    /// Asset Pack の `manifest.json`（地図アセットも含む）。パラメータ固有のメタ
    /// データが必要な場合は `manifest.findAsset(...)` を利用する。
    required AssetPackManifest manifest,
    required JmaCodeTableParameter jmaCodeTable,
    required KyoshinObservationPointsParameter kyoshinObservationPoints,
    required EarthquakeParameter earthquake,
    required TsunamiParameter tsunami,
    required ShindoDbStationsParameter shindoDbStations,
  }) = _ParameterSet;
}
