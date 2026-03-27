// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'items2.freezed.dart';
part 'items2.g.dart';

@Freezed()
abstract class Items2 with _$Items2 {
  const factory Items2({
    required String correlationKey,
    required String eventType,
    required String eventId,
    required num serialNo,
    required String jmaReportTime,
    required num targetDevices,
    required num enqueuedFcm,
    required num enqueuedApns,
    required num enqueuedBroadcast,
    required num successFcm,
    required num failedFcm,
    required num successApns,
    required num failedApns,
    required String createdAt,
    required String updatedAt,
    @JsonKey(includeIfNull: false)
    String? headline,
    @JsonKey(includeIfNull: false)
    num? resolverDelayMs,
  }) = _Items2;
  
  factory Items2.fromJson(Map<String, Object?> json) => _$Items2FromJson(json);
}
