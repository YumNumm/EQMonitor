// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum Type {
  @JsonValue('NOTIFICATION')
  notification('NOTIFICATION'),
  @JsonValue('LIVE_ACTIVITY_START')
  liveActivityStart('LIVE_ACTIVITY_START');

  const Type(this.json);

  final dynamic json;

  dynamic toJson() => json;

  @override
  String toString() => json?.toString() ?? super.toString();
}
