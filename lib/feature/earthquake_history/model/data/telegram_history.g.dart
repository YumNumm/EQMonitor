// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'telegram_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TelegramHistoryV3Impl _$$TelegramHistoryV3ImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$TelegramHistoryV3Impl',
      json,
      ($checkedConvert) {
        final val = _$TelegramHistoryV3Impl(
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

Map<String, dynamic> _$$TelegramHistoryV3ImplToJson(
        _$TelegramHistoryV3Impl instance) =>
    <String, dynamic>{
      'results': _telegramHistoryV3DataToJson(instance.results),
      'success': instance.success,
      'meta': instance.meta,
    };

_$D1DbExecutionResultImpl _$$D1DbExecutionResultImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$D1DbExecutionResultImpl',
      json,
      ($checkedConvert) {
        final val = _$D1DbExecutionResultImpl(
          duration: $checkedConvert('duration', (v) => (v as num).toDouble()),
        );
        return val;
      },
    );

Map<String, dynamic> _$$D1DbExecutionResultImplToJson(
        _$D1DbExecutionResultImpl instance) =>
    <String, dynamic>{
      'duration': instance.duration,
    };
