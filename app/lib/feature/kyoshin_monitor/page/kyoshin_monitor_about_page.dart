import 'package:eqmonitor/core/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KyoshinMonitorAboutPage extends HookConsumerWidget {
  const KyoshinMonitorAboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('強震モニタとは?')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Text(
                  '強震モニタは、防災科学技術研究所が運用する、全国を網羅する強震観測網(K-NET、KiK-net)のデータをリアルタイムに表示するシステムです。\n'
                  '日本全国の観測点の揺れの状況を青から赤までの色で表示します。',
                  style: textTheme.bodyMedium,
                ),
                _SectionTitle(title: '表示可能なデータ', style: textTheme.titleMedium),
                const _InfoCard(
                  items: [
                    _InfoItem(
                      title: 'リアルタイム震度',
                      description: '揺れが収まった後に計算されて発表される「震度」にほぼ一致する特徴があります。',
                    ),
                    _InfoItem(
                      title: '最大加速度(PGA)',
                      description: '強震計が観測している揺れの加速度の直近1秒間の最大値を示します。',
                    ),
                    _InfoItem(
                      title: '最大速度(PGV)',
                      description: '揺れの速度の1秒ごとの最大値を示します',
                    ),
                    _InfoItem(
                      title: '最大変位(PGD)',
                      description: '揺れの変位の1秒ごとの最大値を示します。',
                    ),
                    _InfoItem(
                      title: '速度応答(0.125, 0.25, 0.5, 1, 2, 4Hz)',
                      description: '各周波数成分についての速度応答波形(減衰5%)の1秒毎の最大値を表示します。',
                    ),
                  ],
                ),
                _SectionTitle(title: '観測点について', style: textTheme.titleMedium),
                _InfoCard(
                  items: const [
                    _InfoItem(
                      title: 'K-NET(地表)',
                      description: '全国約1,000ヶ所に設置された地表の強震計による観測網です。',
                    ),
                    _InfoItem(
                      title: 'KiK-net(地中)',
                      description:
                          '全国約700ヶ所に設置された地中の強震計による観測網です。地表と地中の両方で観測を行います。',
                    ),
                  ],
                  onTapMore: () async =>
                      const KyoshinMonitorAboutObservationNetworkRoute()
                          .push<void>(context),
                  tapMoreText: '日本を取り巻く観測網について',
                ),
                _SectionTitle(title: '利用上の注意', style: textTheme.titleMedium),
                const _InfoCard(
                  isWarning: true,
                  items: [
                    _InfoItem(
                      title: 'コンテンツの帰属',
                      description: '強震モニタのコンテンツは、防災科学技術研究所が著作権を有します。',
                    ),
                    _InfoItem(
                      title: '本アプリと防災科研の関係',
                      description:
                          '本アプリケーション(EQMonitor)は、防災科学技術研究所が提供する強震モニタのデータを利用していますが、防災科学技術研究所が公式に提供するアプリケーションではありません。\n'
                          '防災科研に不具合や意見を送信することは迷惑になりますのでお控えください。',
                    ),
                    _InfoItem(
                      title: 'データのノイズ',
                      description:
                          '地面は生活振動のためにわずかに揺れています。また、リアルタイムに観測データを表示しているため、ノイズや機器障害による揺れが表示されることがあります。\n'
                          'そのため、色の変化は地震以外の理由で発生することがあります。',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.style});

  final String title;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(title, style: style?.copyWith(fontWeight: FontWeight.bold)),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.items,
    this.onTapMore,
    this.isWarning = false,
    this.tapMoreText = '詳しく見る',
  });

  final List<_InfoItem> items;
  final VoidCallback? onTapMore;
  final String tapMoreText;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      color: isWarning ? colorScheme.errorContainer : null,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isWarning)
            Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  Icons.warning_rounded,
                  color: colorScheme.onErrorContainer.withValues(alpha: 0.2),
                  size: 176,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < items.length; i++) ...[
                  if (i > 0) const SizedBox(height: 8),
                  _InfoItemWidget(
                    item: items[i],
                    textColor: isWarning ? colorScheme.onErrorContainer : null,
                  ),
                ],
                if (onTapMore != null) ...[
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: onTapMore,
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(tapMoreText),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem {
  const _InfoItem({required this.title, required this.description});

  final String title;
  final String description;
}

class _InfoItemWidget extends StatelessWidget {
  const _InfoItemWidget({required this.item, this.textColor});

  final _InfoItem item;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ${item.title}',
          style: textTheme.bodyLarge?.copyWith(color: textColor),
        ),
        Text(
          item.description,
          style: textTheme.bodyMedium?.copyWith(
            color: (textColor ?? colorScheme.onSurfaceVariant).withValues(
              alpha: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
