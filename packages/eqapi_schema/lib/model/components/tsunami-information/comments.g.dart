// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TsunamiCommentsImpl _$$TsunamiCommentsImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TsunamiCommentsImpl',
      json,
      ($checkedConvert) {
        final val = _$TsunamiCommentsImpl(
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

Map<String, dynamic> _$$TsunamiCommentsImplToJson(
        _$TsunamiCommentsImpl instance) =>
    <String, dynamic>{
      'free': instance.free,
      'warning': instance.warning,
    };

_$TsunamiForecastCommentWarningImpl
    _$$TsunamiForecastCommentWarningImplFromJson(Map<String, dynamic> json) =>
        $checkedCreate(
          r'_$TsunamiForecastCommentWarningImpl',
          json,
          ($checkedConvert) {
            final val = _$TsunamiForecastCommentWarningImpl(
              text: $checkedConvert('text', (v) => v as String),
              codes: $checkedConvert('codes',
                  (v) => (v as List<dynamic>).map((e) => e as String).toList()),
            );
            return val;
          },
        );

Map<String, dynamic> _$$TsunamiForecastCommentWarningImplToJson(
        _$TsunamiForecastCommentWarningImpl instance) =>
    <String, dynamic>{
      'text': instance.text,
      'codes': instance.codes,
    };
