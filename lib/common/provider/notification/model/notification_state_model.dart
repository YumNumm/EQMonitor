import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_state_model.freezed.dart';
part 'notification_state_model.g.dart';

@freezed
class NotificationStateModel with _$NotificationStateModel {
  const factory NotificationStateModel({
    /// 通知権限が許可されているかどうか
    @Default(false) bool isAccepted,

    /// 通知権限要求ダイアログを今後表示しないかどうか
    @Default(false) bool neverShowNotificationPermissionDialog,

    /// FCM Token
    String? fcmToken,
  }) = _NotificationStateModel;

  factory NotificationStateModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationStateModelFromJson(json);
}
