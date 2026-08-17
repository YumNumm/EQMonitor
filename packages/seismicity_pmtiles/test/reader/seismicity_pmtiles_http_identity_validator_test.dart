import 'package:dio/dio.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_exception.dart';
import 'package:seismicity_pmtiles/src/model/seismicity_pmtiles_source.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_http_identity_validator.dart';
import 'package:test/test.dart';

const validator = SeismicityPmTilesHttpIdentityValidator();
final source = SeismicityPmTilesNetworkSource(
  archiveUri: Uri.parse('https://example.com/archive.pmtiles'),
);

void main() {
  test('returns exact strong ETag for 206', () {
    final etag = validator.validate(
      statusCode: 206,
      headers: Headers.fromMap(<String, List<String>>{
        'etag': <String>['"v1"'],
      }),
      source: source,
      expectedEtag: null,
    );

    expect(etag, '"v1"');
  });

  test('412 is archiveChanged because validateStatus admitted it', () {
    expect(
      () => validator.validate(
        statusCode: 412,
        headers: Headers.fromMap(<String, List<String>>{
          'etag': <String>['"v2"'],
        }),
        source: source,
        expectedEtag: '"v1"',
      ),
      throwsA(
        isA<SeismicityPmTilesArchiveChangedException>()
            .having((failure) => failure.expectedEtag, 'expectedEtag', '"v1"')
            .having((failure) => failure.receivedEtag, 'receivedEtag', '"v2"')
            .having((failure) => failure.statusCode, 'statusCode', 412),
      ),
    );
  });

  for (final status in <int>[200, 204, 404]) {
    test('rejects status $status as protocol failure', () {
      expect(
        () => validator.validate(
          statusCode: status,
          headers: Headers(),
          source: source,
          expectedEtag: null,
        ),
        throwsA(
          isA<SeismicityPmTilesInvalidNetworkResponseException>()
              .having((failure) => failure.statusCode, 'statusCode', status)
              .having(
                (failure) => failure.reason,
                'reason',
                'Expected HTTP 206 Partial Content.',
              ),
        ),
      );
    });
  }

  for (final received in <String?>[
    null,
    '*',
    'W/"v1"',
    'v1',
    '"v"1"',
    '"v2"',
  ]) {
    test('rejects archive identity $received', () {
      expect(
        () => validator.validate(
          statusCode: 206,
          headers: Headers.fromMap(<String, List<String>>{
            if (received != null) 'etag': <String>[received],
          }),
          source: source,
          expectedEtag: '"v1"',
        ),
        throwsA(
          isA<SeismicityPmTilesArchiveChangedException>()
              .having((failure) => failure.expectedEtag, 'expectedEtag', '"v1"')
              .having(
                (failure) => failure.receivedEtag,
                'receivedEtag',
                received,
              )
              .having((failure) => failure.statusCode, 'statusCode', 206),
        ),
      );
    });
  }
}
