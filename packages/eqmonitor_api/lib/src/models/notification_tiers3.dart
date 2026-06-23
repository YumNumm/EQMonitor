// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'min_jma_intensity.dart';
import 'interruption_level.dart';

part 'notification_tiers3.freezed.dart';
part 'notification_tiers3.g.dart';

@Freezed()
abstract class NotificationTiers3 with _$NotificationTiers3 {
  const factory NotificationTiers3({
    @JsonKey(name: 'min_jma_intensity')
    required MinJmaIntensity minJmaIntensity,
    required String sound,
    @JsonKey(name: 'interruption_level')
    required InterruptionLevel interruptionLevel,
  }) = _NotificationTiers3;

  factory NotificationTiers3.fromJson(Map<String, Object?> json) =>
      _$NotificationTiers3FromJson(json);
}
