import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:eqmonitor_map/src/tile/remote/map_http_identity_validator.dart';
import 'package:eqmonitor_map/src/tile/remote/map_http_range_validators.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_http_response_headers.dart';
import 'package:eqmonitor_map/src/tile/remote/map_remote_tile_exception.dart';
import 'package:eqmonitor_map/src/tile/verified_pm_tiles_source.dart';
import 'package:pmtiles_v3/pmtiles_v3.dart';

/// [VerifiedRemotePmTilesSource]が指す remote PMTiles archive を、
/// `PmTilesV3Archive` が要求する [PmTilesRandomAccessReader] として読む。
///
/// - `sizeBytes` は **検証済みの** `source.sizeBytes`。サーバが申告する total は
///   信用せず、`Content-Range` の total が検証済み size と一致することだけを
///   [MapHttpRangeResponseValidator] で確認する。
/// - 各 read は `Accept-Encoding: identity` + `Range` で取得し、identity /
///   206 / strong ETag / 厳密 Content-Range / body 長を検証する。最初の成功で
///   strong ETag を pin し、以後は `If-Match` を付けて snapshot 同一性を守る。
/// - redirect は追わない(検証済みは初期 URL のみ)。3xx は fail closed。
/// - 同一 `(etag, offset, length)` の並行 read は 1 リクエストに coalesce し、
///   直近の範囲は `maxCacheBytes` の LRU で再利用する。
/// - snapshot drift(ETag 不一致 / 412)は terminal 失敗にして cache を捨てる。
/// - [close] 後の read は [MapRemoteTileClosedException]。
final class MapRemotePmTilesRandomAccessReader
    implements PmTilesRandomAccessReader {
  MapRemotePmTilesRandomAccessReader({
    required this.source,
    required int maxCacheBytes,
    HttpClient? httpClient,
    this._identityValidator = const MapHttpIdentityValidator(),
    this._rangeValidator = const MapHttpRangeResponseValidator(),
  }) : _cache = _RangeLruCache(maxBytes: maxCacheBytes),
       _ownsClient = httpClient == null,
       _client = (httpClient ?? HttpClient())..autoUncompress = false;

  final VerifiedRemotePmTilesSource source;
  final _RangeLruCache _cache;
  final MapHttpIdentityValidator _identityValidator;
  final MapHttpRangeResponseValidator _rangeValidator;
  final bool _ownsClient;
  final HttpClient _client;

  final _inFlight = <(String?, int, int), Future<Uint8List>>{};

  String? _pinnedEtag;
  var _closed = false;
  MapRemoteTileSnapshotMismatchException? _terminalSnapshot;

  @override
  int get sizeBytes => source.sizeBytes;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) {
    if (_closed) {
      return Future.error(const MapRemoteTileClosedException());
    }
    final terminalSnapshot = _terminalSnapshot;
    if (terminalSnapshot != null) {
      return Future.error(terminalSnapshot);
    }
    if (length <= 0 || offset < 0 || offset > sizeBytes - length) {
      return Future.error(
        ArgumentError.value(
          offset,
          'offset',
          'range must stay within the verified archive size ($sizeBytes)',
        ),
      );
    }

    final etag = _pinnedEtag;
    final cached = etag == null ? null : _cache.read(etag, offset, length);
    if (cached != null) {
      return Future.value(cached);
    }
    final key = (etag, offset, length);
    final existing = _inFlight[key];
    if (existing != null) {
      return existing;
    }
    final request = _fetch(offset: offset, length: length, etag: etag);
    _inFlight[key] = request;
    // `.ignore()` は cleanup チェーン側のエラーを握り潰す(呼び出し側は返り値の
    // `request` を await して同じエラーを受け取る)。`unawaited` だと未処理
    // async エラーとして再送出されてしまうため使わない。
    request.whenComplete(() {
      if (identical(_inFlight[key], request)) {
        _inFlight.remove(key)?.ignore();
      }
    }).ignore();
    return request;
  }

  Future<Uint8List> _fetch({
    required int offset,
    required int length,
    required String? etag,
  }) async {
    final end = offset + length - 1;
    final HttpClientResponse response;
    try {
      final request = await _client.getUrl(source.url);
      request.followRedirects = false;
      request.headers
        ..set(HttpHeaders.rangeHeader, 'bytes=$offset-$end')
        ..set(HttpHeaders.acceptEncodingHeader, 'identity');
      if (etag != null) {
        request.headers.set(HttpHeaders.ifMatchHeader, etag);
      }
      response = await request.close();
    } on Object catch (error) {
      throw MapRemoteTileNetworkException(reason: '$error');
    }

    if (_closed) {
      await response.drain<void>();
      throw const MapRemoteTileClosedException();
    }
    if (response.statusCode >= 300 && response.statusCode < 400) {
      await response.drain<void>();
      throw MapRemoteTileRedirectRejectedException(
        statusCode: response.statusCode,
        location: response.headers.value(HttpHeaders.locationHeader),
      );
    }

    final headers = _headersOf(response);
    _identityValidator.validate(headers: headers);
    final bytes = await _collect(response);

    final String validatedEtag;
    try {
      validatedEtag = _rangeValidator.validate(
        statusCode: response.statusCode,
        headers: headers,
        bodyLength: bytes.length,
        requestedOffset: offset,
        requestedLength: length,
        expectedTotalSize: sizeBytes,
        expectedEtag: etag,
      );
    } on MapRemoteTileSnapshotMismatchException catch (error) {
      _terminalSnapshot = error;
      _cache.clear();
      rethrow;
    }

    _pinnedEtag = validatedEtag;
    _cache.write(validatedEtag, offset, length, bytes);
    return bytes;
  }

  MapRemoteHttpResponseHeaders _headersOf(HttpClientResponse response) {
    final raw = <String, List<String>>{};
    response.headers.forEach((name, values) => raw[name] = values);
    return MapRemoteHttpResponseHeaders(raw);
  }

  Future<Uint8List> _collect(HttpClientResponse response) async {
    final builder = await response.fold<BytesBuilder>(
      BytesBuilder(copy: false),
      (builder, chunk) => builder..add(chunk),
    );
    return builder.toBytes();
  }

  @override
  Future<void> close() async {
    if (_closed) {
      return;
    }
    _closed = true;
    _cache.clear();
    if (_ownsClient) {
      _client.close(force: true);
    }
  }
}

/// `(strongEtag, offset, length)` で引く byte 範囲の LRU。合計 byte が
/// [maxBytes] を超えないよう最古から捨てる。
final class _RangeLruCache {
  _RangeLruCache({required this.maxBytes});

  final int maxBytes;
  final _entries = <(String, int, int), Uint8List>{};
  var _aggregateBytes = 0;

  Uint8List? read(String etag, int offset, int length) {
    final key = (etag, offset, length);
    final cached = _entries.remove(key);
    if (cached == null) {
      return null;
    }
    _entries[key] = cached;
    return cached;
  }

  void write(String etag, int offset, int length, Uint8List bytes) {
    if (bytes.length > maxBytes) {
      return;
    }
    final key = (etag, offset, length);
    final replaced = _entries.remove(key);
    if (replaced != null) {
      _aggregateBytes -= replaced.length;
    }
    _entries[key] = bytes;
    _aggregateBytes += bytes.length;
    while (_aggregateBytes > maxBytes && _entries.isNotEmpty) {
      final oldest = _entries.keys.first;
      _aggregateBytes -= _entries.remove(oldest)!.length;
    }
  }

  void clear() {
    _entries.clear();
    _aggregateBytes = 0;
  }
}
