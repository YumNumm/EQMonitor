import 'package:eqmonitor_map/src/tile/remote/map_remote_http_response_headers.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_tile_exception.dart';

final _contentRange = RegExp(r'^bytes ([0-9]+)-([0-9]+)/([0-9]+)$');

/// ちょうど1つの strong entity-tag(`"..."`)だけに一致する。`"` を内部に含む
/// 値を弾くことで、`"old", "new"` のように comma 連結された複数 tag が
/// 1つの strong validator として通ってしまうのを防ぐ。
final _singleStrongEtag = RegExp(r'^"[^"]*"$');

/// strong ETag(RFC 9110)の判定。weak validator は `W/` prefix を持つ。
///
/// random-access Range 取得では、同一 archive snapshot を跨いだ byte 整合性を
/// 保証するため strong validator を要求する(weak は byte 単位の同一性を
/// 保証しない)。
///
/// HTTP adapter が重複 `ETag` ヘッダを1つの comma 連結値
/// (`"old", "new"`)として渡してくる可能性があるため、**単一の** entity-tag で
/// あることまで検証する。曖昧な snapshot をそのまま受理しない。
final class MapHttpStrongEtagValidator {
  const MapHttpStrongEtagValidator();

  bool isStrong(String value) {
    final trimmed = value.trim();
    if (trimmed.startsWith('W/') || trimmed.startsWith('w/')) {
      return false;
    }
    return _singleStrongEtag.hasMatch(trimmed);
  }
}

/// remote PMTiles Range 応答が契約(206 / strong ETag / 厳密 Content-Range /
/// body 長一致)を満たすか検証し、確定した strong ETag を返す。
///
/// - status 412、または strong ETag が `expectedEtag` と不一致:
///   [MapRemoteTileSnapshotMismatchException](受信 byte は破棄)。
/// - status が 206 でも 412 でもない: [MapRemoteTileUnexpectedStatusException]。
/// - ETag が欠損・複数・weak: [MapRemoteTileWeakValidatorException]。
/// - Content-Range が `bytes offset-end/total` と厳密一致しない(total が
///   `expectedTotalSize` と異なる場合を含む):
///   [MapRemoteTileContentRangeMismatchException]。
/// - body 長が `requestedLength` と異なる:
///   [MapRemoteTileBodyLengthMismatchException]。
final class MapHttpRangeResponseValidator {
  const MapHttpRangeResponseValidator({
    this.etagValidator = const MapHttpStrongEtagValidator(),
  });

  final MapHttpStrongEtagValidator etagValidator;

  String validate({
    required int statusCode,
    required MapRemoteHttpResponseHeaders headers,
    required int bodyLength,
    required int requestedOffset,
    required int requestedLength,
    required int expectedTotalSize,
    required String? expectedEtag,
  }) {
    final receivedEtag = headers.singleValueOf('etag');
    if (statusCode == 412) {
      throw MapRemoteTileSnapshotMismatchException(
        expectedEtag: expectedEtag,
        receivedEtag: receivedEtag,
        statusCode: statusCode,
      );
    }
    if (statusCode != 206) {
      throw MapRemoteTileUnexpectedStatusException(statusCode: statusCode);
    }
    if (receivedEtag == null || !etagValidator.isStrong(receivedEtag)) {
      throw MapRemoteTileWeakValidatorException(receivedEtag: receivedEtag);
    }
    if (expectedEtag != null && expectedEtag != receivedEtag) {
      throw MapRemoteTileSnapshotMismatchException(
        expectedEtag: expectedEtag,
        receivedEtag: receivedEtag,
        statusCode: statusCode,
      );
    }

    final expectedEnd = requestedOffset + requestedLength - 1;
    final expectedRange =
        'bytes $requestedOffset-$expectedEnd/$expectedTotalSize';
    final receivedRange = headers.singleValueOf('content-range');
    final match = receivedRange == null
        ? null
        : _contentRange.firstMatch(receivedRange);
    final matchesRange =
        match != null &&
        int.tryParse(match.group(1) ?? '') == requestedOffset &&
        int.tryParse(match.group(2) ?? '') == expectedEnd &&
        int.tryParse(match.group(3) ?? '') == expectedTotalSize;
    if (!matchesRange) {
      throw MapRemoteTileContentRangeMismatchException(
        expected: expectedRange,
        received: receivedRange,
      );
    }

    if (bodyLength != requestedLength) {
      throw MapRemoteTileBodyLengthMismatchException(
        expectedLength: requestedLength,
        actualLength: bodyLength,
      );
    }

    return receivedEtag;
  }
}
