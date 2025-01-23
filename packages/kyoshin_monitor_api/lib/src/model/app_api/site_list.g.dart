// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'site_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SiteListImpl _$$SiteListImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$SiteListImpl',
      json,
      ($checkedConvert) {
        final val = _$SiteListImpl(
          sites: $checkedConvert(
              'items',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => Site.fromJson(e as Map<String, dynamic>))
                  .toList()),
          security: $checkedConvert(
              'security',
              (v) => v == null
                  ? null
                  : Security.fromJson(v as Map<String, dynamic>)),
          dataTime: $checkedConvert('data_time', (v) => v as String?),
          result: $checkedConvert(
              'result',
              (v) => v == null
                  ? null
                  : Result.fromJson(v as Map<String, dynamic>)),
          serialNo: $checkedConvert('serial_no', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'sites': 'items',
        'dataTime': 'data_time',
        'serialNo': 'serial_no'
      },
    );

Map<String, dynamic> _$$SiteListImplToJson(_$SiteListImpl instance) =>
    <String, dynamic>{
      'items': instance.sites,
      'security': instance.security,
      'data_time': instance.dataTime,
      'result': instance.result,
      'serial_no': instance.serialNo,
    };

_$SiteImpl _$$SiteImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$SiteImpl',
      json,
      ($checkedConvert) {
        final val = _$SiteImpl(
          muni: $checkedConvert('muni', (v) => (v as num?)?.toInt()),
          siteidx: $checkedConvert('siteidx', (v) => (v as num?)?.toInt()),
          prefectureId: $checkedConvert('pref', (v) => (v as num?)?.toInt()),
          siteId: $checkedConvert('siteid', (v) => v as String?),
          lat: $checkedConvert('lat', (v) => (v as num?)?.toDouble()),
          lng: $checkedConvert('lng', (v) => (v as num?)?.toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {'prefectureId': 'pref', 'siteId': 'siteid'},
    );

Map<String, dynamic> _$$SiteImplToJson(_$SiteImpl instance) =>
    <String, dynamic>{
      'muni': instance.muni,
      'siteidx': instance.siteidx,
      'pref': instance.prefectureId,
      'siteid': instance.siteId,
      'lat': instance.lat,
      'lng': instance.lng,
    };
