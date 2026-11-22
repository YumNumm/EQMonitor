import 'dart:io';
import 'dart:typed_data';

import 'package:earthquake_replay/src/model/replay_data.dart';
import 'package:earthquake_replay/src/model/replay_file_header.dart';
import 'package:earthquake_replay/src/parser/replay_data_parser.dart';
import 'package:earthquake_replay/src/writer/replay_timestamp_encoder.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

class const ReplayDataWriter() {
  Uint8List write({
    required String softwareName,
    required DateTime startTime,
    required DateTime endTime,
    required List<ReplayData> frames,
  }) {
    if (frames.isEmpty) {
      throw ArgumentError.value(frames, 'frames', 'Must not be empty');
    }
    // 読み込み側は時刻の二分探索で再生位置を求めるため、時刻順に並べる。
    final indices = List<int>.generate(frames.length, (index) => index)
      ..sort((a, b) {
        final byTime = frames[a].time.compareTo(frames[b].time);
        return byTime != 0 ? byTime : a.compareTo(b);
      });
    final header = Serializer(extEncoder: const ReplayTimestampEncoder())
      ..encode([
        0,
        softwareName,
        startTime,
        endTime,
        ReplayFileCompressionMode.gzip.value,
      ]);
    final body = Serializer(extEncoder: const ReplayTimestampEncoder())
      ..encode([for (final index in indices) encodeFrame(frames[index])]);
    return (BytesBuilder(copy: false)
          ..add(ReplayDataParser.magicHeader)
          ..add(header.takeBytes())
          ..add(gzip.encode(body.takeBytes())))
        .takeBytes();
  }

  List<Object> encodeFrame(ReplayData frame) => [
    frame.type.value,
    switch (frame) {
      JmaXmlTelegramReplayData(:final time, :final title, :final telegram) => [
        time,
        title,
        telegram,
      ],
      JmaBinaryTelegramReplayData(
        :final time,
        :final telegramType,
        :final data,
      ) =>
        [time, telegramType, Uint8List.fromList(data)],
      KyoshinMonitorImageReplayData(:final time, :final images) => [
        time,
        {
          for (final MapEntry(:key, :value) in images.entries)
            key.value: Uint8List.fromList(value),
        },
      ],
      KyoshinMonitorEewJsonReplayData(:final time, :final json) => [time, json],
      KeviJsonReplayData(:final time, :final jsonType, :final json) => [
        time,
        jsonType.value,
        json,
      ],
      SnpLogEntryReplayData(:final time, :final message) => [time, message],
      AxisJsonReplayData(:final time, :final json) => [time, json],
      EqMonitorEewReplayData(:final time, :final json) => [time, json],
    },
  ];
}
