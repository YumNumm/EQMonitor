import 'package:eqmonitor/feature/subscription/data/repository/revenue_cat_session.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;

const monthlyPackage = rc.Package(
  r'$rc_monthly',
  rc.PackageType.monthly,
  rc.StoreProduct(
    'net.yumnumm.eqmontior.pro.monthly',
    'Monthly subscription',
    'EQMonitor Pro',
    320,
    '¥320',
    'JPY',
    subscriptionPeriod: 'P1M',
  ),
  rc.PresentedOfferingContext('current', null, null),
);

class TestRevenueCatSession extends RevenueCatSession {
  const new()
    : super(
        deviceId: 'device',
        token: 'token',
        apiKey: 'test',
        readToken: readTestToken,
      );

  @override
  Future<T> run<T>({required Future<T> Function() operation}) => operation();

  @override
  Future<void> validateCredentials() async {}
}

Future<String?> readTestToken() async => 'token';

const emptyCustomerInfo = <String, dynamic>{
  'entitlements': {'all': <String, dynamic>{}, 'active': <String, dynamic>{}},
  'allPurchaseDates': <String, dynamic>{},
  'activeSubscriptions': <String>[],
  'allPurchasedProductIdentifiers': <String>[],
  'nonSubscriptionTransactions': <String>[],
  'firstSeen': '2026-09-26T00:00:00Z',
  'originalAppUserId': r'$RCAnonymousID:legacy',
  'allExpirationDates': <String, dynamic>{},
  'requestDate': '2026-09-26T00:00:00Z',
};
