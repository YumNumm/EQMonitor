import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_token.freezed.dart';
part 'notification_token.g.dart';

@freezed
abstract class NotificationToken with _$NotificationToken {
  const factory({
    String? fcmToken,
    String? apnsToken,
    String? apnsPushToStartToken,
  }) = _NotificationToken;

  factory fromJson(Map<String, dynamic> json) =>
      _$NotificationTokenFromJson(json);
}
