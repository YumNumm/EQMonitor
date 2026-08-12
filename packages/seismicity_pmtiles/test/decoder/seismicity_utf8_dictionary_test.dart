import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_utf8_dictionary.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  final invalid = throwsA(
    isA<SeismicityPmTilesInvalidDescriptorException>(),
  );

  test('interns exact UTF-8 bytes into typed arena output', () {
    final dictionary = SeismicityUtf8Dictionary(
      maxBytes: 32,
      maxEntries: 4,
    );
    final empty = Uint8List(0);
    final ascii = bytes('A');
    final multibyte = bytes('震源');

    expect(dictionary.indexFor(valueUtf8: empty), 0);
    expect(dictionary.indexFor(valueUtf8: ascii), 1);
    expect(dictionary.indexFor(valueUtf8: Uint8List.fromList(ascii)), 1);
    expect(dictionary.indexFor(valueUtf8: multibyte), 2);
    ascii[0] = 90;

    expect(dictionary.equalsAt(index: 0, candidateUtf8: empty), isTrue);
    expect(dictionary.equalsAt(index: 1, candidateUtf8: bytes('A')), isTrue);
    expect(
      dictionary.equalsAt(index: 2, candidateUtf8: multibyte),
      isTrue,
    );

    final output = dictionary.build();
    expect(output.bytes, isA<Uint8List>());
    expect(output.entryOffsets, isA<Uint32List>());
    expect(output.bytes, [65, ...multibyte]);
    expect(output.entryOffsets, [0, 0, 1, 1 + multibyte.length]);
  });

  test('resolves equal FNV-1a hashes by exact arena slices', () {
    final first = bytes('costarring');
    final second = bytes('liquid');
    final dictionary = SeismicityUtf8Dictionary(
      maxBytes: first.length + second.length,
      maxEntries: 2,
    );

    expect(seismicityUtf8Hash(valueUtf8: first), 0x5e4daa9d);
    expect(seismicityUtf8Hash(valueUtf8: second), 0x5e4daa9d);
    expect(dictionary.indexFor(valueUtf8: first), 0);
    expect(dictionary.indexFor(valueUtf8: second), 1);
    expect(dictionary.indexFor(valueUtf8: Uint8List.fromList(first)), 0);
    expect(dictionary.indexFor(valueUtf8: Uint8List.fromList(second)), 1);
  });

  test('rejects capacity and uint32 limits without partial append', () {
    for (final create in <SeismicityUtf8Dictionary Function()>[
      () => SeismicityUtf8Dictionary(maxBytes: -1, maxEntries: 0),
      () => SeismicityUtf8Dictionary(
        maxBytes: 0x100000000,
        maxEntries: 0,
      ),
      () => SeismicityUtf8Dictionary(maxBytes: 0, maxEntries: -1),
      () => SeismicityUtf8Dictionary(maxBytes: 0, maxEntries: 0x40000000),
      () => SeismicityUtf8Dictionary(
        maxBytes: 1,
        maxEntries: 1,
        allocateSlots: (_) => throw const OutOfMemoryError(),
      ),
    ]) {
      expect(create, invalid);
    }

    final dictionary = SeismicityUtf8Dictionary(maxBytes: 2, maxEntries: 2);
    expect(dictionary.indexFor(valueUtf8: bytes('A')), 0);
    expect(dictionary.indexFor(valueUtf8: bytes('B')), 1);
    expect(dictionary.indexFor(valueUtf8: bytes('A')), 0);
    expect(() => dictionary.indexFor(valueUtf8: bytes('C')), invalid);
    expect(dictionary.build().bytes, [65, 66]);
  });
}

Uint8List bytes(String value) => Uint8List.fromList(utf8.encode(value));
