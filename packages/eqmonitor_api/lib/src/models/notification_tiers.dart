// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'min_jma_intensity.dart';
import 'interruption_level.dart';

part 'notification_tiers.freezed.dart';
part 'notification_tiers.g.dart';

@Freezed()
abstract class NotificationTiers with _$NotificationTiers {
  const factory NotificationTiers({
    @JsonKey(name: 'min_jma_intensity')
    required MinJmaIntensity minJmaIntensity,
    required String sound,
    @JsonKey(name: 'interruption_level')
    required InterruptionLevel interruptionLevel,
  }) = _NotificationTiers;

  factory NotificationTiers.fromJson(Map<String, Object?> json) =>
      _$NotificationTiersFromJson(json);
}
