import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/eew_history/data/notifier/eew_history_notice_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../test_utils/configurable_shared_preferences.dart';

Future<ProviderContainer> createContainer({
  Map<String, Object> initial = const {},
}) async {
  SharedPreferences.setMockInitialValues(initial);
  final preferences = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(AsyncData(preferences)),
    ],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('確認済みフラグが未保存なら false を返す', () async {
    final container = await createContainer();
    addTearDown(container.dispose);

    expect(await container.read(eewHistoryNoticeShownProvider.future), isFalse);
  });

  test('確認済みフラグが保存済みなら true を返す', () async {
    final container = await createContainer(
      initial: {SharedPreferencesKey.eewHistoryNoticeShown.key: true},
    );
    addTearDown(container.dispose);

    expect(await container.read(eewHistoryNoticeShownProvider.future), isTrue);
  });

  test('markShown は確認済み状態を保存する', () async {
    final container = await createContainer();
    addTearDown(container.dispose);

    await container.read(eewHistoryNoticeShownProvider.future);
    await container.read(eewHistoryNoticeShownProvider.notifier).markShown();

    expect(container.read(eewHistoryNoticeShownProvider).value, isTrue);
    final preferences = await container.read(sharedPreferencesProvider.future);
    expect(
      preferences.getBool(SharedPreferencesKey.eewHistoryNoticeShown.key),
      isTrue,
    );
  });

  test('保存時に例外が発生した場合は未確認状態を維持する', () async {
    final preferences = ConfigurableSharedPreferences(
      boolValue: false,
      setBoolError: Exception('write failed'),
    );
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(AsyncData(preferences)),
      ],
    );
    addTearDown(container.dispose);

    await container.read(eewHistoryNoticeShownProvider.future);

    await expectLater(
      container.read(eewHistoryNoticeShownProvider.notifier).markShown(),
      throwsException,
    );
    expect(container.read(eewHistoryNoticeShownProvider).value, isFalse);
  });
}
