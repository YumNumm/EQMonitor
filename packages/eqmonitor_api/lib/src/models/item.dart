// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.freezed.dart';
part 'item.g.dart';

@Freezed()
abstract class Item with _$Item {
  const factory Item({
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
    @JsonKey(includeIfNull: false) String? headline,
    @JsonKey(includeIfNull: false) num? resolverDelayMs,
    @JsonKey(includeIfNull: false) String? proxyReceivedAt,
    @JsonKey(includeIfNull: false) String? resolverDoneAt,
    @JsonKey(includeIfNull: false) String? sendStartedAt,
    @JsonKey(includeIfNull: false) String? sendCompletedAt,
  }) = _Item;

  factory Item.fromJson(Map<String, Object?> json) => _$ItemFromJson(json);
}
