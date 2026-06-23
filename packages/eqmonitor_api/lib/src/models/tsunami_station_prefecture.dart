// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'localized_name.dart';
import 'tsunami_station_area.dart';

part 'tsunami_station_prefecture.freezed.dart';
part 'tsunami_station_prefecture.g.dart';

@Freezed()
abstract class TsunamiStationPrefecture with _$TsunamiStationPrefecture {
  const factory TsunamiStationPrefecture({
    required String code,
    required LocalizedName name,
    required List<TsunamiStationArea> areas,
  }) = _TsunamiStationPrefecture;

  factory TsunamiStationPrefecture.fromJson(Map<String, Object?> json) =>
      _$TsunamiStationPrefectureFromJson(json);
}
