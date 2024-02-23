// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommentsImpl _$$CommentsImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CommentsImpl',
      json,
      ($checkedConvert) {
        final val = _$CommentsImpl(
          free: $checkedConvert('free', (v) => v as String?),
          forecast: $checkedConvert(
              'forecast',
              (v) => v == null
                  ? null
                  : ForecastComments.fromJson(v as Map<String, dynamic>)),
          varComments: $checkedConvert(
              'var_comments',
              (v) => v == null
                  ? null
                  : VarComments.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'varComments': 'var_comments'},
    );

Map<String, dynamic> _$$CommentsImplToJson(_$CommentsImpl instance) =>
    <String, dynamic>{
      'free': instance.free,
      'forecast': instance.forecast,
      'var_comments': instance.varComments,
    };

_$CommentsOmitVarImpl _$$CommentsOmitVarImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CommentsOmitVarImpl',
      json,
      ($checkedConvert) {
        final val = _$CommentsOmitVarImpl(
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

Map<String, dynamic> _$$CommentsOmitVarImplToJson(
        _$CommentsOmitVarImpl instance) =>
    <String, dynamic>{
      'free': instance.free,
      'forecast': instance.forecast,
    };

_$ForecastCommentsImpl _$$ForecastCommentsImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ForecastCommentsImpl',
      json,
      ($checkedConvert) {
        final val = _$ForecastCommentsImpl(
          text: $checkedConvert('text', (v) => v as String),
          codes: $checkedConvert('codes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$ForecastCommentsImplToJson(
        _$ForecastCommentsImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'codes': instance.codes,
    };

_$VarCommentsImpl _$$VarCommentsImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$VarCommentsImpl',
      json,
      ($checkedConvert) {
        final val = _$VarCommentsImpl(
          text: $checkedConvert('text', (v) => v as String),
          codes: $checkedConvert('codes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$VarCommentsImplToJson(_$VarCommentsImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'codes': instance.codes,
    };

_$CommentsOnlyFreeImpl _$$CommentsOnlyFreeImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CommentsOnlyFreeImpl',
      json,
      ($checkedConvert) {
        final val = _$CommentsOnlyFreeImpl(
          free: $checkedConvert('free', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$$CommentsOnlyFreeImplToJson(
        _$CommentsOnlyFreeImpl instance) =>
    <String, dynamic>{
      'free': instance.free,
    };
