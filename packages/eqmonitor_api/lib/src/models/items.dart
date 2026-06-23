// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'items.freezed.dart';
part 'items.g.dart';

@Freezed()
abstract class Items with _$Items {
  const factory Items({
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
    @JsonKey(includeIfNull: false)
    String? headline,
    @JsonKey(includeIfNull: false)
    num? resolverDelayMs,
    @JsonKey(includeIfNull: false)
    String? proxyReceivedAt,
    @JsonKey(includeIfNull: false)
    String? resolverDoneAt,
    @JsonKey(includeIfNull: false)
    String? sendStartedAt,
    @JsonKey(includeIfNull: false)
    String? sendCompletedAt,
  }) = _Items;
  
  factory Items.fromJson(Map<String, Object?> json) => _$ItemsFromJson(json);
}
