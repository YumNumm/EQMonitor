import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_sound_inspection.freezed.dart';
part 'notification_sound_inspection.g.dart';

@freezed
abstract class NotificationSoundInspection with _$NotificationSoundInspection {
  @JsonSerializable(fieldRename: FieldRename.none)
  const factory({required String sourceDisplayName, required int durationMs}) =
      _NotificationSoundInspection;

  factory fromJson(Map<String, dynamic> json) =>
      _$NotificationSoundInspectionFromJson(json);
}
