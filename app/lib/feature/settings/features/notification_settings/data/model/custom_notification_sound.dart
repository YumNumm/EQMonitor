import 'package:freezed_annotation/freezed_annotation.dart';

part 'custom_notification_sound.freezed.dart';
part 'custom_notification_sound.g.dart';

@freezed
abstract class CustomNotificationSound with _$CustomNotificationSound {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory({
    required String id,
    required String displayName,
    required String fileName,
    required int durationMs,
    required DateTime createdAt,
    @Default(true) bool isAvailable,
  }) = _CustomNotificationSound;

  factory fromJson(Map<String, dynamic> json) =>
      _$CustomNotificationSoundFromJson(json);
}
