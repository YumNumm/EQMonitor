import 'dart:typed_data';

import 'package:seismicity_pmtiles/src/decoder/seismicity_chunk_builder.dart';
import 'package:seismicity_pmtiles/src/decoder/seismicity_decoded_hypocenter.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:test/test.dart';

void main() {
  final poisoned = throwsA(
    isA<SeismicityPmTilesInvalidDescriptorException>().having(
      (error) => error.reason,
      'reason',
      'Public chunk builder is poisoned.',
    ),
  );

  test('poisons every operation after either later store fails', () {
    for (final builder in [
      SeismicityChunkBuilder(
        capacity: 1,
        beforeCanonicalAdd: throwInjectedFailure,
      ),
      SeismicityChunkBuilder(
        capacity: 1,
        beforeIntensityAdd: throwInjectedFailure,
      ),
    ]) {
      final record = row(index: 0);
      expect(
        () => builder.add(record: record),
        throwsA(
          isA<SeismicityPmTilesInvalidDescriptorException>().having(
            (error) => error.reason,
            'reason',
            'Injected later-store failure.',
          ),
        ),
      );
      final operations = <void Function()>[
        () => builder.length,
        () => builder.isFull,
        () => builder.add(record: record),
        () => builder.uuidEquals(
          rowIndex: 0,
          candidate: record.hypocenterId,
        ),
        () => builder.originTimeEquals(
          rowIndex: 0,
          candidate: record.originTimeUnixMilliseconds,
        ),
        () => builder.matches(localIndex: 0, record: record),
        builder.build,
      ];
      for (final operation in operations) {
        expect(operation, poisoned);
      }
    }
  });

  test('capacity preflight rejects atomically without poisoning', () {
    final stored = row(index: 0);
    final builder = SeismicityChunkBuilder(capacity: 1)..add(record: stored);

    expect(
      () => builder.add(record: row(index: 1)),
      throwsA(isA<SeismicityPmTilesInvalidDescriptorException>()),
    );
    expect((builder.length, builder.isFull), (1, true));
    expect(builder.originTimeEquals(rowIndex: 0, candidate: 10), isTrue);
    expect(builder.build().latitudes, [35]);
  });
}

Never throwInjectedFailure() =>
    throw const SeismicityPmTilesException.invalidDescriptor(
      reason: 'Injected later-store failure.',
    );

SeismicityDecodedHypocenter row({required int index}) =>
    SeismicityDecodedHypocenter(
      tileId: 1,
      featureIndex: index,
      hypocenterId: Uint8List.fromList(List.generate(16, (i) => index + i)),
      point: (
        globalX: index,
        globalY: index,
        longitude: 139 + index.toDouble(),
        latitude: 35 + index.toDouble(),
      ),
      originTimeUnixMilliseconds: 10 + index,
      magnitude: null,
      depthKm: null,
      maxIntensityUtf8: Uint8List.fromList([53]),
      determinationFlagUtf8: null,
      earthquakeEventIdUtf8: null,
      geometryClamped: null,
    );
