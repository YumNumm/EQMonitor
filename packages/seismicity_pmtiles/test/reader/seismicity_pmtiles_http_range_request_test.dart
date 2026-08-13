import 'package:dio/dio.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';
import 'package:seismicity_pmtiles/src/reader/seismicity_pmtiles_http_range_request.dart';
import 'package:test/test.dart';

void main() {
  test('builds exact byte Options and admits protocol statuses', () {
    final options = const SeismicityPmTilesHttpRangeRequestBuilder().build(
      offset: 4,
      length: 3,
      sizeBytes: 16,
      strongEtag: '"v1"',
    );

    expect(options.headers?['Range'], 'bytes=4-6');
    expect(options.headers?['If-Match'], '"v1"');
    expect(options.responseType, ResponseType.bytes);
    final validateStatus = options.validateStatus;
    if (validateStatus == null) {
      fail('validateStatus must be configured.');
    }
    expect(
      <int>[200, 204, 206, 404, 412].map(validateStatus),
      everyElement(isTrue),
    );
    expect(<int?>[500, null].map(validateStatus), everyElement(isFalse));
  });

  for (final valid in <String>['""', '"archive-v1"', '"!#~ÿ"']) {
    test('accepts strong ETag $valid', () {
      expect(
        const SeismicityPmTilesStrongEtagValidator().isValid(value: valid),
        isTrue,
      );
    });
  }

  for (final invalid in <String>[
    '*',
    'W/"v1"',
    'v1',
    '"v"1"',
    '"line\nbreak"',
    '"Ā"',
  ]) {
    test('rejects ETag $invalid', () {
      expect(
        const SeismicityPmTilesStrongEtagValidator().isValid(value: invalid),
        isFalse,
      );
    });
  }

  test('rejects an out-of-bounds range before building Options', () {
    expect(
      () => const SeismicityPmTilesHttpRangeRequestBuilder().build(
        offset: 15,
        length: 2,
        sizeBytes: 16,
        strongEtag: null,
      ),
      throwsA(
        isA<PmTilesV3InvalidRangeException>()
            .having((failure) => failure.offset, 'offset', 15)
            .having((failure) => failure.length, 'length', 2)
            .having((failure) => failure.sizeBytes, 'sizeBytes', 16),
      ),
    );
  });
}
