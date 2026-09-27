import 'dart:async';

import 'package:dio/dio.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/model/environment.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_outcome.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_server_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;

import '../../support/subscription_fixtures.dart';

const buildConfig = BuildConfig(
  restApiUrl: '',
  appIdSuffix: '',
  appName: 'EQMonitor',
  commitInformation: 'test',
  flavor: Flavor.dev,
  wsApiUrl: '',
  googleIosClientId: '',
  googleAndroidClientId: '',
  buildTimestamp: '',
  buildCommitMessage: '',
  revenueCatApiKeyIos: '',
  revenueCatApiKeyAndroid: '',
  isProFeaturesEnabled: true,
);
const inactive = SubscriptionStatus.inactive();
const active = SubscriptionStatus.active(productId: 'pro');
const purchased = PurchaseOutcome(
  result: PurchaseResult.success(),
  status: active,
);

class FakeSubscriptionRepository extends SubscriptionRepository {
  new()
    : super(monthlyProductId: 'test', session: const TestRevenueCatSession());
  SubscriptionStatus store = inactive;
  PurchaseOutcome outcome = purchased;
  Completer<PurchaseOutcome>? completion;
  var purchases = 0;
  var restores = 0;
  var fetches = 0;
  @override
  Future<SubscriptionStatus> fetchStatus() async {
    fetches++;
    return store;
  }

  @override
  Future<PurchaseOutcome> purchaseMonthly({required rc.Package package}) async {
    purchases++;
    return completion?.future ?? outcome;
  }

  @override
  Future<PurchaseOutcome> restorePurchases() async {
    restores++;
    return outcome;
  }
}

