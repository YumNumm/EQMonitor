import 'dart:convert';

import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

enum TestNotificationKind { silent, normal, critical }

enum TestScenarioType {
  eewWarning,
  eewForecast,
  eewCancel,
  eewFinal,
  earthquakeVxse51,
  earthquakeVxse52,
  earthquakeVxse53,
  earthquakeVxse53Far,
  earthquakeVxse61,
  earthquakeVxse62,
  earthquakeVzse40,
  shakeDetection,
  tsunamiMajorWarning,
  tsunamiWarning,
  tsunamiAdvisory,
  tsunamiGradeUp,
  tsunamiGradeDown,
  tsunamiCleared,
  tsunamiAllCleared,
  tsunamiCanceled,
  tsunamiFirstWave,
  tsunamiMaxHeightUpdate,
  tsunamiOffshore,
}

extension TestNotificationKindDisplay on TestNotificationKind {
  String get displayLabel => switch (this) {
    .silent => 'サイレント',
    .normal => '通常',
    .critical => 'クリティカル',
  };
}

extension TestScenarioTypeDisplay on TestScenarioType {
  String get displayLabel => switch (this) {
    .eewWarning => 'EEW_WARNING',
    .eewForecast => 'EEW_FORECAST',
    .eewCancel => 'EEW_CANCEL',
    .eewFinal => 'EEW_FINAL',
    .earthquakeVxse51 => 'EARTHQUAKE_VXSE51',
    .earthquakeVxse52 => 'EARTHQUAKE_VXSE52',
    .earthquakeVxse53 => 'EARTHQUAKE_VXSE53',
    .earthquakeVxse53Far => 'EARTHQUAKE_VXSE53_FAR',
    .earthquakeVxse61 => 'EARTHQUAKE_VXSE61',
    .earthquakeVxse62 => 'EARTHQUAKE_VXSE62',
    .earthquakeVzse40 => 'EARTHQUAKE_VZSE40',
    .shakeDetection => 'SHAKE_DETECTION',
    .tsunamiMajorWarning => 'TSUNAMI_MAJOR_WARNING',
    .tsunamiWarning => 'TSUNAMI_WARNING',
    .tsunamiAdvisory => 'TSUNAMI_ADVISORY',
    .tsunamiGradeUp => 'TSUNAMI_GRADE_UP',
    .tsunamiGradeDown => 'TSUNAMI_GRADE_DOWN',
    .tsunamiCleared => 'TSUNAMI_CLEARED',
    .tsunamiAllCleared => 'TSUNAMI_ALL_CLEARED',
    .tsunamiCanceled => 'TSUNAMI_CANCELED',
    .tsunamiFirstWave => 'TSUNAMI_FIRST_WAVE',
    .tsunamiMaxHeightUpdate => 'TSUNAMI_MAX_HEIGHT_UPDATE',
    .tsunamiOffshore => 'TSUNAMI_OFFSHORE',
  };
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

extension TestScenarioTypeApiExtension on TestScenarioType {
  api.TestScenarioTypeRequest get toApiRequest => api.TestScenarioTypeRequest(
    scenario: switch (this) {
      .eewWarning => .eewWarning,
      .eewForecast => .eewForecast,
      .eewCancel => .eewCancel,
      .eewFinal => .eewFinal,
      .earthquakeVxse51 => .earthquakeVxse51,
      .earthquakeVxse52 => .earthquakeVxse52,
      .earthquakeVxse53 => .earthquakeVxse53,
      .earthquakeVxse53Far => .earthquakeVxse53Far,
      .earthquakeVxse61 => .earthquakeVxse61,
      .earthquakeVxse62 => .earthquakeVxse62,
      .earthquakeVzse40 => .earthquakeVzse40,
      .shakeDetection => .shakeDetection,
      .tsunamiMajorWarning => .tsunamiMajorWarning,
      .tsunamiWarning => .tsunamiWarning,
      .tsunamiAdvisory => .tsunamiAdvisory,
      .tsunamiGradeUp => .tsunamiGradeUp,
      .tsunamiGradeDown => .tsunamiGradeDown,
      .tsunamiCleared => .tsunamiCleared,
      .tsunamiAllCleared => .tsunamiAllCleared,
      .tsunamiCanceled => .tsunamiCanceled,
      .tsunamiFirstWave => .tsunamiFirstWave,
      .tsunamiMaxHeightUpdate => .tsunamiMaxHeightUpdate,
      .tsunamiOffshore => .tsunamiOffshore,
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

class TestScenarioTypeDeliveryResult {
  const TestScenarioTypeDeliveryResult({
    required this.message,
    required this.scenario,
    required this.eventId,
    required this.prettyJson,
  });

  final String message;
  final String scenario;
  final String eventId;
  final String prettyJson;
}

extension TestScenarioDeliveryResultApiExtension on api.TestScenarioResponse {
  TestScenarioDeliveryResult get toTestScenarioDeliveryResult =>
      TestScenarioDeliveryResult(
        eventId: eventId,
        stepsPlanned: stepsPlanned.toInt(),
        telegramTypes: telegramTypes,
      );
}

extension TestScenarioTypeDeliveryResultApiExtension
    on api.TestScenarioTypeResponse {
  TestScenarioTypeDeliveryResult get toTestScenarioTypeDeliveryResult =>
      TestScenarioTypeDeliveryResult(
        message: message,
        scenario: scenario,
        eventId: eventId,
        prettyJson: const JsonEncoder.withIndent('  ').convert(toJson()),
      );
}
