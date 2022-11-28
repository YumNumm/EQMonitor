import 'package:eqmonitor/provider/telegram_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_history_model.freezed.dart';

@freezed
class EewHistoryModel with _$EewHistoryModel {
  const factory EewHistoryModel({
    /// 表示する緊急地震速報電文リスト
    required List<EewTelegram> showEews,
  }) = _EewHistoryModel;
}
