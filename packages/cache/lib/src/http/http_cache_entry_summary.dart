class HttpCacheEntrySummary {
  const HttpCacheEntrySummary({
    required this.key,
    required this.statusCode,
    required this.eTag,
    required this.headers,
    required this.responseType,
    required this.updatedAtMs,
    required this.bodySizeBytes,
  });

  final String key;
  final int statusCode;
  final String? eTag;
  final Map<String, List<String>> headers;
  final String responseType;
  final int updatedAtMs;
  final int bodySizeBytes;
}
