// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_observation_station.dart';

part 'observation.freezed.dart';
part 'observation.g.dart';

@Freezed()
abstract class Observation with _$Observation {
  const factory Observation({
    required List<TsunamiObservationStation> stations,
  }) = _Observation;
  
  factory Observation.fromJson(Map<String, Object?> json) => _$ObservationFromJson(json);
}
