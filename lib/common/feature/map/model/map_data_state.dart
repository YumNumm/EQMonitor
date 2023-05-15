import 'package:eqmonitor/common/feature/map/model/jma_map_property.dart';
import 'package:eqmonitor/common/feature/map/model/map_polygon.dart';
import 'package:eqmonitor/common/feature/map/model/map_type.dart';
import 'package:eqmonitor/common/feature/map/model/world_map_property.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_data_state.freezed.dart';

@freezed
class MapDataState with _$MapDataState {
  const factory MapDataState({
    @JsonKey(
      fromJson: _jmaMapDataFromJson,
      toJson: _jmaMapDataToJson,
    )
        required Map<MapDataType, List<MultiPolygonMapData<JmaMapProperty>>>
            jmaMapData,
    @JsonKey(
      fromJson: _worldMapDataFromJson,
      toJson: _worldMapDataToJson,
    )
        required List<MultiPolygonMapData<WorldMapProperty>> worldMapData,
  }) = _MapDataState;

  factory MapDataState.fromJson(Map<String, dynamic> json) =>
      _$MapDataStateFromJson(json);
}

Map<MapDataType, List<MultiPolygonMapData<JmaMapProperty>>> _jmaMapDataFromJson(
  Map<String, dynamic> json,
) =>
    throw UnimplementedError();

Map<String, dynamic> _jmaMapDataToJson(
  Map<MapDataType, List<MultiPolygonMapData<JmaMapProperty>>> instance,
) =>
    throw UnimplementedError();

List<MultiPolygonMapData<WorldMapProperty>> _worldMapDataFromJson(
  Map<String, dynamic> json,
) =>
    throw UnimplementedError();

Map<String, dynamic> _worldMapDataToJson(
  List<MultiPolygonMapData<WorldMapProperty>> instance,
) =>
    throw UnimplementedError();
