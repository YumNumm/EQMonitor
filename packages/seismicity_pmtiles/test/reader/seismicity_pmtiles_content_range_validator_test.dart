import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_content_range_validator.dart';
import 'package:test/test.dart';

const validator = SeismicityPmTilesContentRangeValidator();
final source = SeismicityPmTilesNetworkSource(
  archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
);

void main() {
  test('returns copied bytes for exact range and length', () {
    final input = Uint8List.fromList(<int>[4, 5, 6]);

    final output = validator.validate(
      headers: Headers.fromMap(<String, List<String>>{
        'content-range': <String>['bytes 4-6/16'],
      }),
      bytes: input,
      source: source,
      requestedOffset: 4,
      requestedLength: 3,
      expectedSizeBytes: 16,
    );

    expect(output, orderedEquals(<int>[4, 5, 6]));
    expect(identical(output, input), isFalse);
  });

  for (final value in <String?>[
    null,
    'bytes 5-7/16',
    'bytes 4-7/16',
    'bytes 4-6/15',
    'bytes 4-6/*',
  ]) {
    test('rejects Content-Range $value', () {
      expect(
        () => validator.validate(
          headers: Headers.fromMap(<String, List<String>>{
            if (value != null) 'content-range': <String>[value],
          }),
          bytes: Uint8List.fromList(<int>[4, 5, 6]),
          source: source,
          requestedOffset: 4,
          requestedLength: 3,
          expectedSizeBytes: 16,
        ),
        throwsA(
          isA<SeismicityPmTilesInvalidNetworkResponseException>()
              .having((failure) => failure.statusCode, 'statusCode', 206)
              .having(
                (failure) => failure.reason,
                'reason',
                'Content-Range must equal bytes 4-6/16.',
              ),
        ),
      );
    });
  }

  test('rejects short body with exact typed reason', () {
    expect(
      () => validator.validate(
        headers: Headers.fromMap(<String, List<String>>{
          'content-range': <String>['bytes 4-6/16'],
        }),
        bytes: Uint8List.fromList(<int>[4, 5]),
        source: source,
        requestedOffset: 4,
        requestedLength: 3,
        expectedSizeBytes: 16,
      ),
      throwsA(
        isA<SeismicityPmTilesInvalidNetworkResponseException>().having(
          (failure) => failure.reason,
          'reason',
          'Expected 3 response bytes but received 2.',
        ),
      ),
    );
  });
}
