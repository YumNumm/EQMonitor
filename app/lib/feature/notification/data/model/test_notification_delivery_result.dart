import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_notification_delivery_result.freezed.dart';

@freezed
abstract class TestNotificationDeliveryResult
    with _$TestNotificationDeliveryResult {
  const factory({
    required String message,
    required TestNotificationFramework framework,
  }) = _TestNotificationDeliveryResult;
}

enum TestNotificationFramework { fcm, apns }

extension TestNotificationFrameworkDisplay on TestNotificationFramework {
  String get displayLabel => switch (this) {
    .fcm => 'FCM',
    .apns => 'APNs',
  };
}

extension TestNotificationDeliveryResultApiExtension
    on api.TestNotificationResponse {
  TestNotificationDeliveryResult get toTestNotificationDeliveryResult =>
      TestNotificationDeliveryResult(
        message: message,
        framework: switch (framework) {
          .fcm => .fcm,
          .apns => .apns,
        },
      );
}
