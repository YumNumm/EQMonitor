import 'dart:async';

import 'package:eqmonitor/core/provider/periodic_timer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('PeriodicTimer', () {
    test('setInterval - 正常なインターバル設定', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      const key = 'test_periodic_timer';
      final events = <int>[];

      // Providerを明示的に購読してアクティブにする
      final provider = periodicTimerProvider(key);

      // リスナーを設定
      final sub = container.listen(
        provider,
        (previous, next) {
          print('[TEST] State changed: previous=$previous, next=$next');
          if (next is AsyncData) {
            events.add(events.length);
            print('[TEST] Event added: ${events.length}');
          }
        },
        fireImmediately: true,
      );

      // Providerを読み込んで初期化
      final state = container.read(provider);
      print('[TEST] Initial state: $state');

      // インターバルの設定
      final notifier = container.read(provider.notifier);
      print('[TEST] Setting interval');
      notifier.setInterval(const Duration(milliseconds: 100));

      // タイマーがトリガーされるのを待つ
      print('[TEST] Waiting for timer...');
      await Future<void>.delayed(const Duration(milliseconds: 200));

      print('[TEST] Final event count: ${events.length}');
      // イベントが発火することを確認
      expect(events, isNotEmpty);

      sub.close();
    });

    test(
      'setInterval - 複数回のイベント発火',
      () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        const key = 'test_periodic_timer';
        final events = <int>[];

        final provider = periodicTimerProvider(key);
        container.read(provider);

        final sub = container.listen(
          provider,
          (previous, next) {
            if (next is AsyncData) {
              events.add(events.length);
            }
          },
        );

        final notifier = container.read(provider.notifier);

        // 100ミリ秒ごとのインターバル設定
        notifier.setInterval(const Duration(milliseconds: 100));

        // 350ミリ秒待機 (3回以上のイベントを期待)
        await Future<void>.delayed(const Duration(milliseconds: 350));

        // 複数回イベントが発火することを確認
        expect(events.length, greaterThanOrEqualTo(3));

        sub.close();
      },
    );

    test(
      'setIntervalWithoutCurrentTimer - 複数回のイベント発火',
      () async {
        final container = ProviderContainer();
        addTearDown(container.dispose);

        const key = 'test_periodic_timer';
        final events = <int>[];

        final provider = periodicTimerProvider(key);
        container.read(provider);

        final sub = container.listen(
          provider,
          (previous, next) {
            if (next is AsyncData) {
              events.add(events.length);
            }
          },
        );

        final notifier = container.read(provider.notifier);

        // 100ミリ秒ごとのインターバル設定
        notifier.setIntervalWithoutCurrentTimer(const Duration(milliseconds: 100));

        // 350ミリ秒待機
        await Future<void>.delayed(const Duration(milliseconds: 350));

        // 複数回イベントが発火することを確認
        expect(events.length, greaterThanOrEqualTo(3));

        sub.close();
      },
    );
  });
}
