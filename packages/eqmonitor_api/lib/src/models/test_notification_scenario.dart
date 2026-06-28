// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, invalid_annotation_target, unnecessary_import

import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum TestNotificationScenario {
  @JsonValue('EEW_WARNING')
  eewWarning('EEW_WARNING'),
  @JsonValue('EEW_FORECAST')
  eewForecast('EEW_FORECAST'),
  @JsonValue('EEW_CANCEL')
  eewCancel('EEW_CANCEL'),
  @JsonValue('EEW_FINAL')
  eewFinal('EEW_FINAL'),
  @JsonValue('EARTHQUAKE_VXSE51')
  earthquakeVxse51('EARTHQUAKE_VXSE51'),
  @JsonValue('EARTHQUAKE_VXSE52')
  earthquakeVxse52('EARTHQUAKE_VXSE52'),
  @JsonValue('EARTHQUAKE_VXSE53')
  earthquakeVxse53('EARTHQUAKE_VXSE53'),
  @JsonValue('EARTHQUAKE_VXSE53_FAR')
  earthquakeVxse53Far('EARTHQUAKE_VXSE53_FAR'),
  @JsonValue('EARTHQUAKE_VXSE61')
  earthquakeVxse61('EARTHQUAKE_VXSE61'),
  @JsonValue('EARTHQUAKE_VXSE62')
  earthquakeVxse62('EARTHQUAKE_VXSE62'),
  @JsonValue('EARTHQUAKE_VZSE40')
  earthquakeVzse40('EARTHQUAKE_VZSE40'),
  @JsonValue('SHAKE_DETECTION')
  shakeDetection('SHAKE_DETECTION'),
  @JsonValue('TSUNAMI_MAJOR_WARNING')
  tsunamiMajorWarning('TSUNAMI_MAJOR_WARNING'),
  @JsonValue('TSUNAMI_WARNING')
  tsunamiWarning('TSUNAMI_WARNING'),
  @JsonValue('TSUNAMI_ADVISORY')
  tsunamiAdvisory('TSUNAMI_ADVISORY'),
  @JsonValue('TSUNAMI_GRADE_UP')
  tsunamiGradeUp('TSUNAMI_GRADE_UP'),
  @JsonValue('TSUNAMI_GRADE_DOWN')
  tsunamiGradeDown('TSUNAMI_GRADE_DOWN'),
  @JsonValue('TSUNAMI_CLEARED')
  tsunamiCleared('TSUNAMI_CLEARED'),
  @JsonValue('TSUNAMI_ALL_CLEARED')
  tsunamiAllCleared('TSUNAMI_ALL_CLEARED'),
  @JsonValue('TSUNAMI_CANCELED')
  tsunamiCanceled('TSUNAMI_CANCELED'),
  @JsonValue('TSUNAMI_FIRST_WAVE')
  tsunamiFirstWave('TSUNAMI_FIRST_WAVE'),
  @JsonValue('TSUNAMI_MAX_HEIGHT_UPDATE')
  tsunamiMaxHeightUpdate('TSUNAMI_MAX_HEIGHT_UPDATE'),
  @JsonValue('TSUNAMI_OFFSHORE')
  tsunamiOffshore('TSUNAMI_OFFSHORE');

  const TestNotificationScenario(this.json);

  final String? json;
  String toJson() {
    final value = json;
    if (value == null) {
      throw StateError('Cannot convert enum value with null JSON representation to String. '
          'This usually happens for \$unknown or @JsonValue(null) entries.');
    }
    return value as String;
  }

  @override
  String toString() => json?.toString() ?? super.toString();
}
