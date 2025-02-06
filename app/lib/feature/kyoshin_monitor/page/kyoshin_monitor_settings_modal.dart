import 'dart:async';

import 'package:eqmonitor/feature/kyoshin_monitor/data/model/kyoshin_monitor_settings_model.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/page/components/kyoshin_monitor_layer_information_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kyoshin_monitor_api/kyoshin_monitor_api.dart';
import 'package:sheet/route.dart';
import 'package:sheet/sheet.dart';

class KyoshinMonitorSettingsModal extends HookConsumerWidget {
  const KyoshinMonitorSettingsModal({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push(
      SheetRoute(
        fit: SheetFit.loose,
        initialExtent: 0.6,
        stops: [0.6, 1],
        decorationBuilder: (context, child) {
          return SafeArea(
            bottom: false,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: child,
            ),
          );
        },
        animationCurve: Curves.easeOutExpo,
        duration: const Duration(milliseconds: 250),
        builder: (context) => const KyoshinMonitorSettingsModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final backgroundColor = colorScheme.surfaceContainerLow;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              '強震モニタ設定',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
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
          SliverList(
            delegate: SliverChildListDelegate([
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
                  onChanged: (value) async =>
                      ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                            ref
                                .read(kyoshinMonitorSettingsProvider)
                                .copyWith(realtimeDataType: value),
                          ),
                ),
              ),
              _SettingSection(
                title: 'リアルタイムデータのレイヤー',
                child: _RealtimeLayerSelector(
                  value:
                      ref.watch(kyoshinMonitorSettingsProvider).realtimeLayer,
                  onChanged: (value) async =>
                      ref.read(kyoshinMonitorSettingsProvider.notifier).save(
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
                  value:
                      ref.watch(kyoshinMonitorSettingsProvider).kmoniMarkerType,
                  onChanged: (value) async =>
                      ref.read(kyoshinMonitorSettingsProvider.notifier).save(
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
                          .showRealtimeShindoScale,
                      onChanged: (value) async => ref
                          .read(kyoshinMonitorSettingsProvider.notifier)
                          .save(
                            ref
                                .read(kyoshinMonitorSettingsProvider)
                                .copyWith(showRealtimeShindoScale: value),
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
        ],
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

  final KmoniMarkerType value;
  final void Function(KmoniMarkerType) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<KmoniMarkerType>(
      initialSelection: value,
      onSelected: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      dropdownMenuEntries: KmoniMarkerType.values
          .map(
            (value) => DropdownMenuEntry(
              value: value,
              label: switch (value) {
                KmoniMarkerType.always => '常に表示',
                KmoniMarkerType.onlyEew => 'EEW時のみ',
                KmoniMarkerType.never => '表示しない',
              },
            ),
          )
          .toList(),
    );
  }
}
