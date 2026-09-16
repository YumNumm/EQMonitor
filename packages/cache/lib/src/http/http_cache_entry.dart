import 'dart:typed_data';

class const HttpCacheEntry({
  required final String key,
  required final int statusCode,
  required final String? eTag,
  required final Map<String, List<String>> headers,
  required final String responseType,
  required final Uint8List body,
  required final int updatedAtMs,
});
