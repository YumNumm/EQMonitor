// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Comments _$$_CommentsFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Comments',
      json,
      ($checkedConvert) {
        final val = _$_Comments(
          free: $checkedConvert('free', (v) => v as String?),
          forecast: $checkedConvert(
              'forecast',
              (v) => v == null
                  ? null
                  : ForecastComments.fromJson(v as Map<String, dynamic>)),
          varComments: $checkedConvert(
              'varComments',
              (v) => v == null
                  ? null
                  : VarComments.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_CommentsToJson(_$_Comments instance) =>
    <String, dynamic>{
      'free': instance.free,
      'forecast': instance.forecast,
      'varComments': instance.varComments,
    };

_$_CommentsOmitVar _$$_CommentsOmitVarFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_CommentsOmitVar',
      json,
      ($checkedConvert) {
        final val = _$_CommentsOmitVar(
          free: $checkedConvert('free', (v) => v as String?),
          forecast: $checkedConvert(
              'forecast',
              (v) => v == null
                  ? null
                  : ForecastComments.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_CommentsOmitVarToJson(_$_CommentsOmitVar instance) =>
    <String, dynamic>{
      'free': instance.free,
      'forecast': instance.forecast,
    };

_$_ForecastComments _$$_ForecastCommentsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_ForecastComments',
      json,
      ($checkedConvert) {
        final val = _$_ForecastComments(
          text: $checkedConvert('text', (v) => v as String),
          codes: $checkedConvert('codes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_ForecastCommentsToJson(_$_ForecastComments instance) =>
    <String, dynamic>{
      'text': instance.text,
      'codes': instance.codes,
    };

_$_VarComments _$$_VarCommentsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_VarComments',
      json,
      ($checkedConvert) {
        final val = _$_VarComments(
          text: $checkedConvert('text', (v) => v as String),
          codes: $checkedConvert('codes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_VarCommentsToJson(_$_VarComments instance) =>
    <String, dynamic>{
      'text': instance.text,
      'codes': instance.codes,
    };

_$_CommentsOnlyFree _$$_CommentsOnlyFreeFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_CommentsOnlyFree',
      json,
      ($checkedConvert) {
        final val = _$_CommentsOnlyFree(
          free: $checkedConvert('free', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_CommentsOnlyFreeToJson(_$_CommentsOnlyFree instance) =>
    <String, dynamic>{
      'free': instance.free,
    };
