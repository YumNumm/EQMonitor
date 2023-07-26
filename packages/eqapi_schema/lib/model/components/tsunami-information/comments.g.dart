// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TsunamiComments _$$_TsunamiCommentsFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiComments',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiComments(
          free: $checkedConvert('free', (v) => v as String?),
          warning: $checkedConvert(
              'warning',
              (v) => v == null
                  ? null
                  : TsunamiForecastCommentWarning.fromJson(
                      v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TsunamiCommentsToJson(_$_TsunamiComments instance) =>
    <String, dynamic>{
      'free': instance.free,
      'warning': instance.warning,
    };

_$_TsunamiForecastCommentWarning _$$_TsunamiForecastCommentWarningFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TsunamiForecastCommentWarning',
      json,
      ($checkedConvert) {
        final val = _$_TsunamiForecastCommentWarning(
          text: $checkedConvert('text', (v) => v as String),
          codes: $checkedConvert('codes',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TsunamiForecastCommentWarningToJson(
        _$_TsunamiForecastCommentWarning instance) =>
    <String, dynamic>{
      'text': instance.text,
      'codes': instance.codes,
    };
