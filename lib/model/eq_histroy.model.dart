import 'package:eqmonitor/model/db/eq_history.schema.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

import '../utils/KyoshinMonitorlib/JmaIntensity.dart';

part 'eq_histroy.model.freezed.dart';

@freezed
class EQHistoryModel with _$EQHistoryModel {
  const factory EQHistoryModel({
    required Isar isar,
    required List<EQHistory> content,

    /// 表示する震度一覧
    required List<JmaIntensity> intensities,
  }) = _EQHistoryModel;
}
