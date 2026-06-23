// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'eew_warning_zone_item.freezed.dart';
part 'eew_warning_zone_item.g.dart';

@Freezed()
abstract class EewWarningZoneItem with _$EewWarningZoneItem {
  const factory EewWarningZoneItem({
    /// コードは、気象庁防災情報XMLフォーマット コード表 地震火山関連コード表 による
    required String code,
    required String name,

    /// 前回の情報において、警報だったかどうか
    @JsonKey(name: 'had_warning') required bool hadWarning,
  }) = _EewWarningZoneItem;

  factory EewWarningZoneItem.fromJson(Map<String, Object?> json) =>
      _$EewWarningZoneItemFromJson(json);
}
