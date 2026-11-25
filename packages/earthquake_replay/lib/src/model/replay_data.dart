// ignore_for_file: lines_longer_than_80_chars

import 'dart:convert' show jsonDecode;
import 'dart:typed_data';

import 'package:earthquake_replay/src/model/kyoshin_waveform_metadata.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_data.freezed.dart';
part 'replay_data.g.dart';

sealed class const ReplayData({
  required final ReplayDataType type,
  required final DateTime time,
}) {
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
      ReplayDataType.kyoshinWaveform => KyoshinWaveformReplayData.fromMsgPack(
        body,
      ),
    };
  }
}

@freezed
abstract class const JmaXmlTelegramReplayData._()
    with _$JmaXmlTelegramReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String title,
    required String telegram,
  }) = _JmaXmlTelegramReplayData;

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
abstract class const JmaBinaryTelegramReplayData._()
    with _$JmaBinaryTelegramReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String telegramType,
    required List<int> data,
  }) = _JmaBinaryTelegramReplayData;

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
abstract class const KyoshinMonitorImageReplayData._()
    with _$KyoshinMonitorImageReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required Map<ImageType, List<int>> images,
  }) = _KyoshinMonitorImageReplayData;

  factory fromJson(Map<String, dynamic> json) =>
      _$KyoshinMonitorImageReplayDataFromJson(json);

  factory fromMsgPack(List<dynamic> data) => KyoshinMonitorImageReplayData(
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
abstract class const KyoshinMonitorEewJsonReplayData._()
    with _$KyoshinMonitorEewJsonReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String json,
  }) = _KyoshinMonitorEewJsonReplayData;

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
abstract class const KeviJsonReplayData._()
    with _$KeviJsonReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required JsonType jsonType,
    required String json,
  }) = _KeviJsonReplayData;

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
abstract class const SnpLogEntryReplayData._()
    with _$SnpLogEntryReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String message,
  }) = _SnpLogEntryReplayData;

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
abstract class const AxisJsonReplayData._()
    with _$AxisJsonReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String json,
  }) = _AxisJsonReplayData;

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
abstract class const EqMonitorEewReplayData._()
    with _$EqMonitorEewReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String json,
  }) = _EqMonitorEewReplayData;

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

@freezed
abstract class const KyoshinWaveformReplayData._()
    with _$KyoshinWaveformReplayData
    implements ReplayData {
  const factory({
    required ReplayDataType type,
    required DateTime time,
    required String metadataJson,
    required Uint8List samples,
  }) = _KyoshinWaveformReplayData;

  factory fromMsgPack(List<dynamic> data) => KyoshinWaveformReplayData(
    type: ReplayDataType.kyoshinWaveform,
    time: data[0] as DateTime,
    metadataJson: data[1] as String,
    samples: data[2] as Uint8List,
  );

  KyoshinWaveformMetadata get metadata => KyoshinWaveformMetadata.fromJson(
    jsonDecode(metadataJson) as Map<String, dynamic>,
  );

  // 生のカウント値を int32 のビッグエンディアンで並べたもの。
  Int32List get counts {
    final view = ByteData.sublistView(samples);
    final result = Int32List(samples.lengthInBytes ~/ 4);
    for (var i = 0; i < result.length; i++) {
      result[i] = view.getInt32(i * 4);
    }
    return result;
  }

  @override
  String toString() =>
      'KyoshinWaveformReplayData(time: $time, '
      'samples: ${samples.lengthInBytes ~/ 4})';
}

@JsonEnum(valueField: 'value')
enum ReplayDataType(final int value) {
  jmaXmlTelegram(0),
  jmaBinaryTelegram(1),
  kyoshinMonitorImage(100),
  kyoshinMonitorEewJson(101),
  keviJson(1000),
  snpLogEntry(1001),
  axisJson(1002),
  eqMonitorEew(1003),
  kyoshinWaveform(1005),
}

enum ImageType(final int value) {
  shindo(0),
  pga(1),
  pgv(2),
  psWave(3),
  estShindo(4),
}

enum JsonType(final int value) {
  eew(0),
  eewWarning(1),
}
