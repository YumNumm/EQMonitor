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
///
/// **保証しないこと**: 受信 byte を[VerifiedRemotePmTilesSource.sha256]と
/// 照合しない。全体 digest は全 `sizeBytes` を読まないと計算できず、部分取得と
/// 両立しないため。保証は「pin した ETag が同一の間、各 range が同一 snapshot に
/// 属すること」までで、その snapshot が attest された archive そのものである
/// ことは保証しない(ETag 据え置きの差し替えは検出できない)。全体束縛には
/// per-chunk attestation が要る。
/// `docs/todo/815_eqmonitor_map_remote_digest_binding.md`
final class MapRemotePmTilesRandomAccessReader
    implements PmTilesRandomAccessReader {
  new({
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

  /// 一度 strong ETag を pin した後に random-access 契約が壊れたら、その失敗を
  /// terminal にして以後の read をすべて失敗させる(古い cache を返さない)。
  /// snapshot 差し替え(412 / ETag drift)だけでなく、pin 後の If-Match 応答で
  /// weak/欠損 ETag・Content-Range 不一致・body 長不一致が起きた場合も、その
  /// archive をもう一貫して読めないため terminal 化する。
  MapRemoteTileException? _terminalFailure;

  /// strong ETag をまだ pin していない間に走る「最初の read」。並行して複数の
  /// 初回 read を `If-Match` なしで投げると、その間に origin が差し替わった際に
  /// 双方が `expectedEtag == null` で通り、別 archive の byte を混ぜて pin を
  /// 上書きし得る。よって初回 read は 1 本だけ走らせ、他は完了を待ってから
  /// retry する(その頃には etag が pin 済み、または terminal になっている)。
  Future<Uint8List>? _initialRead;

  @override
  int get sizeBytes => source.sizeBytes;

  @override
  Future<Uint8List> readAt({required int offset, required int length}) {
    if (_closed) {
      return Future.error(const MapRemoteTileClosedException());
    }
    final terminalFailure = _terminalFailure;
    if (terminalFailure != null) {
      return Future.error(terminalFailure);
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

    // 初回 read を直列化する: etag 未 pin かつ既に初回 read が走っているなら、
    // それを待ってから retry する(重複した If-Match なし request を出さない)。
    final initialRead = _initialRead;
    if (etag == null && initialRead != null) {
      return initialRead.then(
        (_) => readAt(offset: offset, length: length),
        onError: (Object _) => readAt(offset: offset, length: length),
      );
    }

    final key = (etag, offset, length);
    final existing = _inFlight[key];
    if (existing != null) {
      return existing;
    }
    final request = _fetch(offset: offset, length: length, etag: etag);
    _inFlight[key] = request;
    if (etag == null) {
      _initialRead = request;
    }
    // `.ignore()` は cleanup チェーン側のエラーを握り潰す(呼び出し側は返り値の
    // `request` を await して同じエラーを受け取る)。`unawaited` だと未処理
    // async エラーとして再送出されてしまうため使わない。
    request.whenComplete(() {
      if (identical(_inFlight[key], request)) {
        _inFlight.remove(key)?.ignore();
      }
      if (identical(_initialRead, request)) {
        _initialRead = null;
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

    // status を Content-Encoding / body 収集より先に分類する。412(snapshot 差し替え)
    // が gzip の error page で返ってきた場合でも、identity validator より先に
    // terminal 化しないと「snapshot drift 後も古い cache が読める」状態になる。
    // 206 以外の body は読まずに drain する(巨大 error body の防止にもなる)。
    if (response.statusCode == 412) {
      await response.drain<void>();
      final error = MapRemoteTileSnapshotMismatchException(
        expectedEtag: etag,
        receivedEtag: headers.singleValueOf('etag'),
        statusCode: response.statusCode,
      );
      _terminalFailure = error;
      _cache.clear();
      throw error;
    }
    if (response.statusCode != 206) {
      await response.drain<void>();
      throw MapRemoteTileUnexpectedStatusException(
        statusCode: response.statusCode,
      );
    }

    _identityValidator.validate(headers: headers);
    final bytes = await _collect(response, maxBytes: length);

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
    } on MapRemoteTileException catch (error) {
      // 一度 pin した後(expectedEtag != null)に range 契約が壊れた場合、および
      // snapshot 差し替え(ETag drift)は、その archive をもう一貫して読めない
      // ため terminal 化して cache を捨てる。pin 前(初回 read)の契約失敗は
      // retry 余地を残して terminal にしない。
      if (etag != null || error is MapRemoteTileSnapshotMismatchException) {
        _terminalFailure = error;
        _cache.clear();
      }
      rethrow;
    }

    // ここへ来るまでに、並行して走った別の post-pin request が 412/drift を
    // 検出して terminal 化・cache clear している可能性がある。その後に本 request
    // が「成功」しても、古い ETag を pin し直して bytes を cache へ書き戻し
    // 返してしまうと、terminal 宣言後に poison 後の byte が漏れる。書き込み・
    // 返却の直前に terminal / closed を再確認する。
    final terminalFailure = _terminalFailure;
    if (terminalFailure != null) {
      throw terminalFailure;
    }
    if (_closed) {
      throw const MapRemoteTileClosedException();
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

  /// 応答 body を集めるが、要求 Range 長を超えた分は読まない。hostile/bug の
  /// サーバが要求より大きい body を返しても、`readAt` 1 回で無制限に memory を
  /// 確保しないための上限。`maxBytes` を超えたら読み取りを止め、超過した長さの
  /// まま返す(呼び出し側の Content-Range / body 長 validator が
  /// [MapRemoteTileBodyLengthMismatchException] で弾く)。
  Future<Uint8List> _collect(
    HttpClientResponse response, {
    required int maxBytes,
  }) async {
    final builder = BytesBuilder(copy: false);
    final subscription = StreamIterator(response);
    try {
      while (await subscription.moveNext()) {
        builder.add(subscription.current);
        if (builder.length > maxBytes) {
          break;
        }
      }
    } finally {
      await subscription.cancel();
    }
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
  new({required this.maxBytes});

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
