// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'item2.freezed.dart';
part 'item2.g.dart';

@Freezed()
abstract class Item2 with _$Item2 {
  const factory Item2({
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
    @JsonKey(includeIfNull: false) String? headline,
    @JsonKey(includeIfNull: false) num? resolverDelayMs,
  }) = _Item2;

  factory Item2.fromJson(Map<String, Object?> json) => _$Item2FromJson(json);
}
