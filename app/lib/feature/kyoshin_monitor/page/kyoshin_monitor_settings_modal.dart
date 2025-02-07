import 'dart:async';
import 'dart:ui';

import 'package:eqmonitor/core/component/sheet/app_sheet_route.dart';
import 'package:eqmonitor/core/component/widget/app_list_tile.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_layer_information_dialog.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/kyoshin_monitor_about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';

class KyoshinMonitorSettingsModal extends HookConsumerWidget {
  const KyoshinMonitorSettingsModal({super.key});

  static Future<void> show(BuildContext context) => Navigator.of(context).push(
        AppSheetRoute(
          builder: (context) => const ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            child: KyoshinMonitorSettingsModal(),
          ),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = colorScheme.surfaceContainerLow;

    final isEnabled =
        ref.watch(kyoshinMonitorSettingsProvider.select((v) => v.useKmoni));

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverAppBar(
            pinned: true,
            title: BackdropFilter(
              filter: ImageFilter.compose(
                outer: ImageFilter.blur(
                  sigmaX: 8,
                  sigmaY: 8,
                  tileMode: TileMode.mirror,
                ),
                inner: ColorFilter.mode(
                  colorScheme.surfaceContainerLow.withValues(alpha: 0.7),
                  BlendMode.srcATop,
                ),
              ),
              child: const Text(
                '強震モニタ設定',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton.filledTonal(
                onPressed: () {
                  unawaited(HapticFeedback.lightImpact());
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: _KyoshinMonitorSwitchListTile(),
          ),
          if (isEnabled)
            SliverSafeArea(
              top: false,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: () async =>
                          const KyoshinMonitorAboutRoute().push<void>(context),
                      icon: const Icon(Icons.info_outline_rounded),
                      label: const Text('強震モニタとは?'),
                    ),
                  ),
                  _SettingSection(
                    title: 'リアルタイムデータの種類',
                    trailing: IconButton(
                      icon: const Icon(Icons.info_outline),
                      onPressed: () async =>
                          RealtimeDataTypeInfoDialog.show(context),
                    ),
                    child: _RealtimeDataTypeSelector(
                      value: ref
                          .watch(kyoshinMonitorSettingsProvider)
                          .realtimeDataType,
                      onChanged: (value) async => ref
                          .read(kyoshinMonitorSettingsProvider.notifier)
                          .save(
                            ref
                                .read(kyoshinMonitorSettingsProvider)
                                .copyWith(realtimeDataType: value),
                          ),
                    ),
                  ),
                  _SettingSection(
                    title: 'リアルタイムデータのレイヤー',
                    child: _RealtimeLayerSelector(
                      value: ref
                          .watch(kyoshinMonitorSettingsProvider)
                          .realtimeLayer,
                      onChanged: (value) async => ref
                          .read(kyoshinMonitorSettingsProvider.notifier)
                          .save(
                            ref
                                .read(kyoshinMonitorSettingsProvider)
                                .copyWith(realtimeLayer: value),
                          ),
                    ),
                  ),
                  _SettingSection(
                    title: '観測点の枠',
                    description:
                        '観測点の円の周りに灰色の枠を表示します。\n地図の背景や他の観測点とのコントラストを高めることができます。',
                    child: _MarkerTypeSelector(
                      value: ref
                          .watch(kyoshinMonitorSettingsProvider)
                          .kmoniMarkerType,
                      onChanged: (value) async => ref
                          .read(kyoshinMonitorSettingsProvider.notifier)
                          .save(
                            ref
                                .read(kyoshinMonitorSettingsProvider)
                                .copyWith(kmoniMarkerType: value),
                          ),
                    ),
                  ),
                  _SettingSection(
                    title: 'その他の設定',
                    child: Column(
                      children: [
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('スケールを表示'),
                          subtitle: const Text(
                            'リアルタイムデータの点の色が、どの値を示すかのスケールを表示します\n'
                            '地図画面左上の時刻表示をタップすることで、切り替えることもできます',
                          ),
                          value: ref
                              .watch(kyoshinMonitorSettingsProvider)
                              .showScale,
                          onChanged: (value) async => ref
                              .read(kyoshinMonitorSettingsProvider.notifier)
                              .save(
                                ref
                                    .read(kyoshinMonitorSettingsProvider)
                                    .copyWith(showScale: value),
                              ),
                        ),
                        SwitchListTile.adaptive(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('現在地マーカーを表示'),
                          subtitle: const Text(
                            '地図上に現在地を示すマーカーを表示します',
                          ),
                          value: ref
                              .watch(kyoshinMonitorSettingsProvider)
                              .showCurrentLocationMarker,
                          onChanged: (value) async => ref
                              .read(kyoshinMonitorSettingsProvider.notifier)
                              .save(
                                ref
                                    .read(kyoshinMonitorSettingsProvider)
                                    .copyWith(showCurrentLocationMarker: value),
                              ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
        ],
      ),
    );
  }
}

class _KyoshinMonitorSwitchListTile extends ConsumerWidget {
  const _KyoshinMonitorSwitchListTile();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEnabled =
        ref.watch(kyoshinMonitorSettingsProvider.select((v) => v.useKmoni));

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: AppListTile.switchListTile(
        title: '強震モニタを利用する',
        subtitle: '強震モニタを利用するかどうかを選択します',
        value: isEnabled,
        onChanged: (value) async => selectionHapticFunction(
          () async => ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                ref
                    .read(kyoshinMonitorSettingsProvider)
                    .copyWith(useKmoni: value),
              ),
        ),
      ),
    );
  }
}

class _SettingSection extends StatelessWidget {
  const _SettingSection({
    required this.title,
    required this.child,
    this.description,
    this.trailing,
  });

