// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'interruption_level.dart';
import 'tsunami_warning_kind.dart';

part 'tsunami_notification_tier.freezed.dart';
part 'tsunami_notification_tier.g.dart';

@Freezed()
abstract class TsunamiNotificationTier with _$TsunamiNotificationTier {
  const factory TsunamiNotificationTier({
    @JsonKey(name: 'min_warning_kind')
    required TsunamiWarningKind minWarningKind,
    required String sound,
    @JsonKey(name: 'interruption_level')
    required InterruptionLevel interruptionLevel,
  }) = _TsunamiNotificationTier;
  
  factory TsunamiNotificationTier.fromJson(Map<String, Object?> json) => _$TsunamiNotificationTierFromJson(json);
}
