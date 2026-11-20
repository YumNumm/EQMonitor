import 'package:eqmonitor/feature/release_highlight/data/notifier/release_highlight_seen_version_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('初期状態は null', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      await container.read(releaseHighlightSeenVersionProvider.future),
      isNull,
    );
  });

  test('markSeen で保存し再構築後も復元できる', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(releaseHighlightSeenVersionProvider.future);

    await container
        .read(releaseHighlightSeenVersionProvider.notifier)
        .markSeen('3.0.0');
    expect(container.read(releaseHighlightSeenVersionProvider).value, '3.0.0');

    final container2 = ProviderContainer();
    addTearDown(container2.dispose);
    expect(
      await container2.read(releaseHighlightSeenVersionProvider.future),
      '3.0.0',
    );
  });
}
