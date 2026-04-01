// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_hypocenter.dart';
import 'event_type.dart';
import 'prefectures.dart';
import 'regions.dart';

part 'event_message.freezed.dart';
part 'event_message.g.dart';

@Freezed()
abstract class EventMessage with _$EventMessage {
  const factory EventMessage({
    required String eventId,
    required EventType type,
    required num serialNo,
    required List<Regions> regions,
    required String reportTime,
    @JsonKey(includeIfNull: false)
    String? maxIntensity,
    @JsonKey(includeIfNull: false)
    String? headline,
    @JsonKey(includeIfNull: false)
    String? originTime,
    @JsonKey(includeIfNull: false)
    String? arrivalTime,
    @JsonKey(includeIfNull: false)
    EventHypocenter? hypocenter,
    @JsonKey(includeIfNull: false)
    num? magnitude,
    @JsonKey(includeIfNull: false)
    bool? isWarning,
    @JsonKey(includeIfNull: false)
    bool? isLastInfo,
    @JsonKey(includeIfNull: false)
    bool? isCancel,
    @JsonKey(includeIfNull: false)
    String? hypocenterReduceName,
    @JsonKey(includeIfNull: false)
    bool? hasWarningZones,
    @JsonKey(includeIfNull: false)
    bool? isPlum,
    @JsonKey(includeIfNull: false)
    bool? isLevel,
    @JsonKey(includeIfNull: false)
    bool? isOnePoint,
    @JsonKey(includeIfNull: false)
    String? comment,
    @JsonKey(includeIfNull: false)
    List<Prefectures>? prefectures,
  }) = _EventMessage;
  
  factory EventMessage.fromJson(Map<String, Object?> json) => _$EventMessageFromJson(json);
}
