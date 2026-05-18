import 'dart:convert';
import 'dart:typed_data';

import 'package:earthquake_replay/earthquake_replay.dart';
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
}

final _emptyReplayFileBytes = Uint8List.fromList([
  ...utf8.encode('EQRP'),
  ..._headerBytes,
  0x90,
]);

const _headerBytes = [
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

const _timestampBytes = [0xd6, 0xff, 0x00, 0x00, 0x00, 0x00];
