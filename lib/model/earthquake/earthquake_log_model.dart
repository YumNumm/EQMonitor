import 'dart:async';

import 'package:eqmonitor/const/obspoint.dart';
import 'package:eqmonitor/model/analyzed_point_model.dart';
import 'package:eqmonitor/schema/supabase/telegram.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'earthquake_item.dart';

part 'earthquake_log_model.freezed.dart';

/// ref: https://github.com/ingen084/KyoshinEewViewerIngen/blob/2801ad7959f99abe7ac81c2ff3a7d1974716a786/src/KyoshinEewViewer/Series/Earthquake/Services/EarthquakeWatchService.cs
@freezed
class EarthquakeHistoryModel with _$EarthquakeHistoryModel {
  const factory EarthquakeHistoryModel({
    /// 電文を保管
    required List<Telegram> telegrams,
    /// EventIdでgroupByされたMap
    /// VXSE5xとVXSE61のみを対象とする。
    required Map<int,List<Telegram>> telegramsGroupByEventId,


  }) = _EarthquakeHistoryModel;
}