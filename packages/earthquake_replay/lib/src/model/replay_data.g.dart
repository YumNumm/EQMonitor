// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'replay_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JmaXmlTelegramReplayDataImpl
_$$JmaXmlTelegramReplayDataImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$JmaXmlTelegramReplayDataImpl',
  json,
  ($checkedConvert) {
    final val = _$JmaXmlTelegramReplayDataImpl(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
      ),
      time: $checkedConvert(
        'time',
        (v) => DateTime.parse(v as String),
      ),
      title: $checkedConvert('title', (v) => v as String),
      telegram: $checkedConvert(
        'telegram',
        (v) => v as String,
      ),
    );
    return val;
  },
);

Map<String, dynamic> _$$JmaXmlTelegramReplayDataImplToJson(
  _$JmaXmlTelegramReplayDataImpl instance,
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

_$JmaBinaryTelegramReplayDataImpl
_$$JmaBinaryTelegramReplayDataImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$JmaBinaryTelegramReplayDataImpl',
  json,
  ($checkedConvert) {
    final val = _$JmaBinaryTelegramReplayDataImpl(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
      ),
      time: $checkedConvert(
        'time',
        (v) => DateTime.parse(v as String),
      ),
      telegramType: $checkedConvert(
        'telegram_type',
        (v) => v as String,
      ),
      data: $checkedConvert(
        'data',
        (v) =>
            (v as List<dynamic>)
                .map((e) => (e as num).toInt())
                .toList(),
      ),
    );
    return val;
  },
  fieldKeyMap: const {'telegramType': 'telegram_type'},
);

Map<String, dynamic>
_$$JmaBinaryTelegramReplayDataImplToJson(
  _$JmaBinaryTelegramReplayDataImpl instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'telegram_type': instance.telegramType,
  'data': instance.data,
};

_$KyoshinMonitorImageReplayDataImpl
_$$KyoshinMonitorImageReplayDataImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$KyoshinMonitorImageReplayDataImpl',
  json,
  ($checkedConvert) {
    final val = _$KyoshinMonitorImageReplayDataImpl(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
      ),
      time: $checkedConvert(
        'time',
        (v) => DateTime.parse(v as String),
      ),
      images: $checkedConvert(
        'images',
        (v) => (v as Map<String, dynamic>).map(
          (k, e) => MapEntry(
            $enumDecode(_$ImageTypeEnumMap, k),
            (e as List<dynamic>)
                .map((e) => (e as num).toInt())
                .toList(),
          ),
        ),
      ),
    );
    return val;
  },
);

Map<String, dynamic>
_$$KyoshinMonitorImageReplayDataImplToJson(
  _$KyoshinMonitorImageReplayDataImpl instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'images': instance.images.map(
    (k, e) => MapEntry(_$ImageTypeEnumMap[k]!, e),
  ),
};

const _$ImageTypeEnumMap = {
  ImageType.shindo: 'shindo',
  ImageType.pga: 'pga',
  ImageType.pgv: 'pgv',
  ImageType.psWave: 'psWave',
  ImageType.estShindo: 'estShindo',
};

_$KyoshinMonitorEewJsonReplayDataImpl
_$$KyoshinMonitorEewJsonReplayDataImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$KyoshinMonitorEewJsonReplayDataImpl',
  json,
  ($checkedConvert) {
    final val = _$KyoshinMonitorEewJsonReplayDataImpl(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
      ),
      time: $checkedConvert(
        'time',
        (v) => DateTime.parse(v as String),
      ),
      json: $checkedConvert('json', (v) => v as String),
    );
    return val;
  },
);

Map<String, dynamic>
_$$KyoshinMonitorEewJsonReplayDataImplToJson(
  _$KyoshinMonitorEewJsonReplayDataImpl instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'json': instance.json,
};

_$KeviJsonReplayDataImpl _$$KeviJsonReplayDataImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(
  r'_$KeviJsonReplayDataImpl',
  json,
  ($checkedConvert) {
    final val = _$KeviJsonReplayDataImpl(
      type: $checkedConvert(
        'type',
        (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
      ),
      time: $checkedConvert(
        'time',
        (v) => DateTime.parse(v as String),
      ),
      jsonType: $checkedConvert(
        'json_type',
        (v) => $enumDecode(_$JsonTypeEnumMap, v),
      ),
      json: $checkedConvert('json', (v) => v as String),
    );
    return val;
  },
  fieldKeyMap: const {'jsonType': 'json_type'},
);

Map<String, dynamic> _$$KeviJsonReplayDataImplToJson(
  _$KeviJsonReplayDataImpl instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'json_type': _$JsonTypeEnumMap[instance.jsonType]!,
  'json': instance.json,
};

const _$JsonTypeEnumMap = {
  JsonType.eew: 'eew',
  JsonType.eewWarning: 'eewWarning',
};

_$SnpLogEntryReplayDataImpl
_$$SnpLogEntryReplayDataImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$SnpLogEntryReplayDataImpl', json, (
  $checkedConvert,
) {
  final val = _$SnpLogEntryReplayDataImpl(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
    ),
    time: $checkedConvert(
      'time',
      (v) => DateTime.parse(v as String),
    ),
    message: $checkedConvert('message', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$$SnpLogEntryReplayDataImplToJson(
  _$SnpLogEntryReplayDataImpl instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'message': instance.message,
};

_$AxisJsonReplayDataImpl _$$AxisJsonReplayDataImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$AxisJsonReplayDataImpl', json, (
  $checkedConvert,
) {
  final val = _$AxisJsonReplayDataImpl(
    type: $checkedConvert(
      'type',
      (v) => $enumDecode(_$ReplayDataTypeEnumMap, v),
    ),
    time: $checkedConvert(
      'time',
      (v) => DateTime.parse(v as String),
    ),
    json: $checkedConvert('json', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$$AxisJsonReplayDataImplToJson(
  _$AxisJsonReplayDataImpl instance,
) => <String, dynamic>{
  'type': _$ReplayDataTypeEnumMap[instance.type]!,
  'time': instance.time.toIso8601String(),
  'json': instance.json,
};
