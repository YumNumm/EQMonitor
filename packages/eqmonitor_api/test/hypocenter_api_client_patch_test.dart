import 'package:test/test.dart';

import '../bin/hypocenter_api_client_patch.dart';

void main() {
  test('震源検索だけにCancelTokenを追加する', () {
    const source = '''
Future<void> getV2HypocentersManifest({
  String? ifNoneMatch,
});
Future<void> getV2Hypocenters({
  @Query('expected_revision') String? expectedRevision,
  @Header('If-None-Match') String? ifNoneMatch,
});
''';

    final patched = patchHypocenterSearchCancelToken(source);

    expect(patched, contains('@CancelRequest() CancelToken? cancelToken,'));
    expect(
      '@CancelRequest()'.allMatches(patched),
      hasLength(1),
    );
  });

  test('二重にCancelTokenを追加しない', () {
    const source = '''
Future<void> getV2Hypocenters({
  @Query('expected_revision') String? expectedRevision,
  @CancelRequest() CancelToken? cancelToken,
  @Header('If-None-Match') String? ifNoneMatch,
});
''';

    final patched = patchHypocenterSearchCancelToken(source);

    expect('@CancelRequest()'.allMatches(patched), hasLength(1));
  });
}
