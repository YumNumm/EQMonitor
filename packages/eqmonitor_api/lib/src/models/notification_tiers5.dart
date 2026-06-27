// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

import 'tsunami_warning_kind.dart';
import 'interruption_level.dart';

part 'notification_tiers5.freezed.dart';
part 'notification_tiers5.g.dart';

@Freezed()
abstract class NotificationTiers5 with _$NotificationTiers5 {
  const factory NotificationTiers5({
    @JsonKey(name: 'min_warning_kind')
    required TsunamiWarningKind minWarningKind,
    required String sound,
    @JsonKey(name: 'interruption_level')
    required InterruptionLevel interruptionLevel,
  }) = _NotificationTiers5;
  
  factory NotificationTiers5.fromJson(Map<String, Object?> json) => _$NotificationTiers5FromJson(json);
}
