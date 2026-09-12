// ignore_for_file: unnecessary_type_name_in_constructor

import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_json_converter.dart';
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_level.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unified_shake_detection.freezed.dart';

enum UnifiedShakeDetectionStatus { active, ended }

@freezed
abstract class UnifiedShakeDetectionLocation
    with _$UnifiedShakeDetectionLocation {
  const UnifiedShakeDetectionLocation._();

  const factory UnifiedShakeDetectionLocation({
    required String name,
    required ShakeDetectionLevel level,
  }) = _UnifiedShakeDetectionLocation;

  factory UnifiedShakeDetectionLocation.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(
      json,
      label: 'shakeDetection.location',
    );
    return UnifiedShakeDetectionLocation(
      name: reader.requiredString('name'),
      level: UnifiedLiveActivityWire.shakeLevelFromJson(
        reader.requiredString('level'),
      ),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'name': name,
    'level': UnifiedLiveActivityWire.shakeLevelToJson(level),
  };
}

@freezed
abstract class UnifiedShakeDetection with _$UnifiedShakeDetection {
  const UnifiedShakeDetection._();

  const factory UnifiedShakeDetection({
    required String headline,
    required DateTime detectedAt,
    required DateTime updatedAt,
    required ShakeDetectionLevel level,
    required UnifiedShakeDetectionStatus status,
    required UnifiedShakeDetectionLocation? location,
  }) = _UnifiedShakeDetection;

  factory UnifiedShakeDetection.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(json, label: 'shakeDetection');
    final location = reader.requiredNullableMap('location');
    return UnifiedShakeDetection(
      headline: reader.requiredString('headline'),
      detectedAt: reader.requiredDateTime('detectedAt'),
      updatedAt: reader.requiredDateTime('updatedAt'),
      level: UnifiedLiveActivityWire.shakeLevelFromJson(
        reader.requiredString('level'),
      ),
      status: switch (reader.requiredString('status')) {
        'active' => .active,
        'ended' => .ended,
        final value => throw FormatException('揺れ検知状態が不正です: $value'),
      },
      location: location == null
          ? null
          : UnifiedShakeDetectionLocation.fromJson(location),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'headline': headline,
    'detectedAt': UnifiedLiveActivityWire.dateTimeToJson(detectedAt),
    'updatedAt': UnifiedLiveActivityWire.dateTimeToJson(updatedAt),
    'level': UnifiedLiveActivityWire.shakeLevelToJson(level),
    'status': status.name,
    'location': location?.toJson(),
  };
}
