import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase/supabase.dart';

import '../../schema/remote/dmdata/commonHeader.dart';
import '../../schema/remote/dmdata/eew-information/eew-infomation.dart';

part 'eew_history_model.freezed.dart';

@freezed
class EewHistoryModel with _$EewHistoryModel {
  const factory EewHistoryModel({
    /// 緊急地震速報の電文リスト
    required List<CommonHead> eewTelegrams,

    /// EventID毎にグループ化した緊急地震速報電文リスト
    required Map<int, List<CommonHead>> eewTelegramsGroupByEventId,

    /// 表示する緊急地震速報電文リスト
    // TODO(YumNumm): 別のProviderで表示
    required Iterable<MapEntry<CommonHead, EEWInformation>> showEews,

    /// 緊急地震速報用のClient(WebSocket)
    required SupabaseClient supabase,

    /// 緊急地震速報のWebSocketの接続状態
    required RealtimeChannel? channel,

    /// テストケースを読み込み始めた時刻
    required DateTime? testCaseStartTime,
  }) = _EewHistoryModel;
}
