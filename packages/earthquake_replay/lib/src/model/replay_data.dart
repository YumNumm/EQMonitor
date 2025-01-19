import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_data.freezed.dart';
part 'replay_data.g.dart';

sealed class ReplayData {
  const ReplayData({
    required this.type,
    required this.time,
  });

  factory ReplayData.fromMsgPack(List<dynamic> data) {
    final type = data[0] as int;
    final body = data[1] as List<dynamic>;
    final replayDataType =
        ReplayDataType.values.firstWhere((e) => e.value == type);
    return switch (replayDataType) {
      ReplayDataType.jmaXmlTelegram =>
        JmaXmlTelegramReplayData.fromMsgPack(body),
      ReplayDataType.jmaBinaryTelegram =>
        JmaBinaryTelegramReplayData.fromMsgPack(body),
      ReplayDataType.kyoshinMonitorImage =>
        KyoshinMonitorImageReplayData.fromMsgPack(body),
      ReplayDataType.kyoshinMonitorEewJson =>
        KyoshinMonitorEewJsonReplayData.fromMsgPack(body),
      ReplayDataType.keviJson => KeviJsonReplayData.fromMsgPack(body),
      ReplayDataType.snpLogEntry => SnpLogEntryReplayData.fromMsgPack(body),
      ReplayDataType.axisJson => AxisJsonReplayData.fromMsgPack(body),
    };
  }

  final ReplayDataType type;

  final DateTime time;
}

@freezed
class JmaXmlTelegramReplayData
    with _$JmaXmlTelegramReplayData
    implements ReplayData {
  const factory JmaXmlTelegramReplayData({
    required ReplayDataType type,
    required DateTime time,
    required String title,
    required String telegram,
  }) = _JmaXmlTelegramReplayData;
  const JmaXmlTelegramReplayData._();

  factory JmaXmlTelegramReplayData.fromJson(Map<String, dynamic> json) =>
      _$JmaXmlTelegramReplayDataFromJson(json);

  factory JmaXmlTelegramReplayData.fromMsgPack(List<dynamic> data) {
    return JmaXmlTelegramReplayData(
      type: ReplayDataType.jmaXmlTelegram,
      time: data[0] as DateTime,
      title: data[1] as String,
      telegram: data[2] as String,
    );
  }

  @override
  String toString() =>
      'JmaXmlTelegramReplayData(time: $time, title: $title, telegram: ${telegram.substring(0, 10)}...)';
}

@freezed
class JmaBinaryTelegramReplayData
    with _$JmaBinaryTelegramReplayData
    implements ReplayData {
  const factory JmaBinaryTelegramReplayData({
    required ReplayDataType type,
    required DateTime time,
    required String telegramType,
    required List<int> data,
  }) = _JmaBinaryTelegramReplayData;
  const JmaBinaryTelegramReplayData._();

  factory JmaBinaryTelegramReplayData.fromJson(Map<String, dynamic> json) =>
      _$JmaBinaryTelegramReplayDataFromJson(json);

  factory JmaBinaryTelegramReplayData.fromMsgPack(List<dynamic> data) {
    return JmaBinaryTelegramReplayData(
      type: ReplayDataType.jmaBinaryTelegram,
      time: data[0] as DateTime,
      telegramType: data[1] as String,
      data: (data[2] as List<dynamic>).cast<int>(),
    );
  }

  @override
  String toString() =>
      'JmaBinaryTelegramReplayData(time: $time, telegramType: $telegramType, data: ${data.length} bytes)';
}

@freezed
class KyoshinMonitorImageReplayData
    with _$KyoshinMonitorImageReplayData
    implements ReplayData {
  const factory KyoshinMonitorImageReplayData({
    required ReplayDataType type,
    required DateTime time,
    required Map<ImageType, List<int>> images,
  }) = _KyoshinMonitorImageReplayData;
  const KyoshinMonitorImageReplayData._();

  factory KyoshinMonitorImageReplayData.fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorImageReplayDataFromJson(json);

  factory KyoshinMonitorImageReplayData.fromMsgPack(List<dynamic> data) =>
      KyoshinMonitorImageReplayData(
        type: ReplayDataType.kyoshinMonitorImage,
        time: data[0] as DateTime,
        images: (data[1] as Map<dynamic, dynamic>).map(
          (key, value) => MapEntry(
            ImageType.values[key as int],
            (value as List<dynamic>).cast<int>(),
          ),
        ),
      );

  @override
  String toString() => 'KyoshinMonitorImageReplayData(time: $time, '
      'images: ${images.entries.map((e) => '${e.key}: ${e.value.length} bytes').join(', ')})';
}

