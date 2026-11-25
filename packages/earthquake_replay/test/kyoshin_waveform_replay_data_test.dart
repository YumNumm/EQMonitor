import 'dart:convert';
import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:test/test.dart';

void main() {
  // バックエンドの earthquake-archiver が JSON.stringify で書くメタデータと同じ形。
  final metadataJson = jsonEncode({
    'stationCode': 'FKSH18',
    'stationLatitude': 37.3,
    'stationLongitude': 140.5,
    'stationHeightMeters': 300,
    'recordTime': '2026-11-06T10:40:12.000Z',
    'startTime': '2026-11-06T10:39:57.000Z',
    'samplingHz': 100,
    'durationSeconds': 120,
    'direction': '4',
    'scaleNumeratorGal': 7845,
    'scaleDenominator': 8223790,
    'maxAccelerationGal': 21.891,
    'lastCorrection': null,
    'network': 'kik',
    'component': 'NS2',
    'fileName': 'FKSH182611061939.NS2',
    'eventDirectory': '20261106193900',
  });
  final samples = Uint8List.fromList([
    0x00, 0x00, 0x00, 0x01, //
    0xff, 0xff, 0xff, 0xfe, //
    0x7f, 0xff, 0xff, 0xff,
  ]);
  final time = DateTime.utc(2026, 11, 6, 10, 39, 57);

  group('KyoshinWaveformReplayData', () {
    test('type 1005 を読み、メタデータと int32 ビッグエンディアンのカウント値を取り出せること', () {
      final frame = ReplayData.fromMsgPack([
        1005,
        [time, metadataJson, samples],
      ]);

      expect(frame, isA<KyoshinWaveformReplayData>());
      final waveform = frame as KyoshinWaveformReplayData;
      expect(waveform.type, ReplayDataType.kyoshinWaveform);
      expect(waveform.time, time);
      expect(waveform.counts, [1, -2, 2147483647]);

      final metadata = waveform.metadata;
      expect(metadata.network, 'kik');
      expect(metadata.component, 'NS2');
      expect(metadata.stationCode, 'FKSH18');
      expect(metadata.stationHeightMeters, 300);
      expect(metadata.recordTime, DateTime.utc(2026, 11, 6, 10, 40, 12));
      expect(metadata.startTime, time);
      expect(metadata.samplingHz, 100);
      expect(metadata.direction, '4');
      expect(
        metadata.scaleNumeratorGal / metadata.scaleDenominator,
        7845 / 8223790,
      );
    });

    test('書き出して読み直しても同じフレームになること', () {
      final frame = KyoshinWaveformReplayData(
        type: .kyoshinWaveform,
        time: time,
        metadataJson: metadataJson,
        samples: samples,
      );

      final file = ReplayDataParser().parse(
        const ReplayDataWriter().write(
          softwareName: 'test',
          startTime: time,
          endTime: time.add(const Duration(minutes: 2)),
          frames: [frame],
        ),
      );

      expect(file.data, [frame]);
    });
  });
}
