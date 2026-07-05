import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/magnitude_text.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

/// 市区町村の詳細モーダルを表示する。
///
/// サマリ(地域名・最高震度バッジ・件数・代表地震)と
/// ページネーション付きの過去地震一覧を表示する。
Future<void> showCityDetailModal(
  BuildContext context, {
  required String cityCode,
  required String cityName,
  required String regionName,
  HighestIntensityEntry? summary,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  clipBehavior: Clip.antiAlias,
  builder: (context) => _CityDetailModal(
    cityCode: cityCode,
    cityName: cityName,
    summary: summary,
    regionName: regionName,
  ),
);

class _CityDetailModal extends ConsumerWidget {
  const _CityDetailModal({
    required this.cityCode,
    required this.cityName,
    required this.regionName,
    required this.summary,
  });

  final String cityCode;
  final String cityName;
  final String regionName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.3,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            // ドラッグハンドル
            SliverToBoxAdapter(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: context.designSystem.colorTheme.onSurface.withValues(
                      alpha: 0.3,
                    ),
                  ),
                ),
              ),
            ),
            // サマリ
            SliverToBoxAdapter(
              child: _SummarySection(
                regionName: regionName,
                cityName: cityName,
                summary: summary,
              ),
            ),
            // 区切り
            SliverToBoxAdapter(
              child: Divider(
                height: 0,
                color: context.designSystem.colorTheme.outlineVariant,
              ),
            ),
            // 一覧 or ローディング or エラー
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: Placeholder(
                  child: Center(child: Text('TODO: 一覧を表示する...')),
                ),
              ),
            ),
            // BottomPadding
            SliverToBoxAdapter(
              child: SizedBox(
                height: MediaQuery.paddingOf(context).bottom + 16,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SummarySection extends StatelessWidget {
  const _SummarySection({
    required this.regionName,
    required this.cityName,
    required this.summary,
  });

  final String regionName;
  final String cityName;
  final HighestIntensityEntry? summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormatter = DateFormat('yyyy/MM/dd HH:mm');
    final entry = summary;
    final earthquakePartial = entry?.earthquake;
    final originTime = earthquakePartial?.earthquake.originTime;
    final hypocenter = earthquakePartial?.earthquake.hypocenter;
    final magnitude = hypocenter?.magnitude;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (entry != null) ...[
                JmaIntensityIcon(
                  intensity: entry.intensity,
                  type: IntensityIconType.filled,
                  size: 40,
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  children: [
                    Text(
                      regionName,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: context.designSystem.colorTheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      cityName,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (entry != null) ...[
            const SizedBox(height: 8),
            Text(
              'この震度を観測した地震: ${entry.count}件',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.designSystem.colorTheme.onSurface,
              ),
            ),
            if (earthquakePartial != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (originTime != null)
                          Text(
                            '代表: ${dateFormatter.format(originTime.toLocal())}発生',
                            style: theme.textTheme.bodySmall,
                          ),
                        if (hypocenter != null)
                          Text(
                            hypocenter.name ?? '', // TODO: 名前がない場合のUIを決める
                            style: theme.textTheme.bodySmall,
                          ),
                      ],
                    ),
                  ),
                  if (magnitude != null) MagnitudeText(magnitude: magnitude),
                ],
              ),
            ],
          ],
        ],
      ),
    );
  }
}
