// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, type=warning, duplicate_ignore, unused_element_parameter

part of 'test_scenario_type_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TestScenarioTypeRequest _$TestScenarioTypeRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_TestScenarioTypeRequest', json, ($checkedConvert) {
  final val = _TestScenarioTypeRequest(
    scenario: $checkedConvert(
      'scenario',
      (v) => $enumDecode(_$TestNotificationScenarioEnumMap, v),
    ),
  );
  return val;
});

Map<String, dynamic> _$TestScenarioTypeRequestToJson(
  _TestScenarioTypeRequest instance,
) => <String, dynamic>{'scenario': instance.scenario};

const _$TestNotificationScenarioEnumMap = {
  TestNotificationScenario.eewWarning: 'EEW_WARNING',
  TestNotificationScenario.eewForecast: 'EEW_FORECAST',
  TestNotificationScenario.eewCancel: 'EEW_CANCEL',
  TestNotificationScenario.eewFinal: 'EEW_FINAL',
  TestNotificationScenario.earthquakeVxse51: 'EARTHQUAKE_VXSE51',
  TestNotificationScenario.earthquakeVxse52: 'EARTHQUAKE_VXSE52',
  TestNotificationScenario.earthquakeVxse53: 'EARTHQUAKE_VXSE53',
  TestNotificationScenario.earthquakeVxse53Far: 'EARTHQUAKE_VXSE53_FAR',
  TestNotificationScenario.earthquakeVxse61: 'EARTHQUAKE_VXSE61',
  TestNotificationScenario.earthquakeVxse62: 'EARTHQUAKE_VXSE62',
  TestNotificationScenario.earthquakeVzse40: 'EARTHQUAKE_VZSE40',
  TestNotificationScenario.shakeDetection: 'SHAKE_DETECTION',
  TestNotificationScenario.tsunamiMajorWarning: 'TSUNAMI_MAJOR_WARNING',
  TestNotificationScenario.tsunamiWarning: 'TSUNAMI_WARNING',
  TestNotificationScenario.tsunamiAdvisory: 'TSUNAMI_ADVISORY',
  TestNotificationScenario.tsunamiGradeUp: 'TSUNAMI_GRADE_UP',
  TestNotificationScenario.tsunamiGradeDown: 'TSUNAMI_GRADE_DOWN',
  TestNotificationScenario.tsunamiCleared: 'TSUNAMI_CLEARED',
  TestNotificationScenario.tsunamiAllCleared: 'TSUNAMI_ALL_CLEARED',
  TestNotificationScenario.tsunamiCanceled: 'TSUNAMI_CANCELED',
  TestNotificationScenario.tsunamiFirstWave: 'TSUNAMI_FIRST_WAVE',
  TestNotificationScenario.tsunamiMaxHeightUpdate: 'TSUNAMI_MAX_HEIGHT_UPDATE',
  TestNotificationScenario.tsunamiOffshore: 'TSUNAMI_OFFSHORE',
};
