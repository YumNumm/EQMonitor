import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_utf8_arena.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  final invalid = throwsA(
    isA<SeismicityPmTilesInvalidDescriptorException>(),
  );

  test('appends exact UTF-8 entries without retaining input aliases', () {
    final arena = SeismicityUtf8Arena(maxBytes: 32, maxEntries: 4);
    final ascii = Uint8List.fromList([65]);
    final multibyte = Uint8List.fromList(utf8.encode('震源'));

    expect(arena.append(valueUtf8: Uint8List(0)), 0);
    expect(arena.append(valueUtf8: ascii), 1);
    ascii[0] = 90;
    expect(arena.append(valueUtf8: Uint8List.fromList([65])), 2);
    expect(arena.append(valueUtf8: multibyte), 3);

    expect(
      arena.equalsAt(index: 0, candidateUtf8: Uint8List(0)),
      isTrue,
    );
    expect(arena.equalsAt(index: 1, candidateUtf8: ascii), isFalse);
    expect(
      arena.equalsAt(index: 2, candidateUtf8: Uint8List.fromList([65])),
      isTrue,
    );
    expect(arena.equalsAt(index: 3, candidateUtf8: multibyte), isTrue);

    final output = arena.build();
    expect(output.bytes, [65, 65, ...multibyte]);
    expect(output.entryOffsets, [0, 0, 1, 2, 2 + multibyte.length]);
    expect(output.bytes.length, 2 + multibyte.length);
    expect(output.entryOffsets.length, 5);
  });

  test('rejects typed limits before changing stored entries', () {
    for (final create in <SeismicityUtf8Arena Function()>[
      () => SeismicityUtf8Arena(maxBytes: -1, maxEntries: 0),
      () => SeismicityUtf8Arena(maxBytes: 0x100000000, maxEntries: 0),
      () => SeismicityUtf8Arena(maxBytes: 0, maxEntries: -1),
      () => SeismicityUtf8Arena(maxBytes: 0, maxEntries: 0x100000000),
    ]) {
      expect(create, invalid);
    }

    final byteLimited = SeismicityUtf8Arena(maxBytes: 1, maxEntries: 2);
    byteLimited.append(valueUtf8: Uint8List.fromList([1]));
    expect(
      () => byteLimited.append(valueUtf8: Uint8List.fromList([2])),
      invalid,
    );
    expect(byteLimited.build().bytes, [1]);

    final entryLimited = SeismicityUtf8Arena(maxBytes: 2, maxEntries: 1);
    entryLimited.append(valueUtf8: Uint8List.fromList([1]));
    expect(
      () => entryLimited.append(valueUtf8: Uint8List(0)),
      invalid,
    );
    expect(
      () => entryLimited.equalsAt(index: 1, candidateUtf8: Uint8List(0)),
      invalid,
    );
    expect(entryLimited.build().entryOffsets, [0, 1]);
  });

  test('translates build allocation failures without changing entries', () {
    var failBytes = true;
    final bytesArena = SeismicityUtf8Arena(
      maxBytes: 1,
      maxEntries: 1,
      allocateBuildBytes: (length) {
        if (failBytes) {
          failBytes = false;
          throw const OutOfMemoryError();
        }
        return Uint8List(length);
      },
    );
    var failOffsets = true;
    final offsetsArena = SeismicityUtf8Arena(
      maxBytes: 1,
      maxEntries: 1,
      allocateBuildOffsets: (length) {
        if (failOffsets) {
          failOffsets = false;
          throw RangeError('injected offset allocation failure');
        }
        return Uint32List(length);
      },
    );

    for (final arena in [bytesArena, offsetsArena]) {
      final value = Uint8List.fromList([7]);
      arena.append(valueUtf8: value);
      expect(arena.build, invalid);
      expect(arena.equalsAt(index: 0, candidateUtf8: value), isTrue);
      final output = arena.build();
      expect(output.bytes, [7]);
      expect(output.entryOffsets, [0, 1]);
    }
  });
}
