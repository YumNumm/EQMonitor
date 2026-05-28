import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_outcome.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FakeSubscriptionRepository extends SubscriptionRepository {
  FakeSubscriptionRepository({
    required this.initialStatus,
    required this.purchaseOutcome,
    required this.restoreOutcome,
  }) : super(monthlyProductId: 'test-product');

  SubscriptionStatus initialStatus;
  PurchaseOutcome purchaseOutcome;
  PurchaseOutcome restoreOutcome;
  var _fetchCount = 0;

  @override
  Future<SubscriptionStatus> fetchStatus() async {
    _fetchCount += 1;
    return initialStatus;
  }

  @override
  Future<PurchaseOutcome> purchaseMonthly() async => purchaseOutcome;

  @override
  Future<PurchaseOutcome> restorePurchases() async => restoreOutcome;
}

void main() {
  group('SubscriptionNotifier', () {
    test('build returns repository status', () async {
      final repository = FakeSubscriptionRepository(
        initialStatus: const SubscriptionStatus.inactive(),
        purchaseOutcome: const PurchaseOutcome(
          result: PurchaseResult.cancelled(),
        ),
        restoreOutcome: const PurchaseOutcome(
          result: PurchaseResult.cancelled(),
        ),
      );
      final container = ProviderContainer(
        overrides: [
          subscriptionRepositoryProvider.overrideWith(
            (ref) async => repository,
          ),
        ],
      );
      addTearDown(container.dispose);

      final status = await container.read(subscriptionProvider.future);

      expect(status, const SubscriptionStatus.inactive());
      expect(repository._fetchCount, 1);
    });

    test(
      'purchaseMonthly updates state when repository returns status',
      () async {
        final active = SubscriptionStatus.active(
          productId: 'net.yumnumm.eqmonitor.pro.monthly',
          expiresAt: DateTime.utc(2026, 6),
        );
        final repository = FakeSubscriptionRepository(
          initialStatus: const SubscriptionStatus.inactive(),
          purchaseOutcome: PurchaseOutcome(
            result: const PurchaseResult.success(),
            status: active,
          ),
          restoreOutcome: const PurchaseOutcome(
            result: PurchaseResult.cancelled(),
          ),
        );
        final container = ProviderContainer(
          overrides: [
            subscriptionRepositoryProvider.overrideWith(
              (ref) async => repository,
            ),
          ],
        );
        addTearDown(container.dispose);
        await container.read(subscriptionProvider.future);

        final result = await container
            .read(subscriptionProvider.notifier)
            .purchaseMonthly();

        expect(result, const PurchaseResult.success());
        expect(container.read(subscriptionProvider).value, active);
      },
    );

    test(
      'restorePurchases keeps state when repository returns no status',
      () async {
        final repository = FakeSubscriptionRepository(
          initialStatus: const SubscriptionStatus.inactive(),
          purchaseOutcome: const PurchaseOutcome(
            result: PurchaseResult.cancelled(),
          ),
          restoreOutcome: const PurchaseOutcome(
            result: PurchaseResult.failed(
              PurchaseFailureReason.restoreNotFound,
            ),
          ),
        );
        final container = ProviderContainer(
          overrides: [
            subscriptionRepositoryProvider.overrideWith(
              (ref) async => repository,
            ),
          ],
        );
        addTearDown(container.dispose);
        await container.read(subscriptionProvider.future);

        final result = await container
            .read(subscriptionProvider.notifier)
            .restorePurchases();

        expect(
          result,
          const PurchaseResult.failed(PurchaseFailureReason.restoreNotFound),
        );
        expect(
          container.read(subscriptionProvider).value,
          const SubscriptionStatus.inactive(),
        );
      },
    );
  });
}
