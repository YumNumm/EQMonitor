import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

part 'cities.model.freezed.dart';

@freezed
class CitiesModel with _$CitiesModel {
  const factory CitiesModel({
    required Isar isar,
  }) = _CitiesModel;
}
