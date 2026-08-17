import 'package:flutter/foundation.dart';

/// remote PMTiles Range 取得の契約違反を表す typed exception。
///
/// Global Constraints「破損・上限超過・schema 不整合 = typed exception。空 tile
/// へ丸めない」に従い、契約に反する応答は必ず本 sealed 例外のいずれかとして
/// 送出する(空 tile / 部分的な結果へフォールバックしない)。
@immutable
sealed class MapRemoteTileException implements Exception {
  const new();

  String get message;
}

/// `identity` 以外の `Content-Encoding`(gzip / br / deflate / zstd など、
/// または transform を含む複数値)を受信した場合。
///
/// random-access Range reader は encoding 変換された body を安全に
/// 切り出せないため、identity 以外は fail closed とする。
final class MapRemoteTileNonIdentityEncodingException
    extends MapRemoteTileException {
  const new({
    required this.contentEncoding,
  });

  /// 拒否した `Content-Encoding` の生値(複数値ならすべて)。
  final List<String> contentEncoding;

  @override
  String get message =>
      'Non-identity Content-Encoding is rejected: $contentEncoding';

  @override
  String toString() => 'MapRemoteTileNonIdentityEncodingException: $message';
}

/// Range 要求に対して 206 でも 412 でもない status を受信した場合
/// (200 で全体を返された等)。random-access reader は 206 以外を成功として
/// 扱わない。
final class MapRemoteTileUnexpectedStatusException
    extends MapRemoteTileException {
  const new({required this.statusCode});

  final int statusCode;

  @override
  String get message =>
      'Expected HTTP 206 Partial Content but received $statusCode.';

  @override
  String toString() => 'MapRemoteTileUnexpectedStatusException: $message';
}

/// archive が `If-Match` で守られた snapshot から差し替わった場合(412、または
/// strong ETag が期待値と一致しない)。受信済み byte はすべて破棄する。
final class MapRemoteTileSnapshotMismatchException
    extends MapRemoteTileException {
  const new({
    required this.expectedEtag,
    required this.receivedEtag,
    required this.statusCode,
  });

  final String? expectedEtag;
  final String? receivedEtag;
  final int statusCode;

  @override
  String get message =>
      'Remote archive snapshot changed '
      '(status=$statusCode, expected=$expectedEtag, received=$receivedEtag). '
      'All received bytes are discarded.';

  @override
  String toString() => 'MapRemoteTileSnapshotMismatchException: $message';
}

/// strong validator(強い ETag)が欠損・複数・weak(`W/` prefix)だった場合。
/// Range の再取得整合性を保証できないため fail closed する。
final class MapRemoteTileWeakValidatorException extends MapRemoteTileException {
  const new({required this.receivedEtag});

  /// 受信した ETag(欠損時は`null`、複数時は結合表現)。
  final String? receivedEtag;

  @override
  String get message =>
      'A single strong ETag is required but received: $receivedEtag';

  @override
  String toString() => 'MapRemoteTileWeakValidatorException: $message';
}

/// `Content-Range` が要求した `bytes offset-end/total` と厳密一致しない場合
/// (total が期待 archive size と異なる場合を含む)。
final class MapRemoteTileContentRangeMismatchException
    extends MapRemoteTileException {
  const new({
    required this.expected,
    required this.received,
  });

  final String expected;
  final String? received;

  @override
  String get message =>
      'Content-Range must equal "$expected" but received "$received".';

  @override
  String toString() => 'MapRemoteTileContentRangeMismatchException: $message';
}

/// 応答 body の長さが要求した Range 長と一致しない場合。受信済み byte は
/// 破棄する。
final class MapRemoteTileBodyLengthMismatchException
    extends MapRemoteTileException {
  const new({
    required this.expectedLength,
    required this.actualLength,
  });

  final int expectedLength;
  final int actualLength;

  @override
  String get message =>
      'Expected $expectedLength body bytes but received $actualLength.';

  @override
  String toString() => 'MapRemoteTileBodyLengthMismatchException: $message';
}

/// Range 要求に対してサーバが redirect(3xx)を返した場合。
///
/// app が検証したのは初期 URL のみで、redirect 先は検証済み信頼境界の外。
/// reader は redirect を追わず fail closed する。
final class MapRemoteTileRedirectRejectedException
    extends MapRemoteTileException {
  const new({
    required this.statusCode,
    required this.location,
  });

  final int statusCode;
  final String? location;

  @override
  String get message =>
      'Refused to follow a redirect (status=$statusCode, location=$location) '
      'outside the verified URL.';

  @override
  String toString() => 'MapRemoteTileRedirectRejectedException: $message';
}

/// ネットワーク層の失敗(接続不可・切断など)。
final class MapRemoteTileNetworkException extends MapRemoteTileException {
  const new({required this.reason});

  final String reason;

  @override
  String get message => 'Remote PMTiles request failed: $reason';

  @override
  String toString() => 'MapRemoteTileNetworkException: $message';
}

/// close 済みの reader へ read が来た場合。
final class MapRemoteTileClosedException extends MapRemoteTileException {
  const new();

  @override
  String get message => 'The remote PMTiles reader is closed.';

  @override
  String toString() => 'MapRemoteTileClosedException: $message';
}
