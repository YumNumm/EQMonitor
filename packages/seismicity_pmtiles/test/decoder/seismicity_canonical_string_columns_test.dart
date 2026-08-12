import 'dart:convert';
import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_canonical_string_columns.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_validity_bitmap.dart';
import 'package:test/test.dart';

void main() {
  final invalid = throwsA(
    isA<SeismicityPmTilesInvalidDescriptorException>(),
  );

  test('stores exact determination and event UTF-8 columns', () {
    final multibyte = bytes('震源');
    final columns = SeismicityCanonicalStringColumns(capacity: 10)
      ..add(determinationFlagUtf8: null, earthquakeEventIdUtf8: null)
      ..add(
        determinationFlagUtf8: Uint8List(0),
        earthquakeEventIdUtf8: bytes('E1'),
      )
      ..add(
        determinationFlagUtf8: bytes('A'),
        earthquakeEventIdUtf8: bytes('E1'),
      )
      ..add(
        determinationFlagUtf8: multibyte,
        earthquakeEventIdUtf8: multibyte,
      );

    expect((columns.length, columns.isFull), (4, false));
    final output = columns.build();
    expect(output.determinationFlag.dictionaryIndexes, isA<Uint32List>());
    expect(output.earthquakeEventId.dictionaryIndexes, isA<Uint32List>());
    expect(output.determinationFlag.dictionaryIndexes, [0, 0, 1, 2]);
    expect(output.determinationFlag.validity, [14]);
    expect(output.determinationFlag.dictionaryUtf8, [65, ...multibyte]);
    expect(
      output.determinationFlag.dictionaryOffsets,
      [0, 0, 1, 1 + multibyte.length],
    );
    expect(output.earthquakeEventId.dictionaryIndexes, [0, 0, 0, 1]);
    expect(output.earthquakeEventId.validity, [14]);
    expect(output.earthquakeEventId.dictionaryUtf8, [69, 49, ...multibyte]);
    expect(
      output.earthquakeEventId.dictionaryOffsets,
      [0, 2, 2 + multibyte.length],
    );
    expect(
      SeismicityValidityBitmap.isValid(
        bytes: output.determinationFlag.validity,
        index: 0,
      ),
      isFalse,
    );
  });

  test('rejects empty event IDs and additions after full', () {
    final columns = SeismicityCanonicalStringColumns(capacity: 1);
    expect(
      () => columns.add(
        determinationFlagUtf8: bytes('unused'),
        earthquakeEventIdUtf8: Uint8List(0),
      ),
      invalid,
    );
    expect(columns.length, 0);
    columns.add(
      determinationFlagUtf8: Uint8List(0),
      earthquakeEventIdUtf8: bytes('E'),
    );
    expect(columns.isFull, isTrue);
    expect(
      () => columns.add(
        determinationFlagUtf8: null,
        earthquakeEventIdUtf8: null,
      ),
      invalid,
    );
    expect(columns.length, 1);
  });

  test('builds exact empty typed output', () {
    final output = SeismicityCanonicalStringColumns(capacity: 0).build();
    expect(output.determinationFlag.dictionaryIndexes, isEmpty);
    expect(output.determinationFlag.validity, isEmpty);
    expect(output.determinationFlag.dictionaryUtf8, isEmpty);
    expect(output.determinationFlag.dictionaryOffsets, [0]);
    expect(output.earthquakeEventId.dictionaryIndexes, isEmpty);
    expect(output.earthquakeEventId.validity, isEmpty);
    expect(output.earthquakeEventId.dictionaryUtf8, isEmpty);
    expect(output.earthquakeEventId.dictionaryOffsets, [0]);
  });
}

Uint8List bytes(String value) => Uint8List.fromList(utf8.encode(value));
