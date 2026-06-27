// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_tiers5.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationTiers5 _$NotificationTiers5FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      '_NotificationTiers5',
      json,
      ($checkedConvert) {
        final val = _NotificationTiers5(
          minWarningKind: $checkedConvert(
            'min_warning_kind',
            (v) => $enumDecode(_$TsunamiWarningKindEnumMap, v),
          ),
          sound: $checkedConvert('sound', (v) => v as String),
          interruptionLevel: $checkedConvert(
            'interruption_level',
            (v) => $enumDecode(_$InterruptionLevelEnumMap, v),
          ),
        );
        return val;
      },
      fieldKeyMap: const {
        'minWarningKind': 'min_warning_kind',
        'interruptionLevel': 'interruption_level',
      },
    );

Map<String, dynamic> _$NotificationTiers5ToJson(_NotificationTiers5 instance) =>
    <String, dynamic>{
      'min_warning_kind': instance.minWarningKind,
      'sound': instance.sound,
      'interruption_level': instance.interruptionLevel,
    };

const _$TsunamiWarningKindEnumMap = {
  TsunamiWarningKind.majorWarning: 'MAJOR_WARNING',
  TsunamiWarningKind.warning: 'WARNING',
  TsunamiWarningKind.warningCancel: 'WARNING_CANCEL',
  TsunamiWarningKind.advisory: 'ADVISORY',
  TsunamiWarningKind.advisoryCancel: 'ADVISORY_CANCEL',
  TsunamiWarningKind.forecast: 'FORECAST',
  TsunamiWarningKind.none: 'NONE',
};

const _$InterruptionLevelEnumMap = {
  InterruptionLevel.passive: 'passive',
  InterruptionLevel.active: 'active',
  InterruptionLevel.timeSensitive: 'time_sensitive',
  InterruptionLevel.critical: 'critical',
};
