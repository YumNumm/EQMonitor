// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'shindo_db_station.freezed.dart';
part 'shindo_db_station.g.dart';

@Freezed()
abstract class ShindoDbStation with _$ShindoDbStation {
  const factory ShindoDbStation({
    required String code,
    required String name,
    required num latitude,
    required num longitude,
    @JsonKey(includeIfNull: true,name: 'city_code')
    required String? cityCode,
  }) = _ShindoDbStation;

  factory ShindoDbStation.fromJson(Map<String, Object?> json) => _$ShindoDbStationFromJson(json);
}
