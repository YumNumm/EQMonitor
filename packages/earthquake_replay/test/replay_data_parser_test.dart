import 'dart:convert';
import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
import 'package:msgpack_dart/msgpack_dart.dart';
import 'package:test/test.dart';

void main() {
  group('ReplayDataParser', () {
    test('rejects an empty replay data file', () {
      final parser = ReplayDataParser();

      expect(
        () => parser.parse(_emptyReplayFileBytes),
        throwsA(isA<FormatException>()),
      );
    });
  });

  group('ReplayDataWriter', () {
    test('書き出したファイルを ReplayDataParser が同じ内容で読めること', () {
      final start = DateTime.utc(2024, 1, 1, 7, 10);
      final frames = <ReplayData>[
        EqMonitorEewReplayData(
          type: .eqMonitorEew,
          time: start.add(const Duration(seconds: 1, milliseconds: 900)),
          json: '{"eventId":"20240101161010"}',
        ),
        KyoshinMonitorImageReplayData(
          type: .kyoshinMonitorImage,
          time: start.add(const Duration(seconds: 1)),
          images: {
            ImageType.shindo: [1, 2, 3],
            ImageType.pgv: List<int>.filled(300, 7),
          },
        ),
        KyoshinMonitorImageReplayData(
          type: .kyoshinMonitorImage,
          time: start,
          images: {
            ImageType.shindo: [4],
          },
        ),
      ];

      final bytes = const ReplayDataWriter().write(
        softwareName: 'test',
        startTime: start,
        endTime: start.add(const Duration(seconds: 2)),
        frames: frames,
      );
      final file = ReplayDataParser().parse(bytes);

      expect(file.header.softwareName, 'test');
      expect(file.header.startTime, start);
      expect(file.header.endTime, start.add(const Duration(seconds: 2)));
      expect(file.header.compressionMode, ReplayFileCompressionMode.gzip);
      expect(file.data, [frames[2], frames[1], frames[0]]);
    });

    test('時刻は JST の壁時計を UTC として timestamp 64 に格納すること', () {
      final encoded = const ReplayTimestampEncoder().encodeObject(
        DateTime.utc(2024, 1, 1, 7, 10, 8, 500),
      );

      expect(encoded, hasLength(8));
      expect(
        ExtTimeStampDecoder().decodeObject(0xFF, encoded),
        DateTime.utc(2024, 1, 1, 16, 10, 8, 500),
      );
    });
  });
}

final _emptyReplayFileBytes = Uint8List.fromList([
  ...utf8.encode('EQRP'),
  ..._headerBytes,
  0x90,
]);

const _headerBytes = <int>[
  0x95,
  0x00,
  0xa4,
  0x74,
  0x65,
  0x73,
  0x74,
  ..._timestampBytes,
  ..._timestampBytes,
  0x00,
];

const _timestampBytes = <int>[0xd6, 0xff, 0x00, 0x00, 0x00, 0x00];