class FakeServer extends SubscriptionServerRepository {
  new() : super(client: api.SubscriptionApiClient(Dio()));
  Result<SubscriptionStatus, SubscriptionApiException> current = const Success(
    inactive,
  );
  Result<SubscriptionStatus, SubscriptionApiException> synced = const Success(
    active,
  );
  var syncs = 0;
  @override
  Future<Result<SubscriptionStatus, SubscriptionApiException>> fetch({
    bool synchronize = false,
  }) async {
    if (synchronize) {
      syncs++;
      return synced;
    }
    return current;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FakeSubscriptionRepository repository;
  late FakeServer server;
  late ProviderContainer container;
  setUp(() {
    repository = FakeSubscriptionRepository();
    server = FakeServer();
    container = ProviderContainer(
      retry: (_, _) => null,
      overrides: [
        buildConfigProvider.overrideWithValue(buildConfig),
        subscriptionRepositoryProvider.overrideWith((ref) async => repository),
        subscriptionServerRepositoryProvider.overrideWith(
          (ref) async => server,
        ),
      ],
    );
  });
  tearDown(() => container.dispose());

  test(
    'backend membership stays Pro when store identity was transferred',
    () async {
      server.current = const Success(active);
      expect(await container.read(subscriptionProvider.future), active);
      expect(repository.fetches, 0);
    },
  );

  test(
    'SDK active alone never grants Pro; pending backend is retriable',
    () async {
      repository.store = active;
      server.synced = const Failure(
        SubscriptionApiException(reason: SubscriptionApiFailure.pending),
      );
      final status = await container.read(subscriptionProvider.future);
      expect(
        status,
        const SubscriptionStatus.inactive(
          syncPhase: SubscriptionSyncPhase.pending,
        ),
      );
    },
  );

  test(
    'purchase waits for server; retry synchronizes without another purchase',
    () async {
      await container.read(subscriptionProvider.future);
      server.synced = const Failure(
        SubscriptionApiException(reason: SubscriptionApiFailure.unavailable),
      );
      final notifier = container.read(subscriptionProvider.notifier);
      expect(
        await notifier.purchaseMonthly(package: monthlyPackage),
        const PurchaseResult.pending(),
      );
      expect(
        container.read(subscriptionProvider).value?.syncPhase,
        SubscriptionSyncPhase.failed,
      );
      server.synced = const Success(active);
      await notifier.synchronize();
      expect(container.read(subscriptionProvider).value, active);
      expect(repository.purchases, 1);
      expect(repository.restores, 0);
    },
  );

  test(
    'cancelled purchase does not synchronize or change entitlement',
    () async {
      await container.read(subscriptionProvider.future);
      repository.outcome = const PurchaseOutcome(
        result: PurchaseResult.cancelled(),
      );
      expect(
        await container
            .read(subscriptionProvider.notifier)
            .purchaseMonthly(package: monthlyPackage),
        const PurchaseResult.cancelled(),
      );
      expect(server.syncs, 0);
      expect(container.read(subscriptionProvider).value, inactive);
    },
  );

  test(
    'restore without a purchase remains inactive instead of pending',
    () async {
      await container.read(subscriptionProvider.future);
      repository.outcome = const PurchaseOutcome(
        result: PurchaseResult.failed(PurchaseFailureReason.restoreNotFound),
        status: inactive,
      );
      server.synced = const Success(inactive);
      expect(
        await container.read(subscriptionProvider.notifier).restorePurchases(),
        const PurchaseResult.failed(PurchaseFailureReason.restoreNotFound),
      );
      expect(container.read(subscriptionProvider).value, inactive);
    },
  );

  test(
    'restore on another device grants only verified backend entitlement',
    () async {
      await container.read(subscriptionProvider.future);
      expect(
        await container.read(subscriptionProvider.notifier).restorePurchases(),
        const PurchaseResult.success(),
      );
      expect(container.read(subscriptionProvider).value, active);
      expect(repository.restores, 1);
      expect(repository.purchases, 0);
    },
  );

  test('server active prevents duplicate purchase', () async {
    server.current = const Success(active);
    await container.read(subscriptionProvider.future);
    expect(
      await container
          .read(subscriptionProvider.notifier)
          .purchaseMonthly(package: monthlyPackage),
      const PurchaseResult.success(),
    );
    expect(repository.purchases, 0);
  });

  test('unauthorized preflight prevents store purchase', () async {
    await container.read(subscriptionProvider.future);
    server.current = const Failure(
      SubscriptionApiException(
        reason: SubscriptionApiFailure.authenticationRequired,
      ),
    );
    await expectLater(
      container
          .read(subscriptionProvider.notifier)
          .purchaseMonthly(package: monthlyPackage),
      throwsA(isA<SubscriptionApiException>()),
    );
    expect(repository.purchases, 0);
    expect(container.read(subscriptionProvider).hasError, isTrue);
  });

  test(
    'confirmed revocation clears Pro without claiming a pending purchase',
    () async {
      server.current = const Success(active);
      await container.read(subscriptionProvider.future);
      server.synced = const Success(inactive);
      await container.read(subscriptionProvider.notifier).synchronize();
      expect(container.read(subscriptionProvider).value, inactive);
    },
  );

  test('401 synchronization immediately clears previous Pro', () async {
    server.current = const Success(active);
    await container.read(subscriptionProvider.future);
    server.synced = const Failure(
      SubscriptionApiException(
        reason: SubscriptionApiFailure.authenticationRequired,
      ),
    );
    await container.read(subscriptionProvider.notifier).synchronize();
    expect(
      container.read(subscriptionProvider).value,
      const SubscriptionStatus.inactive(
        syncPhase: SubscriptionSyncPhase.authenticationRequired,
      ),
    );
  });

  test(
    'simultaneous purchase and restore execute only one store operation',
    () async {
      await container.read(subscriptionProvider.future);
      repository.completion = Completer<PurchaseOutcome>();
      final notifier = container.read(subscriptionProvider.notifier);
      final purchase = notifier.purchaseMonthly(package: monthlyPackage);
      await Future<void>.delayed(Duration.zero);
      expect(
        await notifier.restorePurchases(),
        const PurchaseResult.failed(PurchaseFailureReason.operationInProgress),
      );
      repository.completion?.complete(purchased);
      await purchase;
      expect(repository.purchases, 1);
      expect(repository.restores, 0);
    },
  );

  test(
    'old purchase completion cannot overwrite a rebuilt device state',
    () async {
      await container.read(subscriptionProvider.future);
      repository.completion = Completer<PurchaseOutcome>();
      final purchase = container
          .read(subscriptionProvider.notifier)
          .purchaseMonthly(package: monthlyPackage);
      await Future<void>.delayed(Duration.zero);
      container.invalidate(subscriptionRepositoryProvider);
      await container.read(subscriptionProvider.future);
      repository.completion?.complete(purchased);
      expect(await purchase, const PurchaseResult.cancelled());
      expect(container.read(subscriptionProvider).value, inactive);
      expect(server.syncs, 0);
    },
  );

  test('foreground refresh rechecks server entitlement', () async {
    await container.read(subscriptionProvider.future);
    container
        .read(appLifecycleProvider.notifier)
        .didChangeAppLifecycleState(AppLifecycleState.paused);
    server.current = const Success(active);
    container
        .read(appLifecycleProvider.notifier)
        .didChangeAppLifecycleState(AppLifecycleState.resumed);
    expect(await container.read(subscriptionProvider.future), active);
  });

  test('offline startup is an error, not a verified Free status', () async {
    server.current = const Failure(
      SubscriptionApiException(reason: SubscriptionApiFailure.unavailable),
    );
    await expectLater(
      container.read(subscriptionProvider.future),
      throwsA(isA<SubscriptionApiException>()),
    );
    expect(repository.purchases, 0);
  });
  test(
    'disabled feature never initializes repositories or purchases',
    () async {
      container.dispose();
      container = ProviderContainer(
        overrides: [
          buildConfigProvider.overrideWithValue(
            buildConfig.copyWith(isProFeaturesEnabled: false),
          ),
          subscriptionRepositoryProvider.overrideWith(
            (ref) => throw StateError('must not initialize'),
          ),
        ],
      );
      expect(await container.read(subscriptionProvider.future), inactive);
      final notifier = container.read(subscriptionProvider.notifier);
      expect(
        await notifier.purchaseMonthly(package: monthlyPackage),
        const PurchaseResult.cancelled(),
      );
      expect(
        await notifier.restorePurchases(),
        const PurchaseResult.cancelled(),
      );
      await notifier.synchronize();
    },
  );

  testWidgets('expiry schedules a server refresh without a UI action', (
    tester,
  ) async {
    server.current = Success(
      SubscriptionStatus.active(
        productId: 'pro',
        expiresAt: DateTime.now().add(const Duration(seconds: 2)),
      ),
    );
    final listener = container.listen(subscriptionProvider, (_, _) {});
    addTearDown(listener.close);
    await tester.pump();
    expect(
      container.read(subscriptionProvider).value,
      isA<SubscriptionStatusActive>(),
    );
    server.current = const Success(inactive);
    await tester.pump(const Duration(seconds: 3));
    expect(container.read(subscriptionProvider).value, inactive);
  });
}
