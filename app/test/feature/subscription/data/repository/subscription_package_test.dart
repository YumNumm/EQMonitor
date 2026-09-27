import 'package:eqmonitor/feature/subscription/data/model/monthly_subscription_package.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;

import '../../support/subscription_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final product = monthlyPackage.storeProduct;
  final repository = SubscriptionRepository(
    monthlyProductId: product.identifier,
    session: const TestRevenueCatSession(),
  );
  const channel = MethodChannel('purchases_flutter');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;
  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  test('rejects another platform product, period and package type', () {
    expect(
      monthlyPackage.matchesMonthlyProduct(productId: product.identifier),
      isTrue,
    );
    expect(
      monthlyPackage.matchesMonthlyProduct(
        productId: 'eqmonitor.pro.monthly:eqmonitor-pro-monthly',
      ),
      isFalse,
    );
    for (final period in ['P1Y', null]) {
      final package = rc.Package(
        r'$rc_monthly',
        rc.PackageType.monthly,
        rc.StoreProduct(
          product.identifier,
          '',
          '',
          10,
          r'$10',
          'USD',
          subscriptionPeriod: period,
        ),
        monthlyPackage.presentedOfferingContext,
      );
      expect(
        package.matchesMonthlyProduct(productId: product.identifier),
        isFalse,
      );
    }
    final annual = rc.Package(
      r'$rc_annual',
      rc.PackageType.annual,
      product,
      monthlyPackage.presentedOfferingContext,
    );
    expect(
      annual.matchesMonthlyProduct(productId: product.identifier),
      isFalse,
    );
  });

  test(
    'purchases displayed package without fetching a different offering',
    () async {
      final calls = <MethodCall>[];
      messenger.setMockMethodCallHandler(channel, (call) async {
        calls.add(call);
        throw PlatformException(code: '1');
      });
      final outcome = await repository.purchaseMonthly(package: monthlyPackage);
      expect(outcome.result, const PurchaseResult.cancelled());
      expect(calls.map((call) => call.method), ['purchasePackage']);
      final arguments = Map<String, dynamic>.from(
        calls.single.arguments as Map,
      );
      expect(arguments['packageIdentifier'], monthlyPackage.identifier);
      expect(arguments['presentedOfferingContext'], {
        'offeringIdentifier': 'current',
        'placementIdentifier': null,
        'targetingContext': null,
      });
    },
  );

  test(
    'rejects an unexpected product even when passed directly to purchase',
    () async {
      var calls = 0;
      messenger.setMockMethodCallHandler(channel, (_) async {
        calls++;
        return null;
      });
      const otherRepository = SubscriptionRepository(
        monthlyProductId: 'another.product',
        session: const TestRevenueCatSession(),
      );
      final outcome = await otherRepository.purchaseMonthly(
        package: monthlyPackage,
      );
      expect(
        outcome.result,
        const PurchaseResult.failed(PurchaseFailureReason.planNotFound),
      );
      expect(calls, 0);
    },
  );
}
