// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'stored_notification_slots.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StoredNotificationSlots _$StoredNotificationSlotsFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_StoredNotificationSlots', json, ($checkedConvert) {
  final val = _StoredNotificationSlots(
    slots: $checkedConvert(
      'slots',
      (v) => (v as List<dynamic>)
          .map((e) => NotificationSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$StoredNotificationSlotsToJson(
  _StoredNotificationSlots instance,
) => <String, dynamic>{'slots': instance.slots.map((e) => e.toJson()).toList()};
