// ignore_for_file: unnecessary_type_name_in_constructor

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unified_eew.freezed.dart';

@freezed
abstract class UnifiedEewLocation with _$UnifiedEewLocation {
  const UnifiedEewLocation._();

  const factory UnifiedEewLocation({
    required String regionName,
    required JmaIntensity? forecastIntensity,
    required JmaLpgmIntensity? forecastLpgmIntensity,
    required DateTime? arrivalTime,
    required bool? isPlum,
    required bool? isWarning,
  }) = _UnifiedEewLocation;

  factory UnifiedEewLocation.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(json, label: 'eew.location');
    final intensity = reader.optionalNonNullString('forecastIntensity');
    final lpgm = reader.optionalNonNullString('forecastLpgmIntensity');
    final isPlum = reader.optionalNonNullBool('isPlum');
    if (isPlum == false) {
      throw const FormatException('eew.location.isPlum は true のみ指定できます');
    }
    return UnifiedEewLocation(
      regionName: reader.requiredString('regionName'),
      forecastIntensity: intensity == null
          ? null
          : UnifiedLiveActivityWire.intensityFromJson(intensity),
      forecastLpgmIntensity: lpgm == null
          ? null
          : UnifiedLiveActivityWire.lpgmFromJson(lpgm),
      arrivalTime: reader.optionalNonNullDateTime('arrivalTime'),
      isPlum: isPlum,
      isWarning: reader.optionalNonNullBool('isWarning'),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'regionName': regionName,
    if (forecastIntensity case final value?)
      'forecastIntensity': UnifiedLiveActivityWire.intensityToJson(value),
    if (forecastLpgmIntensity case final value?)
      'forecastLpgmIntensity': UnifiedLiveActivityWire.lpgmToJson(value),
    if (arrivalTime case final value?)
      'arrivalTime': UnifiedLiveActivityWire.dateTimeToJson(value),
    if (isPlum != null) 'isPlum': isPlum,
    if (isWarning != null) 'isWarning': isWarning,
  };
}

@freezed
abstract class UnifiedEew with _$UnifiedEew {
  const UnifiedEew._();

  const factory UnifiedEew({
    required String eventId,
    required String headline,
    required String? hypocenterName,
    required double? magnitude,
    required double? depth,
    required DateTime? time,
    required bool isOriginTime,
    required JmaIntensity? maxIntensity,
    required int serialNo,
    required bool isFinal,
    required bool isWarning,
    required bool isCanceled,
    required bool isPlum,
    required bool isLevel,
    required bool isOnePoint,
    required DateTime issuedAt,
    required UnifiedEewLocation? location,
  }) = _UnifiedEew;

  factory UnifiedEew.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(json, label: 'eew');
    final maxIntensity = reader.requiredNullableString('maxIntensity');
    final location = reader.requiredNullableMap('location');
    return UnifiedEew(
      eventId: reader.requiredString('eventId', nonEmpty: true),
      headline: reader.requiredString('headline'),
      hypocenterName: reader.requiredNullableString('hypocenterName'),
      magnitude: reader.requiredNullableFiniteDouble('magnitude'),
      depth: reader.requiredNullableFiniteDouble('depth'),
      time: reader.requiredNullableDateTime('time'),
      isOriginTime: reader.requiredBool('isOriginTime'),
      maxIntensity: maxIntensity == null
          ? null
          : UnifiedLiveActivityWire.intensityFromJson(maxIntensity),
      serialNo: reader.requiredInt('serialNo', minimum: 0),
      isFinal: reader.requiredBool('isFinal'),
      isWarning: reader.requiredBool('isWarning'),
      isCanceled: reader.requiredBool('isCanceled'),
      isPlum: reader.requiredBool('isPlum'),
      isLevel: reader.requiredBool('isLevel'),
      isOnePoint: reader.requiredBool('isOnePoint'),
      issuedAt: reader.requiredDateTime('issuedAt'),
      location: location == null ? null : UnifiedEewLocation.fromJson(location),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'eventId': eventId,
    'headline': headline,
    'hypocenterName': hypocenterName,
    'magnitude': magnitude,
    'depth': depth,
    'time': switch (time) {
      final value? => UnifiedLiveActivityWire.dateTimeToJson(value),
      null => null,
    },
    'isOriginTime': isOriginTime,
    'maxIntensity': switch (maxIntensity) {
      final value? => UnifiedLiveActivityWire.intensityToJson(value),
      null => null,
    },
    'serialNo': serialNo,
    'isFinal': isFinal,
    'isWarning': isWarning,
    'isCanceled': isCanceled,
    'isPlum': isPlum,
    'isLevel': isLevel,
    'isOnePoint': isOnePoint,
    'issuedAt': UnifiedLiveActivityWire.dateTimeToJson(issuedAt),
    'location': location?.toJson(),
  };
}
