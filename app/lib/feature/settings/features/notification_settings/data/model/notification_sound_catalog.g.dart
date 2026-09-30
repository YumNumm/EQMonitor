// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'notification_sound_catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSoundCatalog _$NotificationSoundCatalogFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_NotificationSoundCatalog', json, ($checkedConvert) {
  final val = _NotificationSoundCatalog(
    sounds: $checkedConvert(
      'sounds',
      (v) => (v as List<dynamic>)
          .map(
            (e) => CustomNotificationSound.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$NotificationSoundCatalogToJson(
  _NotificationSoundCatalog instance,
) => <String, dynamic>{'sounds': instance.sounds};
