import 'package:json_annotation/json_annotation.dart';

enum WsRealtimeOperation {
  @JsonValue('upsert')
  upsert,
  @JsonValue('delete')
  delete,
}
