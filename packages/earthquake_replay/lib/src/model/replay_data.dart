// ignore_for_file: lines_longer_than_80_chars

import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_data.freezed.dart';
part 'replay_data.g.dart';

sealed class ReplayData {
  const new({required this.type, required this.time});

  factory fromMsgPack(List<dynamic> data) {
    final type = data[0] as int;
    final body = data[1] as List<dynamic>;
    final replayDataType = ReplayDataType.values.firstWhere(
      (e) => e.value == type,
    );
    return switch (replayDataType) {
      ReplayDataType.jmaXmlTelegram => JmaXmlTelegramReplayData.fromMsgPack(
        body,
      ),
      ReplayDataType.jmaBinaryTelegram =>
        JmaBinaryTelegramReplayData.fromMsgPack(body),
      ReplayDataType.kyoshinMonitorImage =>
        KyoshinMonitorImageReplayData.fromMsgPack(body),
      ReplayDataType.kyoshinMonitorEewJson =>
        KyoshinMonitorEewJsonReplayData.fromMsgPack(body),
      ReplayDataType.keviJson => KeviJsonReplayData.fromMsgPack(body),
      ReplayDataType.snpLogEntry => SnpLogEntryReplayData.fromMsgPack(body),
      ReplayDataType.axisJson => AxisJsonReplayData.fromMsgPack(body),
      ReplayDataType.eqMonitorEew => EqMonitorEewReplayData.fromMsgPack(body),
    };
  }

  final ReplayDataType type;

  final DateTime time;
}

@freezed
abstract class JmaXmlTelegramReplayData
    with _$JmaXmlTelegramReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String title,
    required String telegram,
  }) = _JmaXmlTelegramReplayData;
  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$JmaXmlTelegramReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) {
    return JmaXmlTelegramReplayData(
      type: ReplayDataType.jmaXmlTelegram,
      time: data[0] as DateTime,
      title: data[1] as String,
      telegram: data[2] as String,
    );
  }

  @override
  String toString() =>
      'JmaXmlTelegramReplayData(time: $time, title: $title, '
      'telegram: ${telegram.substring(0, 10)}...)';
}

@freezed
abstract class JmaBinaryTelegramReplayData
    with _$JmaBinaryTelegramReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String telegramType,
    required List<int> data,
  }) = _JmaBinaryTelegramReplayData;
  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$JmaBinaryTelegramReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) {
    return JmaBinaryTelegramReplayData(
      type: ReplayDataType.jmaBinaryTelegram,
      time: data[0] as DateTime,
      telegramType: data[1] as String,
      data: (data[2] as List<dynamic>).cast<int>(),
    );
  }

  @override
  String toString() =>
      'JmaBinaryTelegramReplayData(time: $time, telegramType: $telegramType, '
      'data: ${data.length} bytes)';
}

@freezed
abstract class KyoshinMonitorImageReplayData
    with _$KyoshinMonitorImageReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required Map<ImageType, List<int>> images,
  }) = _KyoshinMonitorImageReplayData;
  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorImageReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) =>
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
  String toString() =>
      'KyoshinMonitorImageReplayData(time: $time, '
      'images: ${images.entries.map((e) => '${e.key}: ${e.value.length} bytes').join(', ')})';
}

@freezed
abstract class KyoshinMonitorEewJsonReplayData
    with _$KyoshinMonitorEewJsonReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String json,
  }) = _KyoshinMonitorEewJsonReplayData;
  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorEewJsonReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) {
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
abstract class KeviJsonReplayData
    with _$KeviJsonReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required JsonType jsonType,
    required String json,
  }) = _KeviJsonReplayData;
  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$KeviJsonReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) {
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
abstract class SnpLogEntryReplayData
    with _$SnpLogEntryReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String message,
  }) = _SnpLogEntryReplayData;
  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$SnpLogEntryReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) {
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
abstract class AxisJsonReplayData
    with _$AxisJsonReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String json,
  }) = _AxisJsonReplayData;
  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$AxisJsonReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) {
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

/// EQMonitor の EventMessage JSON（EEW）を保持するリプレイフレーム (Union 1003)。
///
/// [json] はアプリ側で `EewItemWithRelations` にデコードして本物の EEW
/// パイプラインへ流し込む。msgpack body は他の JSON フレーム (101/1002) と同様に
/// `[time, json]` の並び。
@freezed
abstract class EqMonitorEewReplayData
    with _$EqMonitorEewReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String json,
  }) = _EqMonitorEewReplayData;
  const new _();

  factory fromJson(Map<String, dynamic> json) =>
      _$EqMonitorEewReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) {
    return EqMonitorEewReplayData(
      type: ReplayDataType.eqMonitorEew,
      time: data[0] as DateTime,
      json: data[1] as String,
    );
  }

  @override
  String toString() =>
      'EqMonitorEewReplayData(time: $time, json: ${json.substring(0, 10)}...)';
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
  eqMonitorEew(1003);

  new(this.value);
  final int value;
}

enum ImageType {
  shindo(0),
  pga(1),
  pgv(2),
  psWave(3),
  estShindo(4);

  new(this.value);
  final int value;
}

enum JsonType {
  eew(0),
  eewWarning(1);

  new(this.value);
  final int value;
}
