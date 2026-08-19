import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_uuid_index.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  final invalid = throwsA(
    isA<SeismicityPmTilesInvalidDescriptorException>(),
  );

  test('supports zero expected UUIDs and rejects invalid input', () {
    for (final count in [-1, 0x40000000]) {
      expect(
        () => SeismicityUuidIndex(expectedUniqueCount: count),
        invalid,
      );
    }
    final index = SeismicityUuidIndex(expectedUniqueCount: 0);
    expect(index.find(id: uuid(1), equals: unreachable), isNull);
    expect(
      () => index.insert(id: uuid(1), rowIndex: 0, equals: unreachable),
      invalid,
    );
    final one = SeismicityUuidIndex(expectedUniqueCount: 1);
    expect(
      () => one.insert(id: Uint8List(15), rowIndex: 0, equals: unreachable),
      invalid,
    );
    expect(() => index.find(id: Uint8List(15), equals: unreachable), invalid);
    expect(
      () => SeismicityUuidIndex(
        expectedUniqueCount: 1,
        allocateSlots: (_) => throw const OutOfMemoryError(),
      ),
      invalid,
    );
  });

  test('finds first and last rows at fixed capacity', () {
    final stored = [uuid(1), uuid(2)];
    final index = SeismicityUuidIndex(expectedUniqueCount: stored.length);
    bool equals({required int rowIndex, required Uint8List candidate}) =>
        bytesEqual(left: stored[rowIndex], right: candidate);

    expect(index.find(id: stored.first, equals: equals), isNull);
    index.insert(id: stored.first, rowIndex: 0, equals: equals);
    index.insert(id: stored.last, rowIndex: 1, equals: equals);
    expect(index.find(id: stored.first, equals: equals), 0);
    expect(index.find(id: stored.last, equals: equals), 1);
    expect(
      () => index.insert(id: stored.first, rowIndex: 0, equals: equals),
      invalid,
    );
    expect(
      () => index.insert(id: uuid(3), rowIndex: 2, equals: equals),
      invalid,
    );
  });

  test('resolves equal FNV-1a hashes by exact UUID bytes', () {
    final stored = [collisionA, collisionB];
    final index = SeismicityUuidIndex(expectedUniqueCount: stored.length);
    bool equals({required int rowIndex, required Uint8List candidate}) =>
        bytesEqual(left: stored[rowIndex], right: candidate);

    expect(seismicityUuidHash(id: collisionA), 371863557);
    expect(seismicityUuidHash(id: collisionB), 371863557);
    index.insert(id: collisionA, rowIndex: 0, equals: equals);
    index.insert(id: collisionB, rowIndex: 1, equals: equals);
    expect(index.find(id: Uint8List.fromList(collisionA), equals: equals), 0);
    expect(index.find(id: Uint8List.fromList(collisionB), equals: equals), 1);
  });
}

bool unreachable({required int rowIndex, required Uint8List candidate}) =>
    throw StateError(
      'Unexpected comparison at row $rowIndex for ${candidate.length} bytes.',
    );

bool bytesEqual({required Uint8List left, required Uint8List right}) {
  if (left.length != right.length) {
    return false;
  }
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) {
      return false;
    }
  }
  return true;
}

Uint8List uuid(int lastByte) => Uint8List(16)..last = lastByte;

Uint8List collision({required int high, required int low}) => Uint8List(16)
  ..setRange(6, 8, [high, low])
  ..setRange(14, 16, [high, low]);

final Uint8List collisionA = collision(high: 16, low: 151);
final Uint8List collisionB = collision(high: 200, low: 160);
