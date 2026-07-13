import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/provider/app_links_interaction.dart';
import 'package:eqmonitor/core/provider/environment/environment.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging_interaction.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/beta_testing/data/notifier/beta_testing_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/onboarding/data/notifier/onboarding_notifier.dart';
import 'package:eqmonitor/feature/start/data/notifier/start_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      // 重い初期化はトリガーのみ行い、完了を待たずに Home へ遷移する。
      // keepAlive のためバックグラウンドでロードは継続し、各消費画面が
      // 個別にローディング/エラーを表示する。
      ref
        ..read(travelTimeInternalProvider.future).ignore()
        ..read(
          kyoshinMonitorInternalObservationPointsConvertedProvider.future,
        ).ignore()
        ..read(earthquakeHistoryConfigProvider)
        ..read(startProvider);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        // オンボーディング / ベータ版同意のゲーティング状態は
        // GoRouter の redirect が同期的に `.value` を参照するため、
        // 遷移前にここで解決しておく。これらは keepAlive なので一度
        // 解決すればキャッシュされ、redirect が正しい値を参照できる。
        // (解決前に遷移すると AsyncLoading -> false と誤判定され、
        //  完了済みでも再起動のたびにオンボーディングが再表示される)
        await ref.read(onboardingCompletedProvider.future);
        if (ref.read(buildConfigProvider).isBetaTesting) {
          await ref.read(betaTestingAgreedProvider.future);
        }
        if (!context.mounted) {
          return;
        }
        context.go(const HomeRoute().location);
        final pending =
            consumePendingNotificationDeepLink() ?? consumePendingAppLink();
        switch (pending) {
          case NotificationRouteLink(:final location):
            await GoRouter.of(context).push<void>(location);
          case NotificationUrlLink(:final uri):
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          case null:
            break;
        }
      });
      return null;
    }, const []);

    return const Scaffold(
      body: SafeArea(
        child: Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
