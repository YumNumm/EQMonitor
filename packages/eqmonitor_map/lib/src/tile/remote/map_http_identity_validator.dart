import 'package:eqmonitor_map/src/tile/remote/map_remote_http_response_headers.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_tile_exception.dart';

/// remote PMTiles 応答の `Content-Encoding` が identity(=変換なし)であることを
/// 検証する。
///
/// random-access Range reader は byte offset で archive を切り出すため、
/// 転送時に圧縮変換が入ると offset がずれて安全に読めない。よって
/// `Content-Encoding` が欠損または `identity` のときだけ通し、それ以外
/// (gzip / br / deflate / zstd など、あるいは transform を含む複数値)は
/// [MapRemoteTileNonIdentityEncodingException]で fail closed する。
final class MapHttpIdentityValidator {
  const MapHttpIdentityValidator();

  void validate({required MapRemoteHttpResponseHeaders headers}) {
    final encodings = headers.valuesOf('content-encoding');
    if (encodings == null || encodings.isEmpty) {
      return;
    }
    final isIdentityOnly =
        encodings.length == 1 &&
        encodings.single.trim().toLowerCase() == 'identity';
    if (isIdentityOnly) {
      return;
    }
    throw MapRemoteTileNonIdentityEncodingException(
      contentEncoding: encodings,
    );
  }
}
