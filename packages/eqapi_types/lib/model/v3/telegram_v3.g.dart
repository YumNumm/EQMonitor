// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'telegram_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelegramV3BaseImpl _$$TelegramV3BaseImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramV3BaseImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramV3BaseImpl(
          id: $checkedConvert('id', (v) => v as int?),
          hash: $checkedConvert('hash', (v) => v as String?),
          eventId: $checkedConvert('eventId', (v) => v as int),
          type: $checkedConvert(
              'type', (v) => $enumDecode(_$TelegramTypeEnumMap, v)),
          schemaType: $checkedConvert(
              'schemaType', (v) => $enumDecode(_$SchemaTypeEnumMap, v)),
          status: $checkedConvert(
              'status', (v) => $enumDecode(_$TelegramStatusEnumMap, v)),
          infoType: $checkedConvert(
              'infoType', (v) => $enumDecode(_$TelegramInfoTypeEnumMap, v)),
          pressTime:
              $checkedConvert('pressTime', (v) => DateTime.parse(v as String)),
          reportTime: $checkedConvert('reportTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          validTime: $checkedConvert('validTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          serialNo: $checkedConvert('serialNo', (v) => v as int?),
          headline: $checkedConvert('headline', (v) => v as String?),
          body: $checkedConvert('body', (v) => v as Map<String, dynamic>),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramV3BaseImplToJson(
        _$TelegramV3BaseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hash': instance.hash,
      'eventId': instance.eventId,
      'type': _$TelegramTypeEnumMap[instance.type]!,
      'schemaType': _$SchemaTypeEnumMap[instance.schemaType]!,
      'status': _$TelegramStatusEnumMap[instance.status]!,
      'infoType': _$TelegramInfoTypeEnumMap[instance.infoType]!,
      'pressTime': instance.pressTime.toIso8601String(),
      'reportTime': instance.reportTime?.toIso8601String(),
      'validTime': instance.validTime?.toIso8601String(),
      'serialNo': instance.serialNo,
      'headline': instance.headline,
      'body': instance.body,
    };

const _$TelegramTypeEnumMap = {
  TelegramType.vxse45: '緊急地震速報（地震動予報）',
  TelegramType.vtse41: '津波警報・注意報・予報a',
  TelegramType.vtse51: '津波情報a',
  TelegramType.vtse52: '沖合の津波観測に関する情報',
  TelegramType.vtse52Cancel: '各地の満潮時刻・津波到達予想時刻に関する情報',
  TelegramType.vtse52Cancel2: '津波観測に関する情報',
  TelegramType.vxse51: '震度速報',
  TelegramType.vxse52: '震源に関する情報',
  TelegramType.vxse53: '震源・震度に関する情報',
  TelegramType.vxse53distant: '遠地地震に関する情報',
  TelegramType.vxse56: '地震の活動状況等に関する情報',
  TelegramType.vxse60: '地震回数に関する情報',
  TelegramType.vxse61: '顕著な地震の震源要素更新のお知らせ',
  TelegramType.vxse62: '長周期地震動に関する観測情報',
  TelegramType.vyse50: '南海トラフ地震臨時情報',
  TelegramType.vyse51: '南海トラフ地震関連解説情報',
  TelegramType.vyse52: '南海トラフ地震関連解説情報',
};

const _$SchemaTypeEnumMap = {
  SchemaType.eewInformation: 'eew-information',
  SchemaType.earthquakeInformation: 'earthquake-information',
  SchemaType.earthquakeExplanation: 'earthquake-explanation',
  SchemaType.earthquakeCounts: 'earthquake-counts',
  SchemaType.earthquakeHypocenterUpdate: 'earthquake-hypocenter-update',
  SchemaType.earthquakeNankai: 'earthquake-nankai',
  SchemaType.tsunamiInformation: 'tsunami-information',
};

const _$TelegramStatusEnumMap = {
  TelegramStatus.normal: '通常',
  TelegramStatus.training: '訓練',
  TelegramStatus.test: '試験',
};

const _$TelegramInfoTypeEnumMap = {
  TelegramInfoType.issue: '発表',
  TelegramInfoType.correction: '訂正',
  TelegramInfoType.delay: '遅延',
  TelegramInfoType.cancel: '取消',
};

_$TelegramVxse51BodyImpl _$$TelegramVxse51BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVxse51BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVxse51BodyImpl(
          intensity: $checkedConvert(
              'intensity',
              (v) => v == null
                  ? null
                  : Intensity.fromJson(v as Map<String, dynamic>)),
          text: $checkedConvert('text', (v) => v as String?),
          comment: $checkedConvert('comment',
              (v) => CommentsOmitVar.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVxse51BodyImplToJson(
        _$TelegramVxse51BodyImpl instance) =>
    <String, dynamic>{
      'intensity': instance.intensity,
      'text': instance.text,
      'comment': instance.comment,
    };

_$TelegramVxse52BodyImpl _$$TelegramVxse52BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVxse52BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVxse52BodyImpl(
          earthquake: $checkedConvert('earthquake',
              (v) => Earthquake.fromJson(v as Map<String, dynamic>)),
          text: $checkedConvert('text', (v) => v as String?),
          comment: $checkedConvert('comment',
              (v) => CommentsOmitVar.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVxse52BodyImplToJson(
        _$TelegramVxse52BodyImpl instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'text': instance.text,
      'comment': instance.comment,
    };

_$TelegramVxse53BodyImpl _$$TelegramVxse53BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVxse53BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVxse53BodyImpl(
          earthquake: $checkedConvert('earthquake',
              (v) => Earthquake.fromJson(v as Map<String, dynamic>)),
          intensity: $checkedConvert(
              'intensity',
              (v) => v == null
                  ? null
                  : Intensity.fromJson(v as Map<String, dynamic>)),
          text: $checkedConvert('text', (v) => v as String?),
          comment: $checkedConvert('comment',
              (v) => CommentsOmitVar.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVxse53BodyImplToJson(
        _$TelegramVxse53BodyImpl instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'intensity': instance.intensity,
      'text': instance.text,
      'comment': instance.comment,
    };

_$TelegramVxse62BodyImpl _$$TelegramVxse62BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVxse62BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVxse62BodyImpl(
          earthquake: $checkedConvert('earthquake',
              (v) => Earthquake.fromJson(v as Map<String, dynamic>)),
          intensity: $checkedConvert(
              'intensity',
              (v) => v == null
                  ? null
                  : Intensity.fromJson(v as Map<String, dynamic>)),
          text: $checkedConvert('text', (v) => v as String?),
          comment: $checkedConvert('comment',
              (v) => CommentsOmitVar.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVxse62BodyImplToJson(
        _$TelegramVxse62BodyImpl instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'intensity': instance.intensity,
      'text': instance.text,
      'comment': instance.comment,
    };

_$TelegramVtse41BodyImpl _$$TelegramVtse41BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVtse41BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVtse41BodyImpl(
          tsunami: $checkedConvert(
              'tsunami',
              (v) =>
                  PublicBodyVtse41Tsunami.fromJson(v as Map<String, dynamic>)),
          earthquakes: $checkedConvert(
              'earthquakes',
              (v) => (v as List<dynamic>)
                  .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
                  .toList()),
          text: $checkedConvert('text', (v) => v as String?),
          comments: $checkedConvert(
              'comments',
              (v) => v == null
                  ? null
                  : TsunamiComments.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVtse41BodyImplToJson(
        _$TelegramVtse41BodyImpl instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comments': instance.comments,
    };

_$TelegramVtse51BodyImpl _$$TelegramVtse51BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVtse51BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVtse51BodyImpl(
          tsunami: $checkedConvert(
              'tsunami',
              (v) =>
                  PublicBodyVtse51Tsunami.fromJson(v as Map<String, dynamic>)),
          earthquakes: $checkedConvert(
              'earthquakes',
              (v) => (v as List<dynamic>)
                  .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
                  .toList()),
          text: $checkedConvert('text', (v) => v as String?),
          comments: $checkedConvert(
              'comments',
              (v) => v == null
                  ? null
                  : TsunamiComments.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVtse51BodyImplToJson(
        _$TelegramVtse51BodyImpl instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comments': instance.comments,
    };

_$TelegramVtse52BodyImpl _$$TelegramVtse52BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVtse52BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVtse52BodyImpl(
          tsunami: $checkedConvert(
              'tsunami',
              (v) =>
                  PublicBodyVtse52Tsunami.fromJson(v as Map<String, dynamic>)),
          earthquakes: $checkedConvert(
              'earthquakes',
              (v) => (v as List<dynamic>)
                  .map((e) => Earthquake.fromJson(e as Map<String, dynamic>))
                  .toList()),
          text: $checkedConvert('text', (v) => v as String?),
          comments: $checkedConvert(
              'comments',
              (v) => v == null
                  ? null
                  : TsunamiComments.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVtse52BodyImplToJson(
        _$TelegramVtse52BodyImpl instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comments': instance.comments,
    };

_$TelegramVxse61BodyImpl _$$TelegramVxse61BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVxse61BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVxse61BodyImpl(
          earthquake: $checkedConvert('earthquake',
              (v) => Earthquake.fromJson(v as Map<String, dynamic>)),
          text: $checkedConvert('text', (v) => v as String?),
          comments: $checkedConvert(
              'comments',
              (v) => v == null
                  ? null
                  : CommentsOnlyFree.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVxse61BodyImplToJson(
        _$TelegramVxse61BodyImpl instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'text': instance.text,
      'comments': instance.comments,
    };

_$EarthquakeNankaiBodyImpl _$$EarthquakeNankaiBodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeNankaiBodyImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeNankaiBodyImpl(
          earthquakeInfo: $checkedConvert(
              'earthquakeInfo',
              (v) => v == null
                  ? null
                  : EarthquakeNankaiInfo.fromJson(v as Map<String, dynamic>)),
          nextAdvisory: $checkedConvert('nextAdvisory', (v) => v as String?),
          text: $checkedConvert('text', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeNankaiBodyImplToJson(
        _$EarthquakeNankaiBodyImpl instance) =>
    <String, dynamic>{
      'earthquakeInfo': instance.earthquakeInfo,
      'nextAdvisory': instance.nextAdvisory,
      'text': instance.text,
    };

_$TelegramVxse56BodyImpl _$$TelegramVxse56BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVxse56BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVxse56BodyImpl(
          naming: $checkedConvert(
              'naming',
              (v) => v == null
                  ? null
                  : Naming.fromJson(v as Map<String, dynamic>)),
          text: $checkedConvert('text', (v) => v as String),
          comments: $checkedConvert(
              'comments',
              (v) => v == null
                  ? null
                  : CommentsOnlyFree.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVxse56BodyImplToJson(
        _$TelegramVxse56BodyImpl instance) =>
    <String, dynamic>{
      'naming': instance.naming,
      'text': instance.text,
      'comments': instance.comments,
    };

_$TelegramCancelBodyImpl _$$TelegramCancelBodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramCancelBodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramCancelBodyImpl(
          text: $checkedConvert('text', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramCancelBodyImplToJson(
        _$TelegramCancelBodyImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

_$TelegramVxse45BodyImpl _$$TelegramVxse45BodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramVxse45BodyImpl',
      json,
      ($checkedConvert) {
        final val = _$TelegramVxse45BodyImpl(
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          hypocenter: $checkedConvert('hypocenter',
              (v) => EewHypocenter.fromJson(v as Map<String, dynamic>)),
          depth: $checkedConvert('depth', (v) => v as int?),
          forecastMaxInt: $checkedConvert(
              'forecastMaxInt',
              (v) => v == null
                  ? null
                  : ForecastMaxInt.fromJson(v as Map<String, dynamic>)),
          forecastMaxLgInt: $checkedConvert(
              'forecastMaxLgInt',
              (v) => v == null
                  ? null
                  : ForecastMaxLgInt.fromJson(v as Map<String, dynamic>)),
          regions: $checkedConvert(
              'regions',
              (v) => (v as List<dynamic>?)
                  ?.map((e) => EewRegion.fromJson(e as Map<String, dynamic>))
                  .toList()),
          originTime: $checkedConvert('originTime',
              (v) => v == null ? null : DateTime.parse(v as String)),
          arrivalTime: $checkedConvert(
              'arrivalTime', (v) => DateTime.parse(v as String)),
          accuracy: $checkedConvert('accuracy',
              (v) => EewAccuracy.fromJson(v as Map<String, dynamic>)),
          isPlum: $checkedConvert('isPlum', (v) => v as bool),
          isLastInfo: $checkedConvert('isLastInfo', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$$TelegramVxse45BodyImplToJson(
        _$TelegramVxse45BodyImpl instance) =>
    <String, dynamic>{
      'magnitude': instance.magnitude,
      'hypocenter': instance.hypocenter,
      'depth': instance.depth,
      'forecastMaxInt': instance.forecastMaxInt,
      'forecastMaxLgInt': instance.forecastMaxLgInt,
      'regions': instance.regions,
      'originTime': instance.originTime?.toIso8601String(),
      'arrivalTime': instance.arrivalTime.toIso8601String(),
      'accuracy': instance.accuracy,
      'isPlum': instance.isPlum,
      'isLastInfo': instance.isLastInfo,
    };

_$EarthquakeInformationBodyImpl _$$EarthquakeInformationBodyImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$EarthquakeInformationBodyImpl',
      json,
      ($checkedConvert) {
        final val = _$EarthquakeInformationBodyImpl(
          isLastInfo: $checkedConvert('isLastInfo', (v) => v as bool),
          isCanceled: $checkedConvert('isCanceled', (v) => v as bool),
          text: $checkedConvert('text', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$EarthquakeInformationBodyImplToJson(
        _$EarthquakeInformationBodyImpl instance) =>
    <String, dynamic>{
      'isLastInfo': instance.isLastInfo,
      'isCanceled': instance.isCanceled,
      'text': instance.text,
    };
