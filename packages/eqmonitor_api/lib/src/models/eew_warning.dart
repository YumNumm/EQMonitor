// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'eew_warning_zone_item.dart';

part 'eew_warning.freezed.dart';
part 'eew_warning.g.dart';

@Freezed()
abstract class EewWarning with _$EewWarning {
  const factory EewWarning({
    required List<EewWarningZoneItem> zones,
    required List<EewWarningZoneItem> prefectures,
    required List<EewWarningZoneItem> regions,
  }) = _EewWarning;
  
  factory EewWarning.fromJson(Map<String, Object?> json) => _$EewWarningFromJson(json);
}
