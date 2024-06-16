import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'donation_notifier.g.dart';

Future<void> initInAppPurchase() async {
  await Purchases.setLogLevel(
    kDebugMode ? LogLevel.debug : LogLevel.warn,
  );

  // Public App-specific API Keys
  final configuration = switch (defaultTargetPlatform) {
    TargetPlatform.android => PurchasesConfiguration(
        'goog_aEcAyBNviKgaKzmCwAOXSiXwHIb',
      ),
    TargetPlatform.iOS || TargetPlatform.macOS => PurchasesConfiguration(
        'appl_BUymtTPkwhhVuihBlVOddLxOBaQ',
      ),
    _ => throw UnimplementedError(),
  };

  await Purchases.configure(configuration);
}

@Riverpod(keepAlive: true)
Future<List<StoreProduct>> products(ProductsRef ref) => Purchases.getProducts(
      Products.values.map((e) => e.id).toList(),
      productCategory: ProductCategory.nonSubscription,
    );

@riverpod
Future<CustomerInfo> purchase(PurchaseRef ref, StoreProduct product) =>
    Purchases.purchaseStoreProduct(product);

enum Products {
  coffee('0001'),
  enegyDrink('400'),
  meat('1000'),
  eel('3000'),
  ;

  const Products(this.id);
  final String id;
}
