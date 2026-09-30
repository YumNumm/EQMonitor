import 'package:freezed_annotation/freezed_annotation.dart';

part 'prepared_notification_sound.freezed.dart';
part 'prepared_notification_sound.g.dart';

@freezed
abstract class PreparedNotificationSound with _$PreparedNotificationSound {
  const factory({required String id, required int durationMs}) =
      _PreparedNotificationSound;

  factory fromJson(Map<String, dynamic> json) =>
      _$PreparedNotificationSoundFromJson(json);
}
