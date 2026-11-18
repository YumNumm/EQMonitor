import 'dart:async';

import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class _StubSubscriptionNotifier(final SubscriptionStatus _status)
    extends SubscriptionNotifier {
  var refreshing = false;

  @override
  Future<SubscriptionStatus> build() async =>
      refreshing ? Completer<SubscriptionStatus>().future : _status;
}

ProviderContainer _container({
  required SubscriptionStatus status,
}) => ProviderContainer(
  overrides: [
    subscriptionProvider.overrideWith(() => _StubSubscriptionNotifier(status)),
  ],
);

void main() {
  group('isProProvider', () {
    test('active なら true', () async {
      final container = _container(
        status: const SubscriptionStatus.active(productId: 'pro_monthly'),
      );
      addTearDown(container.dispose);

      await container.read(subscriptionProvider.future);
      expect(container.read(isProProvider), isTrue);
    });

    test('expired confirmation cannot keep Pro while offline', () async {
      final container = _container(
        status: SubscriptionStatus.active(
          productId: 'pro',
          expiresAt: DateTime.utc(2000),
          syncPhase: SubscriptionSyncPhase.failed,
        ),
      );
      addTearDown(container.dispose);
      await container.read(subscriptionProvider.future);
      expect(container.read(isProProvider), isFalse);
    });

    test('refresh never leaks a previous device entitlement', () async {
      final container = _container(
        status: const SubscriptionStatus.active(productId: 'pro'),
      );
      addTearDown(container.dispose);
      await container.read(subscriptionProvider.future);
      (container.read(
        subscriptionProvider.notifier,
      ) as _StubSubscriptionNotifier).refreshing = true;
      container.invalidate(subscriptionProvider);
      expect(container.read(isProProvider), isFalse);
    });

    test('inactive なら false', () async {
      final container = _container(
        status: const SubscriptionStatus.inactive(),
      );
      addTearDown(container.dispose);

      await container.read(subscriptionProvider.future);
      expect(container.read(isProProvider), isFalse);
    });
  });

  group('confirmedIsProProvider', () {
    test('読み込み中は未確定 (null) を返し、確定後に値を返す', () async {
      final container = _container(
        status: const SubscriptionStatus.active(productId: 'pro'),
      );
      addTearDown(container.dispose);

      expect(container.read(confirmedIsProProvider), isNull);

      await container.read(subscriptionProvider.future);
      expect(container.read(confirmedIsProProvider), isTrue);
    });

    test('Pro でないと確定したら false を返す', () async {
      final container = _container(
        status: const SubscriptionStatus.inactive(),
      );
      addTearDown(container.dispose);

      await container.read(subscriptionProvider.future);
      expect(container.read(confirmedIsProProvider), isFalse);
    });

    test('確定後の再読み込み中は、前回の値を false にせず未確定とする', () async {
      final container = _container(
        status: const SubscriptionStatus.active(productId: 'pro'),
      );
      addTearDown(container.dispose);
      await container.read(subscriptionProvider.future);
      expect(container.read(confirmedIsProProvider), isTrue);

      (container.read(
        subscriptionProvider.notifier,
      ) as _StubSubscriptionNotifier).refreshing = true;
      container.invalidate(subscriptionProvider);

      expect(container.read(confirmedIsProProvider), isNull);
      expect(container.read(isProProvider), isFalse);
    });

    test('取得に失敗したら未確定とする', () async {
      final container = ProviderContainer(
        retry: (_, _) => null,
        overrides: [
          subscriptionProvider.overrideWith(_FailingSubscriptionNotifier.new),
        ],
      );
      addTearDown(container.dispose);

      await expectLater(
        container.read(subscriptionProvider.future),
        throwsStateError,
      );
      expect(container.read(confirmedIsProProvider), isNull);
      expect(container.read(isProProvider), isFalse);
    });
  });
}

class _FailingSubscriptionNotifier extends SubscriptionNotifier {
  @override
  Future<SubscriptionStatus> build() async => throw StateError('offline');
}
