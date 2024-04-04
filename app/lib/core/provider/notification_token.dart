import 'package:eqmonitor/core/provider/firebase/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_token.freezed.dart';
part 'notification_token.g.dart';

@riverpod
Future<NotificationTokenModel> notificationToken(
  NotificationTokenRef ref,
) async {
  if (kIsWeb) {
    throw UnimplementedError();
  }
  final messaging = ref.watch(firebaseMessagingProvider);
  final results = await (
    messaging.getAPNSToken(),
    messaging.getToken(),
  ).wait;

  return NotificationTokenModel(
    apnsToken: results.$1,
    fcmToken: results.$2,
  );
}

@freezed
class NotificationTokenModel with _$NotificationTokenModel {
  const factory NotificationTokenModel({
    required String? fcmToken,
    required String? apnsToken,
  }) = _NotificationTokenModel;

  factory NotificationTokenModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationTokenModelFromJson(json);
}
