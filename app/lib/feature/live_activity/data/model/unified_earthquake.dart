// ignore_for_file: unnecessary_type_name_in_constructor

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/live_activity/data/model/unified_live_activity_json_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unified_earthquake.freezed.dart';

enum UnifiedLiveActivityInformationType { vxse51, vxse52, vxse53, ixac41 }

extension UnifiedLiveActivityInformationTypeWire
    on UnifiedLiveActivityInformationType {
  String get wireName => switch (this) {
    .vxse51 => 'VXSE51',
    .vxse52 => 'VXSE52',
    .vxse53 => 'VXSE53',
    .ixac41 => 'IXAC41',
  };

  static UnifiedLiveActivityInformationType fromJson(String value) =>
      switch (value) {
        'VXSE51' => .vxse51,
        'VXSE52' => .vxse52,
        'VXSE53' => .vxse53,
        'IXAC41' => .ixac41,
        _ => throw FormatException('情報種別が不正です: $value'),
      };
}

@freezed
abstract class UnifiedEarthquakeLocation with _$UnifiedEarthquakeLocation {
  const UnifiedEarthquakeLocation._();

  const factory UnifiedEarthquakeLocation({
    required String regionName,
    required JmaIntensity? maxIntensity,
  }) = _UnifiedEarthquakeLocation;

  factory UnifiedEarthquakeLocation.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(
      json,
      label: 'earthquake.location',
    );
    final maxIntensity = reader.requiredNullableString('maxIntensity');
    return UnifiedEarthquakeLocation(
      regionName: reader.requiredString('regionName'),
      maxIntensity: maxIntensity == null
          ? null
          : UnifiedLiveActivityWire.intensityFromJson(maxIntensity),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'regionName': regionName,
    'maxIntensity': switch (maxIntensity) {
      final value? => UnifiedLiveActivityWire.intensityToJson(value),
      null => null,
    },
  };
}

@freezed
abstract class UnifiedEarthquake with _$UnifiedEarthquake {
  const UnifiedEarthquake._();

  const factory UnifiedEarthquake({
    required String eventId,
    required String headline,
    required List<UnifiedLiveActivityInformationType> informationType,
    required DateTime issuedAt,
    required bool isCanceled,
    required String? hypocenterName,
    required EarthquakeMagnitude? magnitude,
    required double? depth,
    required DateTime? originTime,
    required JmaIntensity? maxIntensity,
    required UnifiedEarthquakeLocation? location,
  }) = _UnifiedEarthquake;

  factory UnifiedEarthquake.fromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(json, label: 'earthquake');
    final magnitude = reader.requiredNullableMap('magnitude');
    final maxIntensity = reader.requiredNullableString('maxIntensity');
    final location = reader.requiredNullableMap('location');
    return UnifiedEarthquake(
      eventId: reader.requiredString('eventId', nonEmpty: true),
      headline: reader.requiredString('headline'),
      informationType: reader
          .requiredStringList('informationType')
          .map(UnifiedLiveActivityInformationTypeWire.fromJson)
          .toList(growable: false),
      issuedAt: reader.requiredDateTime('issuedAt'),
      isCanceled: reader.requiredBool('isCanceled'),
      hypocenterName: reader.requiredNullableString('hypocenterName'),
      magnitude: magnitude == null ? null : magnitudeFromJson(magnitude),
      depth: reader.requiredNullableFiniteDouble('depth'),
      originTime: reader.requiredNullableDateTime('originTime'),
      maxIntensity: maxIntensity == null
          ? null
          : UnifiedLiveActivityWire.intensityFromJson(maxIntensity),
      location: location == null
          ? null
          : UnifiedEarthquakeLocation.fromJson(location),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'eventId': eventId,
    'headline': headline,
    'informationType': informationType.map((value) => value.wireName).toList(),
    'issuedAt': UnifiedLiveActivityWire.dateTimeToJson(issuedAt),
    'isCanceled': isCanceled,
    'hypocenterName': hypocenterName,
    'magnitude': switch (magnitude) {
      final value? => magnitudeToJson(value),
      null => null,
    },
    'depth': depth,
    'originTime': switch (originTime) {
      final value? => UnifiedLiveActivityWire.dateTimeToJson(value),
      null => null,
    },
    'maxIntensity': switch (maxIntensity) {
      final value? => UnifiedLiveActivityWire.intensityToJson(value),
      null => null,
    },
    'location': location?.toJson(),
  };

  static EarthquakeMagnitude magnitudeFromJson(Map<String, dynamic> json) {
    final reader = UnifiedLiveActivityJsonReader(
      json,
      label: 'earthquake.magnitude',
    );
    final type = reader.requiredString('type');
    switch (type) {
      case 'NORMAL':
        reader.requireOnlyKeys(const {'type', 'value'});
        return EarthquakeMagnitude.value(
          value: reader.requiredFiniteDouble('value'),
        );
      case 'UNKNOWN':
        reader.requireOnlyKeys(const {'type'});
        return const EarthquakeMagnitude.unknown();
      case 'OVER_M8':
        reader.requireOnlyKeys(const {'type'});
        return const EarthquakeMagnitude.overM8();
      default:
        throw FormatException('マグニチュード種別が不正です: $type');
    }
  }

  static Map<String, dynamic> magnitudeToJson(EarthquakeMagnitude magnitude) =>
      switch (magnitude) {
        EarthquakeMagnitudeValue(:final value) => <String, dynamic>{
          'type': 'NORMAL',
          'value': value,
        },
        EarthquakeMagnitudeUnknown() => <String, dynamic>{'type': 'UNKNOWN'},
        EarthquakeMagnitudeOverM8() => <String, dynamic>{'type': 'OVER_M8'},
      };
}
