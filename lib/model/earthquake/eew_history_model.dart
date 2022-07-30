import 'package:eqmonitor/schema/dmdata/commonHeader.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_history_model.freezed.dart';

@freezed
class EewHistoryModel with _$EewHistoryModel {
  const factory EewHistoryModel({
   @Default([]) List<CommonHead> eewTelegrams,
   @Default({}) Map<int, List<CommonHead>> eewTelegramsGroupByEventId,
   @Default([]) List<CommonHead> showEews,
  }) = _EewHistoryModel;
}
