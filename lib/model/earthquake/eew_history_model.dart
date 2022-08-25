import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase/supabase.dart';

import '../../schema/dmdata/commonHeader.dart';

part 'eew_history_model.freezed.dart';

@freezed
class EewHistoryModel with _$EewHistoryModel {
  const factory EewHistoryModel({
    required List<CommonHead> eewTelegrams,
    required Map<int, List<CommonHead>> eewTelegramsGroupByEventId,
    required List<CommonHead> showEews,
    required SupabaseClient supabase,
    required RealtimeSubscription? subscription,

    /// テストケースを読み込み始めた時刻
    required DateTime? testCaseStartTime,
  }) = _EewHistoryModel;
}
