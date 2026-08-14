import 'package:eqmonitor_map/src/tile/remote/map_http_range_validators.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_http_response_headers.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_tile_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validator = MapHttpRangeResponseValidator();
  const strongEtag = '"v3-abc"';

  String validate({
    int statusCode = 206,
    Map<String, List<String>>? rawHeaders,
    int bodyLength = 16,
    int requestedOffset = 100,
    int requestedLength = 16,
    int expectedTotalSize = 4096,
    String? expectedEtag = strongEtag,
  }) => validator.validate(
    statusCode: statusCode,
    headers: MapRemoteHttpResponseHeaders(
      rawHeaders ??
          {
            'ETag': [strongEtag],
            'Content-Range': ['bytes 100-115/4096'],
          },
    ),
    bodyLength: bodyLength,
    requestedOffset: requestedOffset,
    requestedLength: requestedLength,
    expectedTotalSize: expectedTotalSize,
    expectedEtag: expectedEtag,
  );

  group('MapHttpRangeResponseValidator', () {
    test('accepts a well-formed 206 partial response', () {
      expect(validate(), strongEtag);
    });

    test('returns the received strong ETag when none was expected yet', () {
      expect(validate(expectedEtag: null), strongEtag);
    });

    test('rejects a 412 as a snapshot mismatch', () {
      expect(
        () => validate(statusCode: 412),
        throwsA(isA<MapRemoteTileSnapshotMismatchException>()),
      );
    });

    test('rejects a 200 full-body response for a Range request', () {
      expect(
        () => validate(statusCode: 200),
        throwsA(isA<MapRemoteTileUnexpectedStatusException>()),
      );
    });

    test('rejects a weak or missing ETag', () {
      expect(
        () => validate(
          rawHeaders: {
            'ETag': ['W/"v3-abc"'],
            'Content-Range': ['bytes 100-115/4096'],
          },
        ),
        throwsA(isA<MapRemoteTileWeakValidatorException>()),
      );
      expect(
        () => validate(
          rawHeaders: {
            'Content-Range': ['bytes 100-115/4096'],
          },
        ),
        throwsA(isA<MapRemoteTileWeakValidatorException>()),
      );
    });

    test('rejects an ETag that drifted from the expected snapshot', () {
      expect(
        () => validate(
          rawHeaders: {
            'ETag': ['"v4-xyz"'],
            'Content-Range': ['bytes 100-115/4096'],
          },
        ),
        throwsA(isA<MapRemoteTileSnapshotMismatchException>()),
      );
    });

    test('rejects a Content-Range whose total size is unstable', () {
      expect(
        () => validate(
          rawHeaders: {
            'ETag': [strongEtag],
            'Content-Range': ['bytes 100-115/9999'],
          },
        ),
        throwsA(isA<MapRemoteTileContentRangeMismatchException>()),
      );
    });

    test('rejects a body length that does not match the requested range', () {
      expect(
        () => validate(bodyLength: 8),
        throwsA(isA<MapRemoteTileBodyLengthMismatchException>()),
      );
    });
  });
}