  final String title;
  final Widget child;
  final String? description;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          if (description != null)
            Text(
              description!,
              style: textTheme.bodyMedium!.copyWith(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _RealtimeDataTypeSelector extends StatelessWidget {
  const _RealtimeDataTypeSelector({
    required this.value,
    required this.onChanged,
  });

  final RealtimeDataType value;
  final void Function(RealtimeDataType) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<RealtimeDataType>(
      initialSelection: value,
      onSelected: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      dropdownMenuEntries: RealtimeDataType.values
          .where((e) => !e.isLpgm)
          .map(
            (e) => DropdownMenuEntry(
              value: e,
              label: e.displayName,
            ),
          )
          .toList(),
    );
  }
}

class _RealtimeLayerSelector extends StatelessWidget {
  const _RealtimeLayerSelector({
    required this.value,
    required this.onChanged,
  });

  final RealtimeLayer value;
  final void Function(RealtimeLayer) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<RealtimeLayer>(
      initialSelection: value,
      onSelected: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      dropdownMenuEntries: const [
        DropdownMenuEntry(
          value: RealtimeLayer.surface,
          label: '地表',
        ),
        DropdownMenuEntry(
          value: RealtimeLayer.underground,
          label: '地中',
        ),
      ],
    );
  }
}

class _MarkerTypeSelector extends StatelessWidget {
  const _MarkerTypeSelector({
    required this.value,
    required this.onChanged,
  });

  final KyoshinMonitorMarkerType value;
  final void Function(KyoshinMonitorMarkerType) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<KyoshinMonitorMarkerType>(
      initialSelection: value,
      onSelected: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      dropdownMenuEntries: KyoshinMonitorMarkerType.values
          .map(
            (value) => DropdownMenuEntry(
              value: value,
              label: switch (value) {
                KyoshinMonitorMarkerType.always => '常に表示',
                KyoshinMonitorMarkerType.onlyEew => 'EEW時のみ',
                KyoshinMonitorMarkerType.never => '表示しない',
              },
            ),
          )
          .toList(),
    );
  }
}
