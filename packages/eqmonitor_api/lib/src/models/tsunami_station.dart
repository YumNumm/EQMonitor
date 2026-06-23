// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'localized_name.dart';
import 'parameter_location.dart';

part 'tsunami_station.freezed.dart';
part 'tsunami_station.g.dart';

@Freezed()
abstract class TsunamiStation with _$TsunamiStation {
  const factory TsunamiStation({
    required String code,
    required LocalizedName name,
    @JsonKey(includeIfNull: true) required String? kana,
    required String owner,
    required ParameterLocation location,
  }) = _TsunamiStation;

  factory TsunamiStation.fromJson(Map<String, Object?> json) =>
      _$TsunamiStationFromJson(json);
}
