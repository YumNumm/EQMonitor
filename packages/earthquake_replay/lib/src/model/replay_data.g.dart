// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'replay_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JmaXmlTelegramReplayData _$JmaXmlTelegramReplayDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_JmaXmlTelegramReplayData', json, ($checkedConvert) {
  final val = _JmaXmlTelegramReplayData(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
    ),
    time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
    title: $checkedConvert('title', (v) => v as String),
    telegram: $checkedConvert('telegram', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$JmaXmlTelegramReplayDataToJson(
  _JmaXmlTelegramReplayData instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'title': instance.title,
  'telegram': instance.telegram,
};

const _$ReplayDataTypeEnumMap = {
  ReplayDataType.jmaXmlTelegram: 0,
  ReplayDataType.jmaBinaryTelegram: 1,
  ReplayDataType.kyoshinMonitorImage: 100,
  ReplayDataType.kyoshinMonitorEewJson: 101,
  ReplayDataType.keviJson: 1000,
  ReplayDataType.snpLogEntry: 1001,
  ReplayDataType.axisJson: 1002,
};

_JmaBinaryTelegramReplayData _$JmaBinaryTelegramReplayDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  '_JmaBinaryTelegramReplayData',
  json,
  ($checkedConvert) {
    final val = _JmaBinaryTelegramReplayData(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
      ),
      time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
      telegramType: $checkedConvert('telegram_type', (v) => v as String),
      data: $checkedConvert(
        'data',
        (v) => (v as List<dynamic>).map((e) => (e as num).toInt()).toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'telegramType': 'telegram_type'},
);

Map<String, dynamic> _$JmaBinaryTelegramReplayDataToJson(
  _JmaBinaryTelegramReplayData instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'telegram_type': instance.telegramType,
  'data': instance.data,
};

_KyoshinMonitorImageReplayData _$KyoshinMonitorImageReplayDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_KyoshinMonitorImageReplayData', json, ($checkedConvert) {
  final val = _KyoshinMonitorImageReplayData(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
    ),
    time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
    images: $checkedConvert(
      'images',
      (v) => (v as Map<String, dynamic>).map(
        (k, e) => MapEntry(
          $enumDecode(_$ImageTypeEnumMap, k),
          (e as List<dynamic>).map((e) => (e as num).toInt()).toList(),
        ),
      ),
    ),
  );
  return val;
});

Map<String, dynamic> _$KyoshinMonitorImageReplayDataToJson(
  _KyoshinMonitorImageReplayData instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'images': instance.images.map((k, e) => MapEntry(_$ImageTypeEnumMap[k]!, e)),
};

const _$ImageTypeEnumMap = {
  ImageType.shindo: 'shindo',
  ImageType.pga: 'pga',
  ImageType.pgv: 'pgv',
  ImageType.psWave: 'psWave',
  ImageType.estShindo: 'estShindo',
};

_KyoshinMonitorEewJsonReplayData _$KyoshinMonitorEewJsonReplayDataFromJson(
  Map<String, dynamic> json,
) =>
    $checkedCreate('_KyoshinMonitorEewJsonReplayData', json, ($checkedConvert) {
      final val = _KyoshinMonitorEewJsonReplayData(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
        ),
        time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
        json: $checkedConvert('json', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$KyoshinMonitorEewJsonReplayDataToJson(
  _KyoshinMonitorEewJsonReplayData instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'json': instance.json,
};

_KeviJsonReplayData _$KeviJsonReplayDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_KeviJsonReplayData', json, ($checkedConvert) {
      final val = _KeviJsonReplayData(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
        ),
        time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
        jsonType: $checkedConvert(
          'json_type',
          (v) => $enumDecode(_$JsonTypeEnumMap, v),
        ),
        json: $checkedConvert('json', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'jsonType': 'json_type'});

Map<String, dynamic> _$KeviJsonReplayDataToJson(_KeviJsonReplayData instance) =>
    <String, dynamic>{
      'type': _$ReplayDataTypeEnumMap[instance.type]!,
      'time': instance.time.toIso8601String(),
      'json_type': _$JsonTypeEnumMap[instance.jsonType]!,
      'json': instance.json,
    };

const _$JsonTypeEnumMap = {
  JsonType.eew: 'eew',
  JsonType.eewWarning: 'eewWarning',
};

_SnpLogEntryReplayData _$SnpLogEntryReplayDataFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('_SnpLogEntryReplayData', json, ($checkedConvert) {
  final val = _SnpLogEntryReplayData(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
    ),
    time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$SnpLogEntryReplayDataToJson(
  _SnpLogEntryReplayData instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'message': instance.message,
};

_AxisJsonReplayData _$AxisJsonReplayDataFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_AxisJsonReplayData', json, ($checkedConvert) {
      final val = _AxisJsonReplayData(
        type: $checkedConvert(
          'type',
          (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
        ),
        time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
        json: $checkedConvert('json', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$AxisJsonReplayDataToJson(_AxisJsonReplayData instance) =>
    <String, dynamic>{
      'type': _$ReplayDataTypeEnumMap[instance.type]!,
      'time': instance.time.toIso8601String(),
      'json': instance.json,
    };
