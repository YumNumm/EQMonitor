import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'replay_data.freezed.dart';

@freezed
class ReplayData with _$ReplayData {
  const factory ReplayData.jmaXmlTelegramReplayData({
    required String title,
    required String telegram,
  }) = JmaXmlTelegramReplayData;

  const factory ReplayData.jmaBinaryTelegramReplayData({
    required String type,
    required Uint8List data,
  }) = JmaBinaryTelegramReplayData;

  const factory ReplayData.kyoshinMonitorImageReplayData({
    required Map<ImageType, Uint8List> images,
  }) = KyoshinMonitorImageReplayData;

  const factory ReplayData.kyoshinMonitorEewJsonReplayData({
    required String json,
  }) = KyoshinMonitorEewJsonReplayData;

  const factory ReplayData.keviJsonReplayData({
    required JsonType type,
    required String json,
  }) = KeviJsonReplayData;

  const factory ReplayData.snpLogEntryReplayData({
    required String message,
  }) = SnpLogEntryReplayData;

  const factory ReplayData.axisJsonReplayData({
    required String json,
  }) = AxisJsonReplayData;
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
