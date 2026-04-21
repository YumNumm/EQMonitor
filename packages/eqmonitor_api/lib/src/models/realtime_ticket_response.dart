// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

part 'realtime_ticket_response.freezed.dart';
part 'realtime_ticket_response.g.dart';

@Freezed()
abstract class RealtimeTicketResponse with _$RealtimeTicketResponse {
  const factory RealtimeTicketResponse({
    required String url,
  }) = _RealtimeTicketResponse;
  
  factory RealtimeTicketResponse.fromJson(Map<String, Object?> json) => _$RealtimeTicketResponseFromJson(json);
}
