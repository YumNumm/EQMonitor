// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'min_jma_intensity.dart';
import 'interruption_level.dart';

part 'notification_tiers2.freezed.dart';
part 'notification_tiers2.g.dart';

@Freezed()
abstract class NotificationTiers2 with _$NotificationTiers2 {
  const factory NotificationTiers2({
    @JsonKey(name: 'min_jma_intensity')
    required MinJmaIntensity minJmaIntensity,
    required String sound,
    @JsonKey(name: 'interruption_level')
    required InterruptionLevel interruptionLevel,
  }) = _NotificationTiers2;

  factory NotificationTiers2.fromJson(Map<String, Object?> json) =>
      _$NotificationTiers2FromJson(json);
}
