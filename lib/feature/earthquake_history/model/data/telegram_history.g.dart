// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'telegram_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TelegramHistoryV3 _$$_TelegramHistoryV3FromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_TelegramHistoryV3',
      json,
      ($checkedConvert) {
        final val = _$_TelegramHistoryV3(
          results: $checkedConvert(
              'results',
              (v) =>
                  _telegramHistoryV3DataFromJson(v as Map<String, dynamic>?)),
          success: $checkedConvert('success', (v) => v as bool),
          meta: $checkedConvert('meta',
              (v) => D1DbExecutionResult.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TelegramHistoryV3ToJson(
        _$_TelegramHistoryV3 instance) =>
    <String, dynamic>{
      'results': _telegramHistoryV3DataToJson(instance.results),
      'success': instance.success,
      'meta': instance.meta,
    };

_$_D1DbExecutionResult _$$_D1DbExecutionResultFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_D1DbExecutionResult',
      json,
      ($checkedConvert) {
        final val = _$_D1DbExecutionResult(
          duration: $checkedConvert('duration', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_D1DbExecutionResultToJson(
        _$_D1DbExecutionResult instance) =>
    <String, dynamic>{
      'duration': instance.duration,
    };
