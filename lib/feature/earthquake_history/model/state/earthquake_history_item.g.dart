// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'earthquake_history_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EarthquakeHistoryItem _$$_EarthquakeHistoryItemFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeHistoryItem',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeHistoryItem(
          earthquake: $checkedConvert('earthquake',
              (v) => EarthquakeData.fromJson(v as Map<String, dynamic>)),
          tsunami: $checkedConvert('tsunami',
              (v) => TsunamiData.fromJson(v as Map<String, dynamic>)),
          telegrams: $checkedConvert(
              'telegrams',
              (v) => (v as List<dynamic>)
                  .map((e) => TelegramV3.fromJson(e as Map<String, dynamic>))
                  .toList()),
          eventId: $checkedConvert('eventId', (v) => v as int),
          latestEew: $checkedConvert(
              'latestEew',
              (v) => v == null
                  ? null
                  : Vxse45.fromJson(v as Map<String, dynamic>)),
          latestEewTelegram: $checkedConvert(
              'latestEewTelegram',
              (v) => v == null
                  ? null
                  : TelegramV3.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EarthquakeHistoryItemToJson(
        _$_EarthquakeHistoryItem instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'tsunami': instance.tsunami,
      'telegrams': instance.telegrams,
      'eventId': instance.eventId,
      'latestEew': instance.latestEew,
      'latestEewTelegram': instance.latestEewTelegram,
    };

_$_EarthquakeData _$$_EarthquakeDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeData',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeData(
          earthquake: $checkedConvert(
              'earthquake',
              (v) => v == null
                  ? null
                  : Earthquake.fromJson(v as Map<String, dynamic>)),
          intensity: $checkedConvert(
              'intensity',
              (v) => v == null
                  ? null
                  : Intensity.fromJson(v as Map<String, dynamic>)),
          lgIntensity: $checkedConvert(
              'lgIntensity',
              (v) => v == null
                  ? null
                  : Intensity.fromJson(v as Map<String, dynamic>)),
          comment: $checkedConvert(
              'comment',
              (v) => v == null
                  ? null
                  : CommentsOmitVar.fromJson(v as Map<String, dynamic>)),
          isVolcano: $checkedConvert('isVolcano', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EarthquakeDataToJson(_$_EarthquakeData instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'intensity': instance.intensity,
      'lgIntensity': instance.lgIntensity,
      'comment': instance.comment,
      'isVolcano': instance.isVolcano,
    };

_$_TsunamiData _$$_TsunamiDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiData',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiData(
          forecasts: $checkedConvert(
              'forecasts',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      TsunamiForecast.fromJson(e as Map<String, dynamic>))
                  .toList()),
          estimations: $checkedConvert(
              'estimations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      TsunamiEstimation.fromJson(e as Map<String, dynamic>))
                  .toList()),
          observations: $checkedConvert(
              'observations',
              (v) => (v as List<dynamic>?)
                  ?.map((e) =>
                      TsunamiObservation.fromJson(e as Map<String, dynamic>))
                  .toList()),
          comments: $checkedConvert(
              'comments',
              (v) => v == null
                  ? null
                  : TsunamiComments.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TsunamiDataToJson(_$_TsunamiData instance) =>
    <String, dynamic>{
      'forecasts': instance.forecasts,
      'estimations': instance.estimations,
      'observations': instance.observations,
      'comments': instance.comments,
    };
