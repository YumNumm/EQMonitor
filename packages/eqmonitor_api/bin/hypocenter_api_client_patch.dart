import 'dart:io';

String patchHypocenterSearchCancelToken(String source) {
  if (source.contains('@CancelRequest() CancelToken? cancelToken,')) {
    return source;
  }
  final anchor = RegExp(
    r"([ \t]*)@Query\('expected_revision'\) String\? expectedRevision,\n"
    r"\1@Header\('If-None-Match'\) String\? ifNoneMatch,",
  );
  if (!anchor.hasMatch(source)) {
    throw const FormatException(
      'Hypocenter search expected_revision anchor is missing',
    );
  }
  return source.replaceFirstMapped(
    anchor,
    (match) {
      final indent = match.group(1) ?? '';
      return "${indent}@Query('expected_revision') String? expectedRevision,\n"
          '$indent@CancelRequest() CancelToken? cancelToken,\n'
          "$indent@Header('If-None-Match') String? ifNoneMatch,";
    },
  );
}

void patchHypocenterApiClientCancelToken({required Directory libDir}) {
  final file = File('${libDir.path}/clients/hypocenters_api_client.dart');
  file.writeAsStringSync(patchHypocenterSearchCancelToken(file.readAsStringSync()));
}
