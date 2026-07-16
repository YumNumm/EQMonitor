import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/feed/data/provider/feed_last_read_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

ProviderContainer _container(Map<String, Object> initialPrefs) {
  SharedPreferences.setMockInitialValues(initialPrefs);
  return ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWith(
        (ref) => SharedPreferences.getInstance(),
      ),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('未設定の場合は null を返す', () async {
    final container = _container({});
    addTearDown(container.dispose);

    final value = await container.read(feedLastReadProvider.future);
    expect(value, isNull);
  });

  test('保存済みの既読位置を読み込む', () async {
    final saved = DateTime(2026, 7, 1, 12);
    final container = _container({
      SharedPreferencesKey.feedLastReadPublishedAt.key:
          saved.millisecondsSinceEpoch,
    });
    addTearDown(container.dispose);

    final value = await container.read(feedLastReadProvider.future);
    expect(value, saved);
  });

  test('markRead は既読位置を進めて永続化する', () async {
    final container = _container({});
    addTearDown(container.dispose);

    final target = DateTime(2026, 7, 2, 9);
    await container.read(feedLastReadProvider.notifier).markRead(target);

    expect(await container.read(feedLastReadProvider.future), target);
    final prefs = await SharedPreferences.getInstance();
    expect(
      prefs.getInt(SharedPreferencesKey.feedLastReadPublishedAt.key),
      target.millisecondsSinceEpoch,
    );
  });

  test('markRead は過去方向には戻さない', () async {
    final newer = DateTime(2026, 7, 3);
    final container = _container({
      SharedPreferencesKey.feedLastReadPublishedAt.key:
          newer.millisecondsSinceEpoch,
    });
    addTearDown(container.dispose);

    await container
        .read(feedLastReadProvider.notifier)
        .markRead(DateTime(2026, 7, 1));

    expect(await container.read(feedLastReadProvider.future), newer);
  });

  test('initializeIfUnset は未設定時のみ保存する', () async {
    final container = _container({});
    addTearDown(container.dispose);

    final first = DateTime(2026, 7, 1);
    await container
        .read(feedLastReadProvider.notifier)
        .initializeIfUnset(first);
    expect(await container.read(feedLastReadProvider.future), first);

    await container
        .read(feedLastReadProvider.notifier)
        .initializeIfUnset(DateTime(2026, 7, 5));
    expect(await container.read(feedLastReadProvider.future), first);
  });
}