@freezed
class KyoshinMonitorEewJsonReplayData
    with _$KyoshinMonitorEewJsonReplayData
    implements ReplayData {
  const factory KyoshinMonitorEewJsonReplayData({
    required ReplayDataType type,
    required DateTime time,
    required String json,
  }) = _KyoshinMonitorEewJsonReplayData;
  const KyoshinMonitorEewJsonReplayData._();

  factory KyoshinMonitorEewJsonReplayData.fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorEewJsonReplayDataFromJson(json);

  factory KyoshinMonitorEewJsonReplayData.fromMsgPack(List<dynamic> data) {
    return KyoshinMonitorEewJsonReplayData(
      type: ReplayDataType.kyoshinMonitorEewJson,
      time: data[0] as DateTime,
      json: data[1] as String,
    );
  }

  @override
  String toString() =>
      'KyoshinMonitorEewJsonReplayData(time: $time, json: ${json.substring(0, 10)}...)';
}

@freezed
class KeviJsonReplayData with _$KeviJsonReplayData implements ReplayData {
  const factory KeviJsonReplayData({
    required ReplayDataType type,
    required DateTime time,
    required JsonType jsonType,
    required String json,
  }) = _KeviJsonReplayData;
  const KeviJsonReplayData._();

  factory KeviJsonReplayData.fromJson(Map<String, dynamic> json) =>
      _$KeviJsonReplayDataFromJson(json);

  factory KeviJsonReplayData.fromMsgPack(List<dynamic> data) {
    final jsonTypeIndex = data[1] as int;
    final jsonType = JsonType.values.firstWhere(
      (e) => e.value == jsonTypeIndex,
    );
    return KeviJsonReplayData(
      type: ReplayDataType.keviJson,
      time: data[0] as DateTime,
      jsonType: jsonType,
      json: data[2] as String,
    );
  }

  @override
  String toString() =>
      'KeviJsonReplayData(time: $time, jsonType: $jsonType, json: ${json.substring(0, 10)}...)';
}

@freezed
class SnpLogEntryReplayData with _$SnpLogEntryReplayData implements ReplayData {
  const factory SnpLogEntryReplayData({
    required ReplayDataType type,
    required DateTime time,
    required String message,
  }) = _SnpLogEntryReplayData;
  const SnpLogEntryReplayData._();

  factory SnpLogEntryReplayData.fromJson(Map<String, dynamic> json) =>
      _$SnpLogEntryReplayDataFromJson(json);

  factory SnpLogEntryReplayData.fromMsgPack(List<dynamic> data) {
    return SnpLogEntryReplayData(
      type: ReplayDataType.snpLogEntry,
      time: data[0] as DateTime,
      message: data[1] as String,
    );
  }

  @override
  String toString() =>
      'SnpLogEntryReplayData(time: $time, message: ${message.substring(0, 10)}...)';
}

@freezed
class AxisJsonReplayData with _$AxisJsonReplayData implements ReplayData {
  const factory AxisJsonReplayData({
    required ReplayDataType type,
    required DateTime time,
    required String json,
  }) = _AxisJsonReplayData;
  const AxisJsonReplayData._();

  factory AxisJsonReplayData.fromJson(Map<String, dynamic> json) =>
      _$AxisJsonReplayDataFromJson(json);

  factory AxisJsonReplayData.fromMsgPack(List<dynamic> data) {
    return AxisJsonReplayData(
      type: ReplayDataType.axisJson,
      time: data[0] as DateTime,
      json: data[1] as String,
    );
  }

  @override
  String toString() =>
      'AxisJsonReplayData(time: $time, json: ${json.substring(0, 10)}...)';
}

@JsonEnum(valueField: 'value')
enum ReplayDataType {
  jmaXmlTelegram(0),
  jmaBinaryTelegram(1),
  kyoshinMonitorImage(100),
  kyoshinMonitorEewJson(101),
  keviJson(1000),
  snpLogEntry(1001),
  axisJson(1002),
  ;

  const ReplayDataType(this.value);
  final int value;
}

enum ImageType {
  shindo(0),
  pga(1),
  pgv(2),
  psWave(3),
  estShindo(4),
  ;

  const ImageType(this.value);
  final int value;
}

enum JsonType {
  eew(0),
  eewWarning(1),
  ;

  const JsonType(this.value);
  final int value;
}
