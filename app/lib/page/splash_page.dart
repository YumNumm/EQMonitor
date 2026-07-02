import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/fcm/notification_deep_link.dart';
import 'package:eqmonitor/core/provider/firebase/firebase_messaging_interaction.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
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
    final kyoshinPoints = ref.watch(
      kyoshinMonitorInternalObservationPointsConvertedProvider,
    );
    final travelTime = ref.watch(travelTimeInternalProvider);
    final historyConfig = ref.watch(earthquakeHistoryConfigProvider);

    final allLoaded =
        kyoshinPoints.hasValue && travelTime.hasValue && historyConfig.hasValue;
    final hasError =
        !allLoaded &&
        (kyoshinPoints.hasError ||
            travelTime.hasError ||
            historyConfig.hasError);
    final error =
        kyoshinPoints.error ?? travelTime.error ?? historyConfig.error;

    useEffect(
      () {
        if (allLoaded) {
          // SWR: build() が自動でキャッシュ即表示→裏で再検証
          ref.read(startProvider);
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            context.go(const HomeRoute().location);
            final pending = consumePendingNotificationDeepLink();
            switch (pending) {
              case NotificationRouteLink(:final location):
                await GoRouter.of(context).push<void>(location);
              case NotificationUrlLink(:final uri):
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              case null:
                break;
            }
          });
        }
        return null;
      },
      [allLoaded],
    );

    return Scaffold(
      body: SafeArea(
        child: hasError
            ? ErrorCard(
                error: error ?? Exception('Unknown error'),
                onReload: () async {
                  ref.invalidate(parameterSetProvider, asReload: true);
                  ref.invalidate(travelTimeInternalProvider, asReload: true);
                  ref.invalidate(
                    earthquakeHistoryConfigProvider,
                    asReload: true,
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
      ),
    );
  }
}
