// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'min_jma_intensity.dart';
import 'interruption_level.dart';

part 'notification_tiers4.freezed.dart';
part 'notification_tiers4.g.dart';

@Freezed()
abstract class NotificationTiers4 with _$NotificationTiers4 {
  const factory NotificationTiers4({
    @JsonKey(name: 'min_jma_intensity')
    required MinJmaIntensity minJmaIntensity,
    required String sound,
    @JsonKey(name: 'interruption_level')
    required InterruptionLevel interruptionLevel,
  }) = _NotificationTiers4;

  factory NotificationTiers4.fromJson(Map<String, Object?> json) =>
      _$NotificationTiers4FromJson(json);
}
