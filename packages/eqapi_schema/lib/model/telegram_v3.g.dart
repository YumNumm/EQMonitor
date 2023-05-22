// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telegram_v3.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TelegramV3Base _$$_TelegramV3BaseFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramV3Base',
      json,
      ($checkedConvert) {
        final val = _$_TelegramV3Base(
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

Map<String, dynamic> _$$_TelegramV3BaseToJson(_$_TelegramV3Base instance) =>
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

_$_TelegramVxse51Body _$$_TelegramVxse51BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVxse51Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVxse51Body(
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

Map<String, dynamic> _$$_TelegramVxse51BodyToJson(
        _$_TelegramVxse51Body instance) =>
    <String, dynamic>{
      'intensity': instance.intensity,
      'text': instance.text,
      'comment': instance.comment,
    };

_$_TelegramVxse52Body _$$_TelegramVxse52BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVxse52Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVxse52Body(
          earthquake: $checkedConvert('earthquake',
              (v) => Earthquake.fromJson(v as Map<String, dynamic>)),
          text: $checkedConvert('text', (v) => v as String?),
          comment: $checkedConvert('comment',
              (v) => CommentsOmitVar.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TelegramVxse52BodyToJson(
        _$_TelegramVxse52Body instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'text': instance.text,
      'comment': instance.comment,
    };

_$_TelegramVxse53Body _$$_TelegramVxse53BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVxse53Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVxse53Body(
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

Map<String, dynamic> _$$_TelegramVxse53BodyToJson(
        _$_TelegramVxse53Body instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'intensity': instance.intensity,
      'text': instance.text,
      'comment': instance.comment,
    };

_$_TelegramVxse62Body _$$_TelegramVxse62BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVxse62Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVxse62Body(
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

Map<String, dynamic> _$$_TelegramVxse62BodyToJson(
        _$_TelegramVxse62Body instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'intensity': instance.intensity,
      'text': instance.text,
      'comment': instance.comment,
    };

_$_TelegramVtse41Body _$$_TelegramVtse41BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVtse41Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVtse41Body(
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

Map<String, dynamic> _$$_TelegramVtse41BodyToJson(
        _$_TelegramVtse41Body instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comments': instance.comments,
    };

_$_TelegramVtse51Body _$$_TelegramVtse51BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVtse51Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVtse51Body(
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

Map<String, dynamic> _$$_TelegramVtse51BodyToJson(
        _$_TelegramVtse51Body instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comments': instance.comments,
    };

_$_TelegramVtse52Body _$$_TelegramVtse52BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVtse52Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVtse52Body(
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

Map<String, dynamic> _$$_TelegramVtse52BodyToJson(
        _$_TelegramVtse52Body instance) =>
    <String, dynamic>{
      'tsunami': instance.tsunami,
      'earthquakes': instance.earthquakes,
      'text': instance.text,
      'comments': instance.comments,
    };

_$_TelegramVxse61Body _$$_TelegramVxse61BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVxse61Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVxse61Body(
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

Map<String, dynamic> _$$_TelegramVxse61BodyToJson(
        _$_TelegramVxse61Body instance) =>
    <String, dynamic>{
      'earthquake': instance.earthquake,
      'text': instance.text,
      'comments': instance.comments,
    };

_$_EarthquakeNankaiBody _$$_EarthquakeNankaiBodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeNankaiBody',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeNankaiBody(
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

Map<String, dynamic> _$$_EarthquakeNankaiBodyToJson(
        _$_EarthquakeNankaiBody instance) =>
    <String, dynamic>{
      'earthquakeInfo': instance.earthquakeInfo,
      'nextAdvisory': instance.nextAdvisory,
      'text': instance.text,
    };

_$_TelegramVxse56Body _$$_TelegramVxse56BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVxse56Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVxse56Body(
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

Map<String, dynamic> _$$_TelegramVxse56BodyToJson(
        _$_TelegramVxse56Body instance) =>
    <String, dynamic>{
      'naming': instance.naming,
      'text': instance.text,
      'comments': instance.comments,
    };

_$_TelegramCancelBody _$$_TelegramCancelBodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramCancelBody',
      json,
      ($checkedConvert) {
        final val = _$_TelegramCancelBody(
          text: $checkedConvert('text', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TelegramCancelBodyToJson(
        _$_TelegramCancelBody instance) =>
    <String, dynamic>{
      'text': instance.text,
    };

_$_TelegramVxse45Body _$$_TelegramVxse45BodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramVxse45Body',
      json,
      ($checkedConvert) {
        final val = _$_TelegramVxse45Body(
          magnitude:
              $checkedConvert('magnitude', (v) => (v as num?)?.toDouble()),
          hypocenter: $checkedConvert(
              'hypocenter',
              (v) => v == null
                  ? null
                  : EewHypocenter.fromJson(v as Map<String, dynamic>)),
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

Map<String, dynamic> _$$_TelegramVxse45BodyToJson(
        _$_TelegramVxse45Body instance) =>
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

_$_EarthquakeInformationBody _$$_EarthquakeInformationBodyFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_EarthquakeInformationBody',
      json,
      ($checkedConvert) {
        final val = _$_EarthquakeInformationBody(
          isLastInfo: $checkedConvert('isLastInfo', (v) => v as bool),
          isCanceled: $checkedConvert('isCanceled', (v) => v as bool),
          text: $checkedConvert('text', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_EarthquakeInformationBodyToJson(
        _$_EarthquakeInformationBody instance) =>
    <String, dynamic>{
      'isLastInfo': instance.isLastInfo,
      'isCanceled': instance.isCanceled,
      'text': instance.text,
    };
