import 'package:eqmonitor/feature/notification/data/model/test_live_activity_status.dart';
import 'package:eqmonitor/feature/notification/data/notifier/test_live_activity_notifier.dart';
import 'package:eqmonitor/feature/notification/data/repository/test_live_activity_repository.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

class _FakeRepository implements TestLiveActivityRepository {
  bool active = false;
  int endCount = 0;

  @override
  Future<TestLiveActivityStatus> status() async =>
      TestLiveActivityStatus(isSupported: true, isActive: active);

  @override
  Future<void> show(DebugEewPreset preset) async => active = true;

  @override
  Future<void> end() async {
    active = false;
    endCount++;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late _FakeRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _FakeRepository();
    container = ProviderContainer(
      overrides: [
        testLiveActivityRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
  });

  test('表示すると1分後の終了時刻を持つ', () async {
    await container.read(testLiveActivityProvider.future);
    final before = DateTime.now();
    await container
        .read(testLiveActivityProvider.notifier)
        .show(DebugEewPreset.warning);

    final status = await container.read(testLiveActivityProvider.future);
    expect(status.isActive, true);
    final remaining = status.endsAt!.difference(before);
    expect(remaining.inSeconds, inInclusiveRange(59, 61));
    expect(repository.endCount, 0);
  });

  test('終了時刻を過ぎていれば終了する', () async {
    repository.active = true;
    container
        .read(testLiveActivityDeadlineProvider.notifier)
        .set(DateTime.now().subtract(const Duration(seconds: 1)));

    final status = await container.read(testLiveActivityProvider.future);
    expect(status.isActive, false);
    expect(status.endsAt, isNull);
    expect(repository.endCount, 1);
  });

  test('終了時刻が分からない表示は終了する', () async {
    repository.active = true;

    final status = await container.read(testLiveActivityProvider.future);
    expect(status.isActive, false);
    expect(repository.endCount, 1);
  });

  for (final listened in [true, false]) {
    test('終了時刻になると自動で終了する（購読${listened ? 'あり' : 'なし'}）', () async {
      repository.active = true;
      container
          .read(testLiveActivityDeadlineProvider.notifier)
          .set(DateTime.now().add(const Duration(milliseconds: 50)));
      if (listened) {
        container.listen(testLiveActivityProvider, (_, _) {});
      }
      final status = await container.read(testLiveActivityProvider.future);
      expect(status.isActive, true);
      expect(repository.endCount, 0);

      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(repository.endCount, 1);
      final after = await container.read(testLiveActivityProvider.future);
      expect(after.isActive, false);
      expect(container.read(testLiveActivityDeadlineProvider), isNull);
    });
  }

  test('手動で終了すると終了時刻を消す', () async {
    await container
        .read(testLiveActivityProvider.notifier)
        .show(DebugEewPreset.forecast);
    await container.read(testLiveActivityProvider.notifier).end();

    final status = await container.read(testLiveActivityProvider.future);
    expect(status.isActive, false);
    expect(status.endsAt, isNull);
    expect(container.read(testLiveActivityDeadlineProvider), isNull);
  });
}
