import 'dart:async';

import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_config_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EarthquakeHistoryMapDisplayModeModal extends ConsumerWidget {
  const EarthquakeHistoryMapDisplayModeModal._({
    required this.hasLpgmIntensity,
    required this.isOverriding,
    this.onDisableOverride,
  });

  final bool hasLpgmIntensity;
  final bool isOverriding;
  final VoidCallback? onDisableOverride;

  /// 地図の表示設定モーダル
  ///
  /// 表示モード・観測点サブモード・震央設定・LPGM 等を変更する。
  /// [isOverriding] が true のとき、推計震度 override が有効であることを表示する。
  /// [onDisableOverride] は override を無効にして設定を反映させたいときに呼ばれる。
  static Future<void> show({
    required BuildContext context,
    required bool hasLpgmIntensity,
    bool isOverriding = false,
    VoidCallback? onDisableOverride,
  }) => showModalBottomSheet(
    context: context,
    clipBehavior: Clip.antiAlias,
    isScrollControlled: true,
    builder: (context) => EarthquakeHistoryMapDisplayModeModal._(
      hasLpgmIntensity: hasLpgmIntensity,
      isOverriding: isOverriding,
      onDisableOverride: onDisableOverride,
    ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(
      earthquakeHistoryConfigProvider,
    );
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
            child: SafeArea(
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
                    title: '観測点名を表示',
                    value: value.detail.showStationLabel,
                    onChanged: (v) async => notifier.save(
                      value.copyWith.detail(showStationLabel: v),
                    ),
                  ),
                  AppSwitchListTile(
                    title: '観測点に震度アイコンを表示',
                    value: value.detail.showIntensityIcon,
                    onChanged: (v) async => notifier.save(
                      value.copyWith.detail(showIntensityIcon: v),
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
                  if (isOverriding)
                    AppSwitchListTile(
                      title: '推計震度データがある場合に自動で推計震度表示',
                      value: value.detail.useEstimatedIntensityWhenAvailable,
                      onChanged: (v) async {
                        await notifier.save(
                          value.copyWith.detail(
                            useEstimatedIntensityWhenAvailable: v,
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
