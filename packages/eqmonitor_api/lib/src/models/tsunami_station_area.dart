// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'localized_name.dart';
import 'tsunami_station.dart';

part 'tsunami_station_area.freezed.dart';
part 'tsunami_station_area.g.dart';

@Freezed()
abstract class TsunamiStationArea with _$TsunamiStationArea {
  const factory TsunamiStationArea({
    @JsonKey(includeIfNull: true)
    required LocalizedName? name,
    required List<TsunamiStation> stations,
  }) = _TsunamiStationArea;
  
  factory TsunamiStationArea.fromJson(Map<String, Object?> json) => _$TsunamiStationAreaFromJson(json);
}
