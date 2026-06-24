import 'dart:async';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/model/earthquake_history_map_layer_mode.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryMapDisplayModeModal extends ConsumerWidget {
  const EarthquakeHistoryMapDisplayModeModal._({
    required this.hasLpgmIntensity,
    required this.hasTileUrl,
  });

  final bool hasLpgmIntensity;
  final bool hasTileUrl;

  /// 地図の表示設定モーダル
  static Future<void> show({
    required BuildContext context,
    required bool hasLpgmIntensity,
    bool hasTileUrl = false,
  }) => showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    isScrollControlled: true,
    builder: (context) => EarthquakeHistoryMapDisplayModeModal._(
      hasLpgmIntensity: hasLpgmIntensity,
      hasTileUrl: hasTileUrl,
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(earthquakeHistoryConfigProvider);
    final notifier = ref.read(earthquakeHistoryConfigProvider.notifier);

    final theme = Theme.of(context);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return switch (config) {
          AsyncLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          AsyncError(:final error) => Text(
            '致命的なエラーが発生しました。アプリケーションを再起動してください。$error',
          ),
          AsyncData(:final value) => Theme(
            data: Theme.of(
              context,
            ).copyWith(visualDensity: VisualDensity.compact),
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
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.3,
                      ),
                    ),
                  ),
                ),

                // 震央マークの表示
                const _SectionHeader(title: '震央マークの表示'),
                RadioGroup<HypocenterDisplayMode>(
                  groupValue: value.detail.hypocenterDisplayMode,
                  onChanged: (m) async {
                    if (m != null) {
                      await ref
                          .read(earthquakeHistoryConfigProvider.notifier)
                          .save(
                            value.copyWith.detail(hypocenterDisplayMode: m),
                          );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final m in HypocenterDisplayMode.values)
                        RadioListTile<HypocenterDisplayMode>.adaptive(
                          title: Text(switch (m) {
                            HypocenterDisplayMode.zoomFade => 'ズームインで半透明',
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

                // 塗りつぶし表示モード
                const _SectionHeader(title: '塗りつぶし'),
                RadioGroup<EarthquakeHistoryFillMode>(
                  groupValue: value.detail.fillMode,
                  onChanged: (m) async {
                    if (m != null) {
                      await notifier.save(
                        value.copyWith.detail(fillMode: m),
                      );
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final m in EarthquakeHistoryFillMode.values)
                        RadioListTile<EarthquakeHistoryFillMode>.adaptive(
                          title: Text(switch (m) {
                            EarthquakeHistoryFillMode.none => 'なし',
                            EarthquakeHistoryFillMode.auto => '自動（地域→市区町村）',
                            EarthquakeHistoryFillMode.region => '細分化地域のみ',
                            EarthquakeHistoryFillMode.city => '市区町村のみ',
                          }),
                          value: m,
                        ),
                    ],
                  ),
                ),

                // 観測点の表示
                const _SectionHeader(title: '観測点の表示'),
                AppSwitchListTile(
                  title: '観測点を表示',
                  value: value.detail.showStation,
                  onChanged: (v) async => notifier.save(
                    value.copyWith.detail(showStation: v),
                  ),
                ),
                if (value.detail.showStation) ...[
                  const _SectionHeader(title: '観測点の表示方法'),
                  RadioGroup<StationDisplayMode>(
                    groupValue: value.detail.stationDisplayMode,
                    onChanged: (m) async {
                      if (m != null) {
                        await notifier.save(
                          value.copyWith.detail(stationDisplayMode: m),
                        );
                      }
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (final m in StationDisplayMode.values)
                          RadioListTile<StationDisplayMode>.adaptive(
                            title: Text(switch (m) {
                              StationDisplayMode.maxFocused => '最大震度観測点を強調',
                              StationDisplayMode.normal => '通常（全観測点同サイズ）',
                              StationDisplayMode.allMinimized => '全観測点を縮小',
                            }),
                            value: m,
                          ),
                      ],
                    ),
                  ),
                  AppSwitchListTile(
                    title: '観測点名を表示',
                    value: value.detail.showStationLabel,
                    onChanged: (v) async => notifier.save(
                      value.copyWith.detail(showStationLabel: v),
                    ),
                  ),
                ],

                // その他のトグル
                const _SectionHeader(title: 'その他'),
                AppSwitchListTile(
                  title: '震央の誤差矩形を表示',
                  value: value.detail.showHypocenterError,
                  onChanged: (v) async => notifier.save(
                    value.copyWith.detail(showHypocenterError: v),
                  ),
                ),
                AppSwitchListTile(
                  title: '震度凡例を表示',
                  value: value.detail.showLegend,
                  onChanged: (v) async => notifier.save(
                    value.copyWith.detail(showLegend: v),
                  ),
                ),
                if (hasLpgmIntensity)
                  AppSwitchListTile(
                    title: '長周期地震動階級モード',
                    value: value.detail.showingLpgmIntensity,
                    onChanged: (v) async => notifier.save(
                      value.copyWith.detail(showingLpgmIntensity: v),
                    ),
                  ),

                // 推計震度
                if (hasTileUrl) ...[
                  const _SectionHeader(title: '推計震度'),
                  AppSwitchListTile(
                    title: '推計震度データがある場合に自動で推計震度表示',
                    value: value.detail.useEstimatedIntensityWhenAvailable,
                    onChanged: (v) async => notifier.save(
                      value.copyWith.detail(
                        useEstimatedIntensityWhenAvailable: v,
                      ),
                    ),
                  ),
                ],

                // ズームレベル閾値
                _ZoomThresholdsSection(
                  thresholds: value.detail.zoomThresholds,
                  onChanged: (t) async => notifier.save(
                    value.copyWith.detail(zoomThresholds: t),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.paddingOf(context).bottom,
                ),
              ],
            ),
          ),
        };
      },
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

