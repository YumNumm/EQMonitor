import 'dart:async';

import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_color_map.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_scale_widget.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_cautionary_note_page.dart';
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
    return const MaterialExtendedPage<void>(
      child: KyoshinMonitorSettingsPage(),
    );
  }
}

class KyoshinMonitorSettingsModalRoute extends GoRouteData {
  const KyoshinMonitorSettingsModalRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoSheetPage<void>(
      child: KyoshinMonitorSettingsPage(),
    );
  }
}

class KyoshinMonitorSettingsPage extends ConsumerWidget {
  const KyoshinMonitorSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kyoshinMonitorSettingsProvider);

    final body = CupertinoPageScaffold(
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
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('強震モニタ設定'),
      ),
      body: body,
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
            final result = await const KyoshinMonitorCautionaryNoteModalRoute()
                .push<bool>(context);

            if (result != null && result) {
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
                    child: KyoshinMonitorScaleWidget(
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
        _LocationSwitchListTile(state: state),
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
                for (final type
                    in RealtimeDataType.values.where((e) => !e.isLpgm))
                  DropdownMenuEntry(
                    value: type,
                    label: type.displayName,
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

class _LocationSwitchListTile extends ConsumerWidget {
  const _LocationSwitchListTile({
    required this.state,
  });

  final KyoshinMonitorSettingsModel state;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final switchListTile = SwitchListTile.adaptive(
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
    );

    return switchListTile;
  }
}
