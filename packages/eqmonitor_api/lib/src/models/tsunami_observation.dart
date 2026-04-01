// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_observation_station.dart';

part 'tsunami_observation.freezed.dart';
part 'tsunami_observation.g.dart';

@Freezed()
abstract class TsunamiObservation with _$TsunamiObservation {
  const factory TsunamiObservation({
    required List<TsunamiObservationStation> stations,
    @JsonKey(includeIfNull: false)
    String? code,
    @JsonKey(includeIfNull: false)
    String? name,
  }) = _TsunamiObservation;
  
  factory TsunamiObservation.fromJson(Map<String, Object?> json) => _$TsunamiObservationFromJson(json);
}
