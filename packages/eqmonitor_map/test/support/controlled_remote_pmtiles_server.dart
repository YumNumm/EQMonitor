import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

/// remote PMTiles reader を実 HTTP で end-to-end 検証するための loopback サーバ。
///
/// 既定では identity encoding + strong ETag + 206 の正常応答を返し、`Range`
/// 要求どおりの byte 範囲を切り出す。契約違反系のテストのために、返す status /
/// Content-Encoding / redirect / ETag を切り替えられる。
final class ControlledRemotePmTilesServer {
  new _(
    this._server,
    this.archiveBytes,
    this.etag,
  );

  final HttpServer _server;
  final Uint8List archiveBytes;

  /// 現在の strong ETag。テスト中に書き換えると snapshot drift を模せる。
  String etag;

  /// 非 null のとき、206 の代わりにこの status を返す(例: 200 で Range 要求へ
  /// 全体を返すサーバを模す)。
  int? statusOverride;

  /// 非 null のとき、その `Content-Encoding` を付けて返す(例: `gzip`)。実際に
  /// 圧縮はしない — reader が identity 以外を fail closed するかの検証用。
  String? contentEncodingOverride;

  /// 非 null のとき、302 redirect を返す。
  Uri? redirectTo;

  /// 非 null のとき、要求 Range より N byte 多い body を返す(oversized body の
  /// 拒否を検証するため)。
  int? oversizeBodyBy;

  /// 受信した `Range` ヘッダの記録(coalesce / 再取得の検証用)。
  final List<String> rangeRequests = [];

  /// 受信した `If-Match` ヘッダの記録(初回 read 直列化の検証用。欠損は null)。
  final List<String?> ifMatchRequests = [];

  Uri get url => Uri.parse(
    'http://${_server.address.host}:${_server.port}/base.pmtiles',
  );

  static Future<ControlledRemotePmTilesServer> start({
    required Uint8List archiveBytes,
    String etag = '"v1"',
  }) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final controlled = ControlledRemotePmTilesServer._(
      server,
      archiveBytes,
      etag,
    );
    unawaited(controlled._serve());
    return controlled;
  }

  Future<void> _serve() async {
    await for (final request in _server) {
      await _handle(request);
    }
  }

  Future<void> _handle(HttpRequest request) async {
    final response = request.response;
    final redirectTo = this.redirectTo;
    if (redirectTo != null) {
      response
        ..statusCode = HttpStatus.found
        ..headers.set(HttpHeaders.locationHeader, redirectTo.toString());
      await response.close();
      return;
    }

    final rangeHeader = request.headers.value(HttpHeaders.rangeHeader) ?? '';
    rangeRequests.add(rangeHeader);

    final ifMatch = request.headers.value(HttpHeaders.ifMatchHeader);
    ifMatchRequests.add(ifMatch);
    if (ifMatch != null && ifMatch != etag) {
      response
        ..statusCode = HttpStatus.preconditionFailed
        ..headers.set(HttpHeaders.etagHeader, etag);
      await response.close();
      return;
    }

    final match = RegExp(r'^bytes=(\d+)-(\d+)$').firstMatch(rangeHeader);
    if (match == null) {
      response.statusCode = HttpStatus.badRequest;
      await response.close();
      return;
    }
    final start = int.parse(match.group(1)!);
    final end = int.parse(match.group(2)!);
    final slice = <int>[
      ...archiveBytes.sublist(start, end + 1),
      ...List.filled(oversizeBodyBy ?? 0, 0),
    ];

    response
      ..statusCode = statusOverride ?? HttpStatus.partialContent
      ..headers.set(HttpHeaders.etagHeader, etag)
      ..headers.set(
        'content-range',
        'bytes $start-$end/${archiveBytes.length}',
      );
    final contentEncodingOverride = this.contentEncodingOverride;
    if (contentEncodingOverride != null) {
      response.headers.set(
        HttpHeaders.contentEncodingHeader,
        contentEncodingOverride,
      );
    }
    response.add(slice);
    await response.close();
  }

  Future<void> stop() => _server.close(force: true);
}
