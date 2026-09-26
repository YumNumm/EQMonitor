import 'package:eqmonitor/feature/subscription/data/model/purchase_failure_reason.dart';
import 'package:eqmonitor/feature/subscription/data/model/purchase_result.dart';
import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('purchases_flutter');
  final messenger =
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger;

  tearDown(() => messenger.setMockMethodCallHandler(channel, null));

  test(
    'does not purchase monthly fallback when product ID does not match',
    () async {
      var purchases = 0;
      final wrongPackage = <String, dynamic>{
        'identifier': r'$rc_monthly',
        'packageType': 'MONTHLY',
        'presentedOfferingContext': {'offeringIdentifier': 'current'},
        'product': {
          'identifier': 'another.product',
          'description': 'Another product',
          'title': 'Another product',
          'price': 320.0,
          'priceString': '¥320',
          'currencyCode': 'JPY',
          'subscriptionPeriod': 'P1M',
        },
      };
      messenger.setMockMethodCallHandler(channel, (call) async {
        if (call.method == 'getOfferings') {
          return {
            'all': <String, dynamic>{},
            'current': {
              'identifier': 'current',
              'serverDescription': 'Current offering',
              'metadata': <String, dynamic>{},
              'availablePackages': [wrongPackage],
              'monthly': wrongPackage,
            },
          };
        }
        if (call.method == 'purchasePackage') {
          purchases++;
          throw PlatformException(code: '1');
        }
        return null;
      });
      const repository = SubscriptionRepository(
        monthlyProductId: 'expected.product',
      );

      final outcome = await repository.purchaseMonthly();

      expect(
        outcome.result,
        const PurchaseResult.failed(PurchaseFailureReason.planNotFound),
      );
      expect(purchases, 0);
    },
  );
}
