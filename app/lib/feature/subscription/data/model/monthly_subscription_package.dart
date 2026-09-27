import 'package:purchases_flutter/purchases_flutter.dart' as rc;

extension MonthlySubscriptionPackage on rc.Package {
  bool matchesMonthlyProduct({required String productId}) =>
      storeProduct.identifier == productId &&
      packageType == rc.PackageType.monthly &&
      storeProduct.subscriptionPeriod == 'P1M';
}
