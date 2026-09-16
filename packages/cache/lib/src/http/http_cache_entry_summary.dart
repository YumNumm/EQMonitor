class const HttpCacheEntrySummary({
  required final String key,
  required final int statusCode,
  required final String? eTag,
  required final Map<String, List<String>> headers,
  required final String responseType,
  required final int updatedAtMs,
  required final int bodySizeBytes,
});
