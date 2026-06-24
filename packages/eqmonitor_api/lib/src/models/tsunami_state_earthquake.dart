// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hypocenter.dart';

part 'tsunami_state_earthquake.freezed.dart';
part 'tsunami_state_earthquake.g.dart';

@Freezed()
abstract class TsunamiStateEarthquake with _$TsunamiStateEarthquake {
  const factory TsunamiStateEarthquake({
    @JsonKey(name: 'origin_time')
    required DateTime originTime,
    required Hypocenter hypocenter,
    @JsonKey(includeIfNull: false,name: 'arrival_time')
    DateTime? arrivalTime,
  }) = _TsunamiStateEarthquake;
  
  factory TsunamiStateEarthquake.fromJson(Map<String, Object?> json) => _$TsunamiStateEarthquakeFromJson(json);
}
