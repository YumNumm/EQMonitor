import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:eqmonitor/feature/subscription/data/provider/is_pro_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_plan_constraints_provider.g.dart';

@riverpod
AsyncValue<api.PlanConstraints> notificationPlanConstraints(Ref ref) {
  final start = ref.watch(startProvider);
  if (ref.watch(buildConfigProvider).isProFeaturesEnabled) {
    final subscription = ref.watch(subscriptionProvider);
    if (subscription case AsyncError(:final error, :final stackTrace)) {
      return AsyncError(error, stackTrace);
    }
    if (subscription.isLoading || subscription is! AsyncData) {
      return const AsyncLoading();
    }
  }
  final isPro = ref.watch(isProProvider);
  return switch (start) {
    AsyncData(:final value) when !start.isLoading => AsyncData(
      isPro ? value.planConstraints.subscription : value.planConstraints.free,
    ),
    AsyncError(:final error, :final stackTrace) => AsyncError(
      error,
      stackTrace,
    ),
    _ => const AsyncLoading(),
  };
}
