import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:pmtiles_v3/src/archive/pmtiles_v3_bounded_bytes_sink.dart';
import 'package:test/test.dart';

void main() {
  test('accepts chunks through N and rejects N+1 before appending it', () {
    final sink = PmTilesV3BoundedBytesSink(
      maxBytes: 3,
      resource: PmTilesV3Resource.tileDecoded,
    )..add([1, 2]);

    expect(
      () => sink.add([3, 4]),
      throwsA(
        isA<PmTilesV3ResourceLimitExceededException>()
            .having(
              (exception) => exception.limit,
              'limit',
              3,
            )
            .having(
              (exception) => exception.actual,
              'actual',
              4,
            ),
      ),
    );

    sink
      ..add([3])
      ..close();
    expect(sink.takeBytes(), orderedEquals([1, 2, 3]));
  });

  test('requires a non-negative cap and close before bytes are taken', () {
    expect(
      () => PmTilesV3BoundedBytesSink(
        maxBytes: -1,
        resource: PmTilesV3Resource.directoryDecoded,
      ),
      throwsArgumentError,
    );
    final sink = PmTilesV3BoundedBytesSink(
      maxBytes: 0,
      resource: PmTilesV3Resource.directoryDecoded,
    );
    expect(sink.takeBytes, throwsStateError);
    sink.close();
  });
}
