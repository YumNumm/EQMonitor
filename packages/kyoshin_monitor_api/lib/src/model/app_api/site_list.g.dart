// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore, deprecated_member_use

part of 'site_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SiteList _$SiteListFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_SiteList',
  json,
  ($checkedConvert) {
    final val = _SiteList(
      items: $checkedConvert(
        'items',
        (v) => (v as List<dynamic>?)
            ?.map((e) => Site.fromJson(e as Map<String, dynamic>))
            .toList(),
      ),
      security: $checkedConvert(
        'security',
        (v) => v == null ? null : Security.fromJson(v as Map<String, dynamic>),
      ),
      dataTime: $checkedConvert('data_time', (v) => v as String?),
      result: $checkedConvert(
        'result',
        (v) => v == null ? null : Result.fromJson(v as Map<String, dynamic>),
      ),
      serialNo: $checkedConvert('serial_no', (v) => v as String?),
    );
    return val;
  },
  fieldKeyMap: const {'dataTime': 'data_time', 'serialNo': 'serial_no'},
);

Map<String, dynamic> _$SiteListToJson(_SiteList instance) => <String, dynamic>{
  'items': instance.items,
  'security': instance.security,
  'data_time': instance.dataTime,
  'result': instance.result,
  'serial_no': instance.serialNo,
};

_Site _$SiteFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Site', json, ($checkedConvert) {
      final val = _Site(
        muni: $checkedConvert('muni', (v) => (v as num?)?.toInt()),
        siteidx: $checkedConvert('siteidx', (v) => (v as num?)?.toInt()),
        prefectureId: $checkedConvert('pref', (v) => (v as num?)?.toInt()),
        siteId: $checkedConvert('siteid', (v) => v as String?),
        lat: $checkedConvert('lat', (v) => (v as num?)?.toDouble()),
        lng: $checkedConvert('lng', (v) => (v as num?)?.toDouble()),
      );
      return val;
    }, fieldKeyMap: const {'prefectureId': 'pref', 'siteId': 'siteid'});

Map<String, dynamic> _$SiteToJson(_Site instance) => <String, dynamic>{
  'muni': instance.muni,
  'siteidx': instance.siteidx,
  'pref': instance.prefectureId,
  'siteid': instance.siteId,
  'lat': instance.lat,
  'lng': instance.lng,
};
