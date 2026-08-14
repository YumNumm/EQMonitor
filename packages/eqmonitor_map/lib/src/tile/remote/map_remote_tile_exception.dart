import 'package:flutter/foundation.dart';

/// remote PMTiles Range 取得の契約違反を表す typed exception。
///
/// Global Constraints「破損・上限超過・schema 不整合 = typed exception。空 tile
/// へ丸めない」に従い、契約に反する応答は必ず本 sealed 例外のいずれかとして
/// 送出する(空 tile / 部分的な結果へフォールバックしない)。
@immutable
sealed class MapRemoteTileException implements Exception {
  const MapRemoteTileException();

  String get message;
}

/// `identity` 以外の `Content-Encoding`(gzip / br / deflate / zstd など、
/// または transform を含む複数値)を受信した場合。
///
/// random-access Range reader は encoding 変換された body を安全に
/// 切り出せないため、identity 以外は fail closed とする。
final class MapRemoteTileNonIdentityEncodingException
    extends MapRemoteTileException {
  const MapRemoteTileNonIdentityEncodingException({
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
