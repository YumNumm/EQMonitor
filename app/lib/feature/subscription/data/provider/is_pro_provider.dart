import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_pro_provider.g.dart';

/// Pro ユーザーかどうかを返す。
///
/// [subscriptionProvider] を watch し、active なら true。
/// SDK 未統合段階では Stub の Notifier が常に [SubscriptionStatus.inactive] を
/// 返すため false。後続 PR (#12) で RevenueCat 統合後は実際の購読状態を反映する。
@Riverpod(keepAlive: true)
bool isPro(Ref ref) {
  final status = ref.watch(subscriptionProvider);
  return switch (status) {
    AsyncData(:final value) => switch (value) {
      SubscriptionStatusActive() => true,
      SubscriptionStatusInactive() => false,
    },
    _ => false,
  };
}
