import 'dart:convert';

final class UserJwtExpiryParser {
  const new();

  static final _segmentPattern = RegExp(r'^[A-Za-z0-9_-]+$');

  DateTime? parse(String token) {
    final segments = token.split('.');
    if (segments.length != 3 ||
        segments.any(
          (segment) => segment.isEmpty || !_segmentPattern.hasMatch(segment),
        )) {
      return null;
    }
    try {
      final header = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(segments[0]))),
      );
      if (header is! Map<String, dynamic>) {
        return null;
      }
      final payload = switch (jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(segments[1]))),
      )) {
        final Map<String, dynamic> value => value,
        _ => null,
      };
      if (payload == null) {
        return null;
      }
      final signature = base64Url.decode(base64Url.normalize(segments[2]));
      final expirationSeconds = payload['exp'];
      if (signature.isEmpty ||
          expirationSeconds is! num ||
          !expirationSeconds.isFinite) {
        return null;
      }
      final milliseconds = expirationSeconds * Duration.millisecondsPerSecond;
      if (!milliseconds.isFinite ||
          milliseconds < -8640000000000000 ||
          milliseconds > 8640000000000000) {
        return null;
      }
      return DateTime.fromMillisecondsSinceEpoch(
        milliseconds.round(),
        isUtc: true,
      );
    } on FormatException {
      return null;
    } on RangeError {
      return null;
    }
  }
}
