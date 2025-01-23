import 'dart:async';

import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_scale.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_cautionary_note_page.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/provider/kmoni_color_provider.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:sheet/route.dart';

class KyoshinMonitorSettingsRoute extends GoRouteData {
  const KyoshinMonitorSettingsRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoExtendedPage<void>(
      child: KyoshinMonitorSettingsPage(),
    );
  }
}

class KyoshinMonitorSettingsPage extends ConsumerWidget {
  const KyoshinMonitorSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kyoshinMonitorSettingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('強震モニタ設定'),
      ),
      body: CupertinoPageScaffold(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const KyoshinMonitorSettingsUseToggle(),
              const SizedBox(height: 8),
              const Divider(),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: state.useKmoni
                    ? const KeyedSubtree(
                        key: ValueKey('use-kmoni'),
                        child: _Body(),
                      )
                    : const SizedBox.shrink(key: ValueKey('not-use-kmoni')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KyoshinMonitorSettingsUseToggle extends ConsumerWidget {
  const KyoshinMonitorSettingsUseToggle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kyoshinMonitorSettingsProvider);
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: theme.colorScheme.primaryContainer,
      child: SwitchListTile.adaptive(
        value: state.useKmoni,
        onChanged: (value) async {
          if (value) {
            final barWidget = Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 36,
              height: 4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.colorScheme.onSurface,
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: Colors.black12, blurRadius: 12),
                ],
              ),
            );

            final result = await const KyoshinMonitorCautionaryNoteModalRoute()
                .push<bool>(context);

            if (result == true) {
              unawaited(
                ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                      state.copyWith(useKmoni: value),
                    ),
              );
            }
          } else {
            unawaited(
              ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                    state.copyWith(useKmoni: value),
                  ),
            );
          }
        },
        title: const Text('強震モニタを表示する'),
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kyoshinMonitorSettingsProvider);
    final colorMap = ref.watch(kyoshinColorMapProvider);
    final (min, max) = (colorMap.first, colorMap.last);
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('リアルタイム震度の表示しきい値'),
          subtitle: SliderTheme(
            data: theme.sliderTheme,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                    child: KmoniScaleWidget(
                      showText: false,
                      markers: [
                        if (state.minRealtimeShindo != null &&
                            state.minRealtimeShindo != -3.0)
                          state.minRealtimeShindo!,
                      ],
                      position: KmoniIntensityPosition.under,
                    ),
                  ),
                  Slider(
                    min: min.intensity,
                    max: max.intensity,
                    value: state.minRealtimeShindo ?? min.intensity,
                    onChanged: (value) async =>
                        ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                              ref.read(kyoshinMonitorSettingsProvider).copyWith(
                                    minRealtimeShindo: value,
                                  ),
                            ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SwitchListTile.adaptive(
          value: state.showRealtimeShindoScale,
          onChanged: (value) async =>
              ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                    ref.read(kyoshinMonitorSettingsProvider).copyWith(
                          showRealtimeShindoScale: value,
                        ),
                  ),
          title: const Text('リアルタイム震度のスケールを表示'),
        ),
        SwitchListTile.adaptive(
          title: const Text('地図上に現在地のマーカーを表示する'),
          value: state.showCurrentLocationMarker,
          onChanged: (value) async {
            await ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                  ref.read(kyoshinMonitorSettingsProvider).copyWith(
                        showCurrentLocationMarker: value,
                      ),
                );
            ref.invalidate(locationStreamProvider);
          },
        ),
        ListTile(
          title: const Text('観測点の枠表示モード'),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DropdownMenu(
              initialSelection: state.kmoniMarkerType,
              onSelected: (value) async =>
                  ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                        ref.read(kyoshinMonitorSettingsProvider).copyWith(
                              kmoniMarkerType: value!,
                            ),
                      ),
              dropdownMenuEntries: [
                for (final type in KmoniMarkerType.values)
                  DropdownMenuEntry(
                    value: type,
                    label: switch (type) {
                      KmoniMarkerType.always => '常に枠を表示する',
                      KmoniMarkerType.onlyEew => '緊急地震速報発表時のみ',
                      KmoniMarkerType.never => '枠を表示しない',
                    },
                  ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('リアルタイムデータの種類'),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DropdownMenu(
              initialSelection: state.realtimeDataType,
              onSelected: (value) async =>
                  ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                        ref.read(kyoshinMonitorSettingsProvider).copyWith(
                              realtimeDataType: value!,
                            ),
                      ),
              dropdownMenuEntries: [
                for (final type in RealtimeDataType.values)
                  DropdownMenuEntry(
                    value: type,
                    label: switch (type) {
                      RealtimeDataType.shindo => 'リアルタイム震度',
                      RealtimeDataType.pga => '最大加速度',
                      RealtimeDataType.pgv => '最大速度',
                      RealtimeDataType.pgd => '最大変位',
                      RealtimeDataType.response0125Hz => '応答速度(0.125Hz)',
                      RealtimeDataType.response025Hz => '応答速度(0.25Hz)',
                      RealtimeDataType.response05Hz => '応答速度(0.5Hz)',
                      RealtimeDataType.response1Hz => '応答速度(1Hz)',
                      RealtimeDataType.response2Hz => '応答速度(2Hz)',
                      RealtimeDataType.response4Hz => '応答速度(4Hz)',
                      RealtimeDataType.abrspmx => '長周期地震動階級',
                      RealtimeDataType.abrsp1s => '階級データ(周期1秒台)',
                      RealtimeDataType.abrsp2s => '階級データ(周期2秒台)',
                      RealtimeDataType.abrsp3s => '階級データ(周期3秒台)',
                      RealtimeDataType.abrsp4s => '階級データ(周期4秒台)',
                      RealtimeDataType.abrsp5s => '階級データ(周期5秒台)',
                      RealtimeDataType.abrsp6s => '階級データ(周期6秒台)',
                      RealtimeDataType.abrsp7s => '階級データ(周期7秒台)',
                    },
                  ),
              ],
            ),
          ),
        ),
        ListTile(
          title: const Text('リアルタイムデータのレイヤー'),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: DropdownMenu(
              initialSelection: state.realtimeLayer,
              onSelected: (value) async =>
                  ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                        ref.read(kyoshinMonitorSettingsProvider).copyWith(
                              realtimeLayer: value!,
                            ),
                      ),
              dropdownMenuEntries: [
                for (final layer in RealtimeLayer.values)
                  DropdownMenuEntry(
                    value: layer,
                    label: switch (layer) {
                      RealtimeLayer.surface => '地表',
                      RealtimeLayer.underground => '地中',
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
