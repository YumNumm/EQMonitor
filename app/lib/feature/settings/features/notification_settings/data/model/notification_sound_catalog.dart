import 'package:eqmonitor/feature/settings/features/notification_settings/data/model/custom_notification_sound.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_sound_catalog.freezed.dart';
part 'notification_sound_catalog.g.dart';

@freezed
abstract class NotificationSoundCatalog with _$NotificationSoundCatalog {
  const factory({required List<CustomNotificationSound> sounds}) =
      _NotificationSoundCatalog;

  factory fromJson(Map<String, dynamic> json) =>
      _$NotificationSoundCatalogFromJson(json);
}
