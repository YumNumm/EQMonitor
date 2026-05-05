import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/kmoni_observation_points/provider/kyoshin_observation_points_provider.dart';
import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        (kyoshinPoints.hasError || travelTime.hasError || historyConfig.hasError);
    final error =
        kyoshinPoints.error ?? travelTime.error ?? historyConfig.error;

    useEffect(
      () {
        if (allLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(const HomeRoute().location);
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
                error: error!,
                onReload: () async {
                  ref.invalidate(parameterSetProvider);
                  ref.invalidate(travelTimeInternalProvider);
                  ref.invalidate(earthquakeHistoryConfigProvider);
                },
              )
            : const Center(child: CircularProgressIndicator.adaptive()),
      ),
    );
  }
}
