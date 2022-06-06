import 'package:eqmonitor/model/db/eq_history.schema.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import 'eq_history_content.model.dart';

part 'eq_histroy.model.freezed.dart';

@freezed
class EQHistoryModel with _$EQHistoryModel {
  const factory EQHistoryModel({
    required Isar isar,
    required List<EQHistory> content,
  }) = _EQHistoryModel;
}
