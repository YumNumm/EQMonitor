import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

part 'eq_histroy.model.freezed.dart';

@freezed
class EQHistoryModel with _$EQHistoryModel {
  const factory EQHistoryModel({
    required Isar isar,
  }) = _EQHistoryModel;
}
