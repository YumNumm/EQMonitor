import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_notification_status_model.freezed.dart';

@freezed
class FirebaseCloudMessagingModel with _$FirebaseCloudMessagingModel {
  const factory FirebaseCloudMessagingModel({
    /// FCM Token
    required String? token,

    // FCM Tokenが取得できたかどうか
    required bool hasToken,
  }) = _FirebaseCloudMessagingModel;
}
