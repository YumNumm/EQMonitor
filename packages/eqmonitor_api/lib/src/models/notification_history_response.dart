// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'notification_log_item.dart';

part 'notification_history_response.freezed.dart';
part 'notification_history_response.g.dart';

@Freezed()
abstract class NotificationHistoryResponse with _$NotificationHistoryResponse {
  const factory NotificationHistoryResponse({
    required List<NotificationLogItem> items,
    @JsonKey(includeIfNull: false, name: 'next_cursor') String? nextCursor,
  }) = _NotificationHistoryResponse;

  factory NotificationHistoryResponse.fromJson(Map<String, Object?> json) =>
      _$NotificationHistoryResponseFromJson(json);
}
