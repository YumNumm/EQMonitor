// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_station_observation_first_height.dart';
import 'tsunami_station_observation_max_height.dart';

part 'tsunami_offshore_station.freezed.dart';
part 'tsunami_offshore_station.g.dart';

@Freezed()
abstract class TsunamiOffshoreStation with _$TsunamiOffshoreStation {
  const factory TsunamiOffshoreStation({
    required String code,
    required String name,
    @JsonKey(name: 'first_height')
    required TsunamiStationObservationFirstHeight firstHeight,
    @JsonKey(includeIfNull: false)
    String? sensor,
    @JsonKey(includeIfNull: false,name: 'max_height')
    TsunamiStationObservationMaxHeight? maxHeight,
  }) = _TsunamiOffshoreStation;
  
  factory TsunamiOffshoreStation.fromJson(Map<String, Object?> json) => _$TsunamiOffshoreStationFromJson(json);
}
