const kHttpCacheSchemaVersion = 1;

String buildHttpCacheKey({
  required int schemaVersion,
  required String appBuild,
  required Uri url,
  Map<String, String>? headers,
  Object? body,
}) => 'v$schemaVersion:$appBuild:$url';
