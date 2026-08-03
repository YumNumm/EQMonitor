// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'realtime_tsunami_delete_payload_operation.dart';
import 'realtime_tsunami_delete_payload_type.dart';

part 'realtime_tsunami_delete_payload.freezed.dart';
part 'realtime_tsunami_delete_payload.g.dart';

@Freezed()
abstract class RealtimeTsunamiDeletePayload with _$RealtimeTsunamiDeletePayload {
  const factory RealtimeTsunamiDeletePayload({
    required RealtimeTsunamiDeletePayloadType type,
    required RealtimeTsunamiDeletePayloadOperation operation,
    @JsonKey(name: 'event_id')
    required String eventId,
    @JsonKey(includeIfNull: false,name: 'group_id')
    String? groupId,
  }) = _RealtimeTsunamiDeletePayload;

  factory RealtimeTsunamiDeletePayload.fromJson(Map<String, Object?> json) => _$RealtimeTsunamiDeletePayloadFromJson(json);
}
