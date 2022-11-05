import 'package:freezed_annotation/freezed_annotation.dart';

import '../../schema/remote/supabase/telegram.dart';

part 'earthquake_log_model.freezed.dart';

/// ref: https://github.com/ingen084/KyoshinEewViewerIngen/blob/2801ad7959f99abe7ac81c2ff3a7d1974716a786/src/KyoshinEewViewer/Series/Earthquake/Services/EarthquakeWatchService.cs
@freezed
class EarthquakeHistoryModel with _$EarthquakeHistoryModel {
  const factory EarthquakeHistoryModel({
    /// 電文を保管
    required List<Telegram> telegrams,

    /// EventIdでgroupByされたMap
    /// VXSE5xとVXSE61のみを対象とする。
    required Map<int, List<Telegram>> telegramsGroupByEventId,
  }) = _EarthquakeHistoryModel;
}