class _ZoomThresholdsSection extends StatelessWidget {
  const _ZoomThresholdsSection({
    required this.thresholds,
    required this.onChanged,
  });

  final EarthquakeHistoryMapLayerZoomThresholds thresholds;
  final ValueChanged<EarthquakeHistoryMapLayerZoomThresholds> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _SectionHeader(title: 'ズームレベル閾値'),
        _ZoomSliderTile(
          label: '地域→市区町村 切替',
          value: thresholds.regionToCity,
          onChanged: (v) => onChanged(thresholds.copyWith(regionToCity: v)),
        ),
        _ZoomSliderTile(
          label: '観測点 表示開始',
          value: thresholds.stationMinZoom,
          onChanged: (v) => onChanged(thresholds.copyWith(stationMinZoom: v)),
        ),
        _ZoomSliderTile(
          label: '観測点名 表示開始',
          value: thresholds.stationLabelMinZoom,
          onChanged: (v) =>
              onChanged(thresholds.copyWith(stationLabelMinZoom: v)),
        ),
        _ZoomSliderTile(
          label: '震央マーク 半透明化',
          value: thresholds.hypocenterFadeZoom,
          onChanged: (v) =>
              onChanged(thresholds.copyWith(hypocenterFadeZoom: v)),
        ),
        _ZoomSliderTile(
          label: '震央誤差矩形 表示開始',
          value: thresholds.hypocenterErrorMinZoom,
          onChanged: (v) =>
              onChanged(thresholds.copyWith(hypocenterErrorMinZoom: v)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => onChanged(
                const EarthquakeHistoryMapLayerZoomThresholds(),
              ),
              child: const Text('デフォルトに戻す'),
            ),
          ),
        ),
      ],
    );
  }
}

class _ZoomSliderTile extends StatelessWidget {
  const _ZoomSliderTile({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(label, style: theme.textTheme.bodySmall),
          ),
          Expanded(
            child: Slider(
              value: value,
              min: 3,
              max: 15,
              divisions: 24,
              label: value.toStringAsFixed(1),
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 36,
            child: Text(
              value.toStringAsFixed(1),
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
