import 'package:eqmonitor/feature/subscription/data/repository/subscription_repository.dart';
import 'package:purchases_flutter/purchases_flutter.dart' as rc;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'monthly_subscription_package_provider.g.dart';

@riverpod
Future<rc.Package?> monthlySubscriptionPackage(Ref ref) async {
  final repository = await ref.watch(subscriptionRepositoryProvider.future);
  return repository.fetchMonthlyPackage();
}
