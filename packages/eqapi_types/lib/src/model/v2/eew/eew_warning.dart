import 'package:eqapi_types/src/model/v2/common/code_name.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning.freezed.dart';
part 'eew_warning.g.dart';

/// 警報地域項目
@freezed
abstract class EewWarningZoneItem with _$EewWarningZoneItem {
  const factory EewWarningZoneItem({
    required CodeName value,

    /// 前回の情報において、警報だったかどうか
    required bool hadWarning,
  }) = _EewWarningZoneItem;

  factory EewWarningZoneItem.fromJson(Map<String, dynamic> json) =>
      _$EewWarningZoneItemFromJson(json);
}

/// EEW警報情報
@freezed
abstract class EewWarning with _$EewWarning {
  const factory EewWarning({
    required List<EewWarningZoneItem> zones,
    required List<EewWarningZoneItem> prefectures,
    required List<EewWarningZoneItem> regions,
  }) = _EewWarning;

  factory EewWarning.fromJson(Map<String, dynamic> json) =>
      _$EewWarningFromJson(json);
}
