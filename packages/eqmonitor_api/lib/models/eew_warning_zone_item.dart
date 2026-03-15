// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'code_name.dart';

part 'eew_warning_zone_item.freezed.dart';
part 'eew_warning_zone_item.g.dart';

@Freezed()
abstract class EewWarningZoneItem with _$EewWarningZoneItem {
  const factory EewWarningZoneItem({
    required CodeName value,

    /// 前回の情報において、警報だったかどうか
    @JsonKey(name: 'had_warning') required bool hadWarning,
  }) = _EewWarningZoneItem;

  factory EewWarningZoneItem.fromJson(Map<String, Object?> json) =>
      _$EewWarningZoneItemFromJson(json);
}
