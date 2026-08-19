import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_intensity_dictionary.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';
import 'package:test/test.dart';

void main() {
  final invalid = throwsA(
    isA<SeismicityPmTilesInvalidDescriptorException>(),
  );

  test('stores and trims exact max-intensity dictionary columns', () {
    final multibyte = bytes('5弱');
    final columns = SeismicityChunkIntensityDictionary(capacity: 4)
      ..add(maxIntensityUtf8: null)
      ..add(maxIntensityUtf8: Uint8List(0))
      ..add(maxIntensityUtf8: Uint8List(0))
      ..add(maxIntensityUtf8: multibyte);

    expect((columns.length, columns.isFull), (4, true));
    final output = columns.build();
    expect(output.dictionaryIndexes, isA<Uint32List>());
    expect(output.validity, isA<Uint8List>());
    expect(output.dictionaryUtf8, isA<Uint8List>());
    expect(output.dictionaryOffsets, isA<Uint32List>());
    expect(output.dictionaryIndexes, [0, 0, 0, 1]);
    expect(output.validity, [14]);
    expect(output.dictionaryUtf8, multibyte);
    expect(output.dictionaryOffsets, [0, 0, multibyte.length]);
    expect(
      SeismicityValidityBitmap.isValid(bytes: output.validity, index: 0),
      isFalse,
    );
    expect(() => columns.add(maxIntensityUtf8: bytes('7')), invalid);

    final trimmed = SeismicityChunkIntensityDictionary(capacity: 4)
      ..add(maxIntensityUtf8: bytes('4'));
    final trimmedOutput = trimmed.build();
    expect(trimmedOutput.dictionaryIndexes, [0]);
    expect(trimmedOutput.validity, [1]);
    expect(trimmedOutput.dictionaryUtf8, [52]);
    expect(trimmedOutput.dictionaryOffsets, [0, 1]);
  });

  test('compares transient candidates by exact UTF-8 bytes and presence', () {
    final multibyte = bytes('6強');
    final columns = SeismicityChunkIntensityDictionary(capacity: 3)
      ..add(maxIntensityUtf8: null)
      ..add(maxIntensityUtf8: Uint8List(0))
      ..add(maxIntensityUtf8: multibyte);

    expect(columns.matches(localIndex: 0, maxIntensityUtf8: null), isTrue);
    expect(
      columns.matches(localIndex: 0, maxIntensityUtf8: Uint8List(0)),
      isFalse,
    );
    expect(
      columns.matches(localIndex: 1, maxIntensityUtf8: Uint8List(0)),
      isTrue,
    );
    expect(columns.matches(localIndex: 1, maxIntensityUtf8: null), isFalse);
    expect(
      columns.matches(localIndex: 2, maxIntensityUtf8: multibyte),
      isTrue,
    );
    expect(
      columns.matches(localIndex: 2, maxIntensityUtf8: bytes('6弱')),
      isFalse,
    );
  });
}

Uint8List bytes(String value) => Uint8List.fromList(utf8.encode(value));
