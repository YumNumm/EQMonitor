// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'eew.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EewV1Impl _$$EewV1ImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$EewV1Impl',
      json,
      ($checkedConvert) {
        final val = _$EewV1Impl(
          id: $checkedConvert('id', (v) => (v as num).toInt()),
          eventId: $checkedConvert('event_id', (v) => (v as num).toInt()),
          type: $checkedConvert('type', (v) => v as String),
          schemaType: $checkedConvert('schema_type', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          infoType: $checkedConvert('info_type', (v) => v as String),
          reportTime: $checkedConvert(
              'report_time', (v) => DateTime.parse(v as String)),
          serialNo: $checkedConvert('serial_no', (v) => (v as num?)?.toInt()),
          headline: $checkedConvert('headline', (v) => v as String?),
          isCanceled: $checkedConvert('is_canceled', (v) => v as bool),
          isWarning: $checkedConvert('is_warning', (v) => v as bool?),
          isLastInfo: $checkedConvert('is_last_info', (v) => v as bool),
          originTime: $checkedConvert('origin_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          arrivalTime: $checkedConvert('arrival_time',
              (v) => v == null ? null : DateTime.parse(v as String)),
          hypoName: $checkedConvert('hypo_name', (v) => v as String?),
          depth: $checkedConvert('depth', (v) => (v as num?)?.toInt()),
          latitude: $checkedConvert('latitude', (v) => (v as num?)?.toDouble()),
          longitude:
              $checkedConvert('longitude', (v) => (v as num?)?.toDouble()),
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          forecastMaxIntensity: $checkedConvert('forecast_max_intensity',
              (v) => $enumDecodeNullable(_$JmaForecastIntensityEnumMap, v)),
          forecastMaxIntensityIsOver: $checkedConvert(
              'forecast_max_intensity_is_over', (v) => v as bool?),
          forecastMaxLpgmIntensity: $checkedConvert(
              'forecast_max_lpgm_intensity',
              (v) => $enumDecodeNullable(_$JmaForecastLgIntensityEnumMap, v)),
          forecastMaxLpgmIntensityIsOver: $checkedConvert(
              'forecast_max_lpgm_intensity_is_over', (v) => v as bool?),
          regions: $checkedConvert(
              'regions',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => EstimatedIntensityRegion.fromJson(
                      e as Map<String, dynamic>))
                  .toList()),
          isPlum: $checkedConvert('is_plum', (v) => v as bool?),
          accuracy: $checkedConvert(
              'accuracy',
              (v) => v == null
                  ? null
                  : EewAccuracy.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {
        'eventId': 'event_id',
        'schemaType': 'schema_type',
        'infoType': 'info_type',
        'reportTime': 'report_time',
        'serialNo': 'serial_no',
        'isCanceled': 'is_canceled',
        'isWarning': 'is_warning',
        'isLastInfo': 'is_last_info',
        'originTime': 'origin_time',
        'arrivalTime': 'arrival_time',
        'hypoName': 'hypo_name',
        'forecastMaxIntensity': 'forecast_max_intensity',
        'forecastMaxIntensityIsOver': 'forecast_max_intensity_is_over',
        'forecastMaxLpgmIntensity': 'forecast_max_lpgm_intensity',
        'forecastMaxLpgmIntensityIsOver': 'forecast_max_lpgm_intensity_is_over',
        'isPlum': 'is_plum'
      },
    );

Map<String, dynamic> _$$EewV1ImplToJson(_$EewV1Impl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'event_id': instance.eventId,
      'type': instance.type,
      'schema_type': instance.schemaType,
      'status': instance.status,
      'info_type': instance.infoType,
      'report_time': instance.reportTime.toIso8601String(),
      'serial_no': instance.serialNo,
      'headline': instance.headline,
      'is_canceled': instance.isCanceled,
      'is_warning': instance.isWarning,
      'is_last_info': instance.isLastInfo,
      'origin_time': instance.originTime?.toIso8601String(),
      'arrival_time': instance.arrivalTime?.toIso8601String(),
      'hypo_name': instance.hypoName,
      'depth': instance.depth,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'magnitude': instance.magnitude,
      'forecast_max_intensity':
          _$JmaForecastIntensityEnumMap[instance.forecastMaxIntensity],
      'forecast_max_intensity_is_over': instance.forecastMaxIntensityIsOver,
      'forecast_max_lpgm_intensity':
          _$JmaForecastLgIntensityEnumMap[instance.forecastMaxLpgmIntensity],
      'forecast_max_lpgm_intensity_is_over':
          instance.forecastMaxLpgmIntensityIsOver,
      'regions': instance.regions,
      'is_plum': instance.isPlum,
      'accuracy': instance.accuracy,
    };

const _$JmaForecastIntensityEnumMap = {
  JmaForecastIntensity.zero: '0',
  JmaForecastIntensity.one: '1',
  JmaForecastIntensity.two: '2',
  JmaForecastIntensity.three: '3',
  JmaForecastIntensity.four: '4',
  JmaForecastIntensity.fiveLower: '5-',
  JmaForecastIntensity.fiveUpper: '5+',
  JmaForecastIntensity.sixLower: '6-',
  JmaForecastIntensity.sixUpper: '6+',
  JmaForecastIntensity.seven: '7',
  JmaForecastIntensity.unknown: '不明',
};

const _$JmaForecastLgIntensityEnumMap = {
  JmaForecastLgIntensity.zero: '0',
  JmaForecastLgIntensity.one: '1',
  JmaForecastLgIntensity.two: '2',
  JmaForecastLgIntensity.three: '3',
  JmaForecastLgIntensity.four: '4',
  JmaForecastLgIntensity.unknown: '不明',
};

_$EstimatedIntensityRegionImpl _$$EstimatedIntensityRegionImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EstimatedIntensityRegionImpl',
      json,
      ($checkedConvert) {
        final val = _$EstimatedIntensityRegionImpl(
          code: $checkedConvert('code', (v) => v as String),
          name: $checkedConvert('name', (v) => v as String),
          isPlum: $checkedConvert('isPlum', (v) => v as bool),
          isWarning: $checkedConvert('isWarning', (v) => v as bool),
          forecastMaxInt: $checkedConvert('forecastMaxInt',
              (v) => ForecastMaxInt.fromJson(v as Map<String, dynamic>)),
          forecastMaxLgInt: $checkedConvert('forecastMaxLgInt',
              (v) => ForecastMaxLgInt.fromJson(v as Map<String, dynamic>)),
          arrivalTime: $checkedConvert('arrivalTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EstimatedIntensityRegionImplToJson(
        _$EstimatedIntensityRegionImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'isPlum': instance.isPlum,
      'isWarning': instance.isWarning,
      'forecastMaxInt': instance.forecastMaxInt,
      'forecastMaxLgInt': instance.forecastMaxLgInt,
      'arrivalTime': instance.arrivalTime?.toIso8601String(),
    };

_$EewAccuracyImpl _$$EewAccuracyImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EewAccuracyImpl',
      json,
      ($checkedConvert) {
        final val = _$EewAccuracyImpl(
          epicenters: $checkedConvert(
              'epicenters', (v) => stringListToIntList(v as List)),
          depth: $checkedConvert('depth', (v) => int.parse(v as String)),
          magnitudeCalculation: $checkedConvert(
              'magnitudeCalculation', (v) => int.parse(v as String)),
          numberOfMagnitudeCalculation: $checkedConvert(
              'numberOfMagnitudeCalculation', (v) => int.parse(v as String)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EewAccuracyImplToJson(_$EewAccuracyImpl instance) =>
    <String, dynamic>{
      'epicenters': intListToStringList(instance.epicenters),
      'depth': intToString(instance.depth),
      'magnitudeCalculation': intToString(instance.magnitudeCalculation),
      'numberOfMagnitudeCalculation':
          intToString(instance.numberOfMagnitudeCalculation),
    };
