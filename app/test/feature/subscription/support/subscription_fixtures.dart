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
