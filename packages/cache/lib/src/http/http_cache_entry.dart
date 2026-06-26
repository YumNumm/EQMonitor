import 'dart:typed_data';

class HttpCacheEntry {
  const HttpCacheEntry({
    required this.key,
    required this.statusCode,
    required this.eTag,
    required this.headers,
    required this.responseType,
    required this.body,
    required this.updatedAtMs,
  });

  final String key;
  final int statusCode;
  final String? eTag;
  final Map<String, List<String>> headers;
  final String responseType;
  final Uint8List body;
  final int updatedAtMs;
}
