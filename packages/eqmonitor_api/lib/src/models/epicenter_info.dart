// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'epicenter_info.freezed.dart';
part 'epicenter_info.g.dart';

@Freezed()
abstract class EpicenterInfo with _$EpicenterInfo {
  const factory EpicenterInfo({
    required num code,
    required String name,
  }) = _EpicenterInfo;
  
  factory EpicenterInfo.fromJson(Map<String, Object?> json) => _$EpicenterInfoFromJson(json);
}
