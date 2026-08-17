import 'package:eqmonitor_map/src/tile/remote/map_http_identity_validator.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_http_response_headers.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_tile_exception.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validator = MapHttpIdentityValidator();

  MapRemoteHttpResponseHeaders headers(Map<String, List<String>> raw) =>
      MapRemoteHttpResponseHeaders(raw);

  group('MapHttpIdentityValidator', () {
    test('accepts a response with no Content-Encoding header', () {
      expect(() => validator.validate(headers: headers({})), returnsNormally);
    });

    test('accepts an explicit identity Content-Encoding (any case)', () {
      expect(
        () => validator.validate(
          headers: headers({
            'Content-Encoding': ['identity'],
          }),
        ),
        returnsNormally,
      );
      expect(
        () => validator.validate(
          headers: headers({
            'content-encoding': ['Identity'],
          }),
        ),
        returnsNormally,
      );
    });

    test('rejects compressed encodings with a typed error', () {
      for (final encoding in ['gzip', 'br', 'deflate', 'zstd', 'GZIP']) {
        expect(
          () => validator.validate(
            headers: headers({
              'Content-Encoding': [encoding],
            }),
          ),
          throwsA(isA<MapRemoteTileNonIdentityEncodingException>()),
          reason: 'encoding $encoding must be rejected',
        );
      }
    });

    test('rejects multi-valued encodings that include a transform', () {
      expect(
        () => validator.validate(
          headers: headers({
            'Content-Encoding': ['identity', 'gzip'],
          }),
        ),
        throwsA(isA<MapRemoteTileNonIdentityEncodingException>()),
      );
    });
  });
}
