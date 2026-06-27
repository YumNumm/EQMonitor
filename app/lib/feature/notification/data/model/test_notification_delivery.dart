import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_notification_delivery.freezed.dart';

enum TestNotificationKind {
  silent,
  normal,
  critical,
}

@freezed
abstract class TestNotificationDeliveryResult
    with _$TestNotificationDeliveryResult {
  const factory TestNotificationDeliveryResult({
    required String message,
    required TestNotificationFramework framework,
  }) = _TestNotificationDeliveryResult;
}

enum TestNotificationFramework {
  fcm,
  apns,
}

extension TestNotificationFrameworkDisplay on TestNotificationFramework {
  String get displayLabel => switch (this) {
    .fcm => 'FCM',
    .apns => 'APNs',
  };
}

extension TestNotificationKindDisplay on TestNotificationKind {
  String get displayLabel => switch (this) {
    .silent => 'Silent',
    .normal => 'Normal',
    .critical => 'Critical',
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

extension TestNotificationKindApiExtension on TestNotificationKind {
  api.TestNotificationRequest get toApiRequest => api.TestNotificationRequest(
    type: switch (this) {
      .silent => .silent,
      .normal => .normal,
      .critical => .critical,
    },
  );
}

/// テストシナリオ実行結果
class TestScenarioDeliveryResult {
  const TestScenarioDeliveryResult({
    required this.eventId,
    required this.stepsPlanned,
    required this.telegramTypes,
  });

  final String eventId;
  final int stepsPlanned;
  final List<String> telegramTypes;
}

extension TestScenarioDeliveryResultApiExtension on api.TestScenarioResponse {
  TestScenarioDeliveryResult get toTestScenarioDeliveryResult =>
      TestScenarioDeliveryResult(
        eventId: eventId,
        stepsPlanned: stepsPlanned.toInt(),
        telegramTypes: telegramTypes,
      );
}
