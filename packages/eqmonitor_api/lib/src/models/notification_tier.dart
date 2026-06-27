// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'interruption_level.dart';
import 'min_jma_intensity.dart';

part 'notification_tier.freezed.dart';
part 'notification_tier.g.dart';

@Freezed()
abstract class NotificationTier with _$NotificationTier {
  const factory NotificationTier({
    @JsonKey(name: 'min_jma_intensity')
    required MinJmaIntensity minJmaIntensity,
    required String sound,
    @JsonKey(name: 'interruption_level')
    required InterruptionLevel interruptionLevel,
  }) = _NotificationTier;
  
  factory NotificationTier.fromJson(Map<String, Object?> json) => _$NotificationTierFromJson(json);
}
