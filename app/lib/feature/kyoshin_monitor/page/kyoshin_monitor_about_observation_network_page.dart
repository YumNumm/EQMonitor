import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher_string.dart';

class KyoshinMonitorAboutObservationNetworkRoute extends GoRouteData {
  const KyoshinMonitorAboutObservationNetworkRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const KyoshinMonitorAboutObservationNetworkPage();
  }
}

class KyoshinMonitorAboutObservationNetworkPage extends StatelessWidget {
  const KyoshinMonitorAboutObservationNetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: const Text('MOWLASについて')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Card(
                  color: colorScheme.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _ObservationNetworkSection(
                      title: 'MOWLAS (陸海統合地震津波火山観測網)',
                      description: const [
                        '防災科学技術研究所が運用する、全国の陸域から海域までを網羅する観測網です',
                        '阪神・淡路大震災を契機として、陸域での地震観測網(Hi-net, K-NET, KiK-net, F-net)の整備・運用を開始しました',
                        '東日本大震災後には、海域での観測網(S-net, DONET)も整備されました',
                        '2017年11月より本格的な統合運用が開始され、「MOWLAS: モウラス」(Monitoring of Waves on Land and Seafloor: 陸海統合地震津波火山観測網)と名付けられました',
                      ],
                      url: 'https://www.mowlas.bosai.go.jp/mowlas/',
                      titleColor: colorScheme.onSecondaryContainer,
                      descriptionColor: colorScheme.onSecondaryContainer
                          .withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const Divider(),
                const _ObservationNetworkSection(
                  title: 'K-NET (Kyoshin Network 全国強震観測網)',
                  description: [
                    '1995年兵庫県南部地震を契機に、全国約1,000ヶ所に設置された強震観測網です',
                    '観測点は約20km間隔で全国を均一にカバーしています',
                    '地表に設置された強震計で地震動を観測します',
                    '観測データは、地震防災・耐震設計・地震調査研究などに活用されています',
                    '強震モニタでは、地表を選択することで、K-NETの観測点を表示することができます',
                  ],
                  url: 'https://www.kyoshin.bosai.go.jp/kyoshin/',
                ),
                const _ObservationNetworkSection(
                  title: 'KiK-net (Kiban Kyoshin Network 基盤強震観測網)',
                  description: [
                    '全国約700ヶ所に設置されています',
                    '各観測点では地表と地中の両方に強震計を設置し、地震動を観測します',
                    'Hi-net(高感度地震観測網)の観測施設に併設されています',
                    '強震モニタでは、地中を選択することで、KiK-netの観測点を表示することができます',
                  ],
                  url: 'https://www.kyoshin.bosai.go.jp/kyoshin/',
                ),
                const Divider(),
                const _ObservationNetworkSection(
                  title:
                      'Hi-net (High Sensitivity Seismograph Network Japan 高感度地震観測網)',
                  description: [
                    '約20km間隔で全国約800ヶ所に設置された高感度地震計による観測網です',
                    '人が感じることができないほどの微弱な揺れを正確に記録します',
                    '地震計はノイズを避けた深さ100〜3,500mの井戸の底に設置されています',
                    '地震の発生位置の推定(震源決定)などに用いられます',
                  ],
                  url: 'https://www.hinet.bosai.go.jp/',
                ),
                const _ObservationNetworkSection(
                  title:
                      'F-net (Full Range Seismograph Network of Japan 広帯域地震観測網)',
                  description: [
                    '約100km間隔で全国約70ヶ所に設置された広帯域地震計による観測網です',
                    '地震の規模(マグニチュード)や発生メカニズムの解明に活用されています',
                    '周期100秒を超える長周期の地震動から、1秒以下の短周期の地震動まで観測可能です',
                  ],
                  url: 'https://www.fnet.bosai.go.jp/',
                ),
                const _ObservationNetworkSection(
                  title:
                      'V-net (The Fundamental Volcano Observation Network 基盤的火山観測網)',
                  description: [
                    '16の活火山に設置された基盤的火山観測網です',
                    '広帯域地震計、傾斜計、GPS等の観測装置により火山活動を監視しています',
                  ],
                  url: 'https://www.vnet.bosai.go.jp/',
                ),
                const _ObservationNetworkSection(
                  title:
                      'S-net (Seafloor observation network for earthquakes and tsunamis along the Japan Trench 日本海溝海底地震津波観測網)',
                  description: [
                    '東日本大震災を受けて整備された海底地震津波観測網です',
                    '北海道沖から房総半島沖までの海底に150点の観測装置を設置しています',
                    '地震計や水圧計のデータを光海底ケーブルでリアルタイムに伝送します',
                  ],
                  url: 'https://www.seafloor.bosai.go.jp/',
                ),
                const _ObservationNetworkSection(
                  title:
                      'DONET (Dense Oceanfloor Network system for Earthquakes and Tsunamis 地震・津波観測監視システム)',
                  description: [
                    '南海トラフの地震・津波を観測する海底観測網です',
                    '熊野灘と紀伊水道沖に計51ヶ所の観測点があります',
                    '強震計、広帯域地震計、水圧計など多種類のセンサーを備えています',
                    '2016年4月に海洋研究開発機構から防災科研に移管されました',
                  ],
                  url: 'https://www.seafloor.bosai.go.jp/',
                ),
                const _ObservationNetworkSection(
                  title:
                      'N-net (Nankai Trough Observation Network system for Earthquakes and Tsunamis 南海トラフ海底地震津波観測網)',
                  description: [
                    '高知県沖から日向灘にかけて整備中の海底観測網です',
                    '36点の観測装置を設置する計画で、18点は既に整備完了しています',
                    'S-netとDONETの特徴を組み合わせたハイブリッド方式を採用しています',
                    '地震動は最大20秒程度、津波は最大20分程度早く直接検知できるようになります',
                  ],
                  url: 'https://www.seafloor.bosai.go.jp/',
                ),
                Text(
                  '関連リンク',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _LinkItem(
                          title: '地震の基礎知識とその観測 - NIED',
                          url:
                              'https://www.hinet.bosai.go.jp/about_earthquake/',
                        ),
                        _LinkItem(
                          title: 'シリーズ「新・強震観測の最新情報」',
                          url:
                              'https://www.zisin.jp/kyosindo/shin_kansoku/shin_kansoku.html',
                        ),
                      ],
                    ),
                  ),
                ),
                const Text('※上記内容は2025年2月現在の情報です。最新の情報は各公式サイトをご確認ください。'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ObservationNetworkSection extends StatelessWidget {
  const _ObservationNetworkSection({
    required this.title,
    required this.description,
    this.url,
    this.titleColor,
    this.descriptionColor,
  });

  final String title;
  final List<String> description;
  final String? url;
  final Color? titleColor;
  final Color? descriptionColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: url != null ? () async => launchUrlString(url!) : null,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: titleColor,
                  ),
                ),
              ),
              if (url != null)
                Icon(Icons.open_in_new, size: 16, color: colorScheme.primary),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description.map((e) => '・$e').join('\n'),
          style: textTheme.bodyMedium?.copyWith(
            color:
                descriptionColor ??
                colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _LinkItem extends StatelessWidget {
  const _LinkItem({required this.title, required this.url});

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () async => launchUrlString(url),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(color: colorScheme.primary)),
          ),
          Icon(Icons.open_in_new, size: 16, color: colorScheme.primary),
        ],
      ),
    );
  }
}
