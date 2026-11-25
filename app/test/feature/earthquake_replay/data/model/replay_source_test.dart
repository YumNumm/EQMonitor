import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final start = DateTime.utc(2024, 1, 6, 14, 20, 8);
  final lastEew = start.add(const Duration(seconds: 85));
  final headerEnd = start.add(const Duration(seconds: 266));

  ReplaySource source(List<ReplayData> frames) => ReplaySource.eqrp(
    file: ReplayFile(
      header: ReplayFileHeader(
        version: 0,
        softwareName: 'test',
        startTime: start,
        endTime: headerEnd,
        compressionMode: .gzip,
      ),
      data: frames,
    ),
    name: 'test',
    originTime: null,
  );

  final eew = EqMonitorEewReplayData(
    type: .eqMonitorEew,
    time: lastEew,
    json: '{}',
  );
  final waveform = KyoshinWaveformReplayData(
    type: .kyoshinWaveform,
    time: start.subtract(const Duration(seconds: 3)),
    metadataJson: '{}',
    samples: Uint8List(0),
  );

  group('ReplaySource.endTime', () {
    test('K-NET/KiK-net の波形を含む場合はヘッダの終了時刻まで再生すること', () {
      expect(source([waveform, eew]).endTime, headerEnd);
    });

    test('波形を含まない場合は最後のフレームの時刻で終えること', () {
      expect(source([eew]).endTime, lastEew);
    });
  });
}
