import 'dart:async';

import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 地図の表示設定モーダル
///
/// 表示モード・観測点サブモード・震央設定・LPGM 等を変更する。
/// [isOverriding] が true のとき、推計震度 override が有効であることを表示する。
/// [onDisableOverride] は override を無効にして設定を反映させたいときに呼ばれる。
Future<void> showEarthquakeHistoryMapDisplayModeModal(
  BuildContext context, {
  required bool hasLpgmIntensity,
  bool isOverriding = false,
  VoidCallback? onDisableOverride,
}) {
  return showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    isScrollControlled: true,
    builder: (context) => _DisplayModeModalBody(
      hasLpgmIntensity: hasLpgmIntensity,
      isOverriding: isOverriding,
      onDisableOverride: onDisableOverride,
    ),
  );
}

class _DisplayModeModalBody extends ConsumerWidget {
  const _DisplayModeModalBody({
    required this.hasLpgmIntensity,
    required this.isOverriding,
    this.onDisableOverride,
  });

  final bool hasLpgmIntensity;
  final bool isOverriding;
  final VoidCallback? onDisableOverride;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      earthquakeHistoryConfigProvider.select((v) => v.requireValue.detail),
    );
    final notifier = ref.read(earthquakeHistoryConfigProvider.notifier);

    void update(EarthquakeHistoryDetailConfig newConfig) {
      unawaited(notifier.updateDetailConfig(newConfig));
      onDisableOverride?.call();
    }

    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) => SafeArea(
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
              ),
            ),

            // 推計震度 override 中のバナー
            if (isOverriding) ...[
              Card(
                color: theme.colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: theme.colorScheme.onPrimaryContainer,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '推計震度データ表示中のため、一部設定が無効になっています',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],

            // 地図の表示モード
            const _SectionHeader(title: '地図の表示モード'),
            RadioGroup<IntensityFillMode>(
              groupValue: config.intensityFillMode,
              onChanged: (m) {
                if (m != null) {
                  update(config.copyWith(intensityFillMode: m));
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final m in IntensityFillMode.values)
                    RadioListTile<IntensityFillMode>.adaptive(
                      title: Text(switch (m) {
                        IntensityFillMode.stationOnly => '観測点のみ',
                        IntensityFillMode.fill => '塗りつぶし',
                        IntensityFillMode.fillWithIcon => '塗りつぶし + 震度アイコン',
                      }),
                      value: m,
                    ),
                ],
              ),
            ),

            // 観測点の表示方法（stationOnly 選択時または override 中のみ）
            if (config.intensityFillMode == IntensityFillMode.stationOnly ||
                isOverriding) ...[
              const _SectionHeader(title: '観測点の表示方法'),
              RadioGroup<StationDisplayMode>(
                groupValue: config.stationDisplayMode,
                onChanged: (m) {
                  if (m != null) {
                    update(config.copyWith(stationDisplayMode: m));
                  }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (final m in StationDisplayMode.values)
                      RadioListTile<StationDisplayMode>.adaptive(
                        title: Text(switch (m) {
                          StationDisplayMode.maxFocused => '最大震度の観測点を強調',
                          StationDisplayMode.normal => '通常表示',
                          StationDisplayMode.allMinimized => 'すべて縮小表示',
                        }),
                        value: m,
                      ),
                  ],
                ),
              ),
            ],

            // 震央マークの表示
            const _SectionHeader(title: '震央マークの表示'),
            RadioGroup<HypocenterDisplayMode>(
              groupValue: config.hypocenterDisplayMode,
              onChanged: (m) {
                if (m != null) {
                  unawaited(
                    notifier.updateDetailConfig(
                      config.copyWith(hypocenterDisplayMode: m),
                    ),
                  );
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (final m in HypocenterDisplayMode.values)
                    RadioListTile<HypocenterDisplayMode>.adaptive(
                      title: Text(switch (m) {
                        HypocenterDisplayMode.zoomFade => 'ズームインで表示',
                        HypocenterDisplayMode.alwaysOpaque =>
                          '常に不透明（観測点の上）',
                        HypocenterDisplayMode.belowStations =>
                          '常に不透明（観測点の下）',
                      }),
                      value: m,
                    ),
                ],
              ),
            ),

            // その他のトグル
            const _SectionHeader(title: 'その他'),
            SwitchListTile.adaptive(
              title: const Text('震央の誤差矩形を表示'),
              value: config.showHypocenterError,
              onChanged: (v) => unawaited(
                notifier.updateDetailConfig(
                  config.copyWith(showHypocenterError: v),
                ),
              ),
            ),
            SwitchListTile.adaptive(
              title: const Text('観測点名を表示'),
              value: config.showStationLabel,
              onChanged: (v) => unawaited(
                notifier.updateDetailConfig(
                  config.copyWith(showStationLabel: v),
                ),
              ),
            ),
            SwitchListTile.adaptive(
              title: const Text('震度凡例を表示'),
              value: config.showLegend,
              onChanged: (v) => unawaited(
                notifier.updateDetailConfig(
                  config.copyWith(showLegend: v),
                ),
              ),
            ),
            if (hasLpgmIntensity)
              SwitchListTile.adaptive(
                title: const Text('長周期地震動階級モード'),
                value: config.showingLpgmIntensity,
                onChanged: (v) => unawaited(
                  notifier.updateDetailConfig(
                    config.copyWith(showingLpgmIntensity: v),
                  ),
                ),
              ),
            if (isOverriding)
              SwitchListTile.adaptive(
                title: const Text('推計震度データがある場合に自動で推計震度表示'),
                value: config.useEstimatedIntensityWhenAvailable,
                onChanged: (v) {
                  unawaited(
                    notifier.updateDetailConfig(
                      config.copyWith(useEstimatedIntensityWhenAvailable: v),
                    ),
                  );
                  if (!v) {
                    onDisableOverride?.call();
                  }
                },
              ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
