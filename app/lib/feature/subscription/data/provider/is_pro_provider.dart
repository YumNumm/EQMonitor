import 'package:clock/clock.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_pro_provider.g.dart';

/// Pro ユーザーかどうかを返す。
///
/// [subscriptionProvider] を watch し、active なら true。
@Riverpod(keepAlive: true)
bool isPro(Ref ref) {
  final status = ref.watch(subscriptionProvider);
  if (status.isLoading || status.hasError) return false;
  return switch (status) {
    AsyncData(:final value) => switch (value) {
      SubscriptionStatusActive(:final expiresAt) =>
        expiresAt == null || expiresAt.isAfter(clock.now()),
      SubscriptionStatusInactive() => false,
    },
    _ => false,
  };
}
