import 'package:eqmonitor/feature/home/ui/component/map/home_map_content.dart';
import 'package:eqmonitor/feature/home/ui/component/map/home_map_layer_modal.dart';
import 'package:eqmonitor/feature/home/ui/component/map/kyoshin_monitor_scale_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_settings_modal.dart';
import 'package:eqmonitor/feature/map/ui/components/controller/map_layer_controller_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeMapView extends HookConsumerWidget {
  const HomeMapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Stack(
      children: [
        HomeMapContent(),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: _MapHeader(),
          ),
        ),
      ],
    );
  }
}

class _MapHeader extends ConsumerWidget {
  const _MapHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useKmoni = ref.watch(
      kyoshinMonitorSettingsProvider.select(
        (v) => v.useKmoni,
      ),
    );
    final showScaleCard = ref.watch(
      kyoshinMonitorSettingsProvider.select(
        (v) => v.showScale,
      ),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child:
              useKmoni
                  ? Column(
                    key: const ValueKey(
                      'kyoshin_monitor_status_card',
                    ),
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      KyoshinMonitorStatusCard(
                        onTap:
                            () async =>
                                KyoshinMonitorSettingsModal.show(
                                  context,
                                ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 200,
                          ),
                          child:
                              showScaleCard
                                  ? const KyoshinMonitorScaleCard()
                                  : const SizedBox.shrink(),
                        ),
                      ),
                    ],
                  )
                  : const SizedBox.shrink(),
        ),
        const Column(),
        MapLayerControllerCard(
          onLayerButtonTap:
              () async => HomeMapLayerModal.show(context),
          onLocationButtonTap: () async {},
        ),
      ],
    );
  }
}
