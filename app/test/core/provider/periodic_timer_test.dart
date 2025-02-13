import 'package:eqmonitor/core/provider/periodic_timer.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('PeriodicTimer', () {
    test('setInterval - 正常なインターバル設定', () {
      fakeAsync((async) {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final key = UniqueKey();
        final events = <void>[];
        container.listen(periodicTimerProvider(key), (previous, next) {
          if (next is AsyncData) {
            events.add(null);
          }
        });

        // Providerの初期化を待つ
        async.flushMicrotasks();

        // インターバルの設定
        final notifier = container.read(periodicTimerProvider(key).notifier);
        notifier.setInterval(const Duration(milliseconds: 100));

        // 時間を進める
        async.elapse(const Duration(milliseconds: 150));

        // イベントが発火することを確認
        expect(events, isNotEmpty);
      });
    });

    test(
      'setInterval - インターバルの変更',
      () => fakeAsync((async) {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final key = UniqueKey();
        final events = <void>[];
        container.listen(periodicTimerProvider(key), (previous, next) {
          if (next is AsyncData) {
            events.add(null);
          }
        });

        async.flushMicrotasks();

        final notifier = container.read(periodicTimerProvider(key).notifier);

        // 最初のインターバル設定
        notifier.setInterval(const Duration(seconds: 5));

        // インターバルを変更
        notifier.setInterval(const Duration(seconds: 3));

        expect(events, isEmpty);
        // NOTE: 3秒後にイベントが発火することを確認
        async.elapse(const Duration(seconds: 3));

        // イベントが発火することを確認
        expect(events, isNotEmpty);
      }),
    );

    test(
      'setInterval - インターバルの変更 途中でインターバルが短くなる',
      () => fakeAsync((async) {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final key = UniqueKey();
        final events = <void>[];
        container.listen(periodicTimerProvider(key), (previous, next) {
          if (next is AsyncData) {
            events.add(null);
          }
        });

        async.flushMicrotasks();

        final notifier = container.read(periodicTimerProvider(key).notifier);

        // 最初のインターバル設定
        notifier.setInterval(const Duration(seconds: 5));
        // 2秒進める
        async.elapse(const Duration(seconds: 2));

        // インターバルを変更
        notifier.setInterval(const Duration(seconds: 3));

        expect(events, isEmpty);
        // NOTE: 1秒後にイベントが発火することを確認
        async.elapse(const Duration(seconds: 1));

        // イベントが発火することを確認
        expect(events, isNotEmpty);
      }),
    );

    test(
      'setInterval - インターバルの変更 途中でインターバルが短くなる (既に経過)',
      () => fakeAsync((async) {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final key = UniqueKey();
        final events = <void>[];
        container.listen(periodicTimerProvider(key), (previous, next) {
          if (next is AsyncData) {
            events.add(null);
          }
        });

        async.flushMicrotasks();

        final notifier = container.read(periodicTimerProvider(key).notifier);

        // 最初のインターバル設定
        notifier.setInterval(const Duration(seconds: 5));
        // 3秒進める
        async.elapse(const Duration(seconds: 3));

        // インターバルを変更
        notifier.setInterval(const Duration(seconds: 2));
        async.flushMicrotasks();

        expect(events, isNotEmpty);
      }),
    );

    test(
      'setIntervalWithoutCurrentTimer - 直近のタイマーを考慮せずにインターバルを設定',
      () => fakeAsync((async) {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        final key = UniqueKey();
        final events = <void>[];
        container.listen(periodicTimerProvider(key), (previous, next) {
          if (next is AsyncData) {
            events.add(null);
          }
        });

        async.flushMicrotasks();

        final notifier = container.read(periodicTimerProvider(key).notifier);

        // 最初のインターバル設定 (5秒)
        notifier.setInterval(const Duration(seconds: 5));
        // 4秒進める
        async.elapse(const Duration(seconds: 4));

        // setIntervalWithoutCurrentTimerで新しいインターバル (2秒) を設定
        // 直近のタイマーは考慮されないため、1秒後に発火せず2秒後に発火する
        notifier.setIntervalWithoutCurrentTimer(const Duration(seconds: 2));

        // イベントがまだ発火していないことを確認
        expect(events, hasLength(0));

        // 2秒進める
        async.elapse(const Duration(seconds: 2));

        // イベントが発火することを確認
        expect(events, hasLength(1));

        // さらに2秒進める
        async.elapse(const Duration(seconds: 2));

        // 2回目のイベントが発火することを確認
        expect(events, hasLength(2));
      }),
    );
  });
}
