// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'estimated_intensity_hypocenter.dart';

part 'estimated_intensity_event.freezed.dart';
part 'estimated_intensity_event.g.dart';

@Freezed()
abstract class EstimatedIntensityEvent with _$EstimatedIntensityEvent {
  const factory EstimatedIntensityEvent({
    required String eventId,
    required String estimatedIntensityKey,
    required String createdAt,
    @JsonKey(includeIfNull: false)
    EstimatedIntensityHypocenter? hypocenter,
  }) = _EstimatedIntensityEvent;

  factory EstimatedIntensityEvent.fromJson(Map<String, Object?> json) => _$EstimatedIntensityEventFromJson(json);
}
