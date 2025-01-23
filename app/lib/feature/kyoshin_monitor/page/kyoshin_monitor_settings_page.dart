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

            // final result = await showKyoshinMonitorCautionaryNoteModal(context);

            final result = await const KyoshinMonitorCautionaryNoteModalRoute()
                .push<void>(context);

            // final result = await showModalBottomSheet<bool>(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) => SafeArea(
            //     child: Column(
            //       children: [
            //         barWidget,
            //         const SingleChildScrollView(
            //           child: SafeArea(
            //             child: Column(
            //               children: [
            //                 SheetHeader(title: '強震モニタの注意点'),
            //               ],
            //             ),
            //           ),
            //         ),
            //         UseKmoniButton(
            //           onDisabled: () => Navigator.of(context).pop(false),
            //           onEnabled: () => Navigator.of(context).pop(true),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
            // final isAccepted = result != null && result;

            // if (isAccepted) {
            //   unawaited(
            //     ref.read(kyoshinMonitorSettingsProvider.notifier).save(
            //           state.copyWith(useKmoni: value),
            //         ),
            //   );
            // }
            return;
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
      ],
    );
  }
}
