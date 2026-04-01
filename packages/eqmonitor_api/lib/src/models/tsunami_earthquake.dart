// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'hypocenter.dart';

part 'tsunami_earthquake.freezed.dart';
part 'tsunami_earthquake.g.dart';

@Freezed()
abstract class TsunamiEarthquake with _$TsunamiEarthquake {
  const factory TsunamiEarthquake({
    @JsonKey(name: 'origin_time')
    required DateTime originTime,
    required Hypocenter hypocenter,
    @JsonKey(includeIfNull: false,name: 'arrival_time')
    DateTime? arrivalTime,
  }) = _TsunamiEarthquake;
  
  factory TsunamiEarthquake.fromJson(Map<String, Object?> json) => _$TsunamiEarthquakeFromJson(json);
}
