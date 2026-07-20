// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum ChangeReasons {
  @JsonValue('new_event')
  newEvent('new_event'),
  @JsonValue('level_up')
  levelUp('level_up'),
  @JsonValue('level_down')
  levelDown('level_down'),
  @JsonValue('region_changed')
  regionChanged('region_changed'),
  @JsonValue('points_changed')
  pointsChanged('points_changed'),
  @JsonValue('point_state_changed')
  pointStateChanged('point_state_changed'),
  @JsonValue('expires_at_extended')
  expiresAtExtended('expires_at_extended'),
  @JsonValue('events_merged')
  eventsMerged('events_merged');

  const ChangeReasons(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
