import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/feature/subscription/data/model/subscription_status.dart';
import 'package:eqmonitor/feature/subscription/data/notifier/subscription_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'is_pro_provider.g.dart';

/// Pro ユーザーかどうかを返す。
///
/// [subscriptionProvider] を watch し、active なら true。
/// ただし [BuildConfig.isProFeaturesEnabled] が false のビルドでは、Pro 機能を
/// 一時的に無効化しているため、購読状態に関わらず常に false を返す。
@Riverpod(keepAlive: true)
bool isPro(Ref ref) {
  final isProFeaturesEnabled = ref.watch(
    buildConfigProvider.select((c) => c.isProFeaturesEnabled),
  );
  if (!isProFeaturesEnabled) {
    return false;
  }
  final status = ref.watch(subscriptionProvider);
  return switch (status) {
    AsyncData(:final value) => switch (value) {
      SubscriptionStatusActive() => true,
      SubscriptionStatusInactive() => false,
    },
    _ => false,
  };
}
