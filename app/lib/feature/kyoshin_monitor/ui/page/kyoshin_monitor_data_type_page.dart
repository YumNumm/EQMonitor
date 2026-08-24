import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class KyoshinMonitorDataTypePage extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('強震モニタのデータ種別について')),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: const [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DataTypeInfo(
                          title: 'リアルタイム震度',
                          description: '''
防災科研が独自に開発した逐次的に計算される目安の震度を表示します。
本来揺れが収まった後に計算されて発表される「震度」にほぼ一致する特徴があります。''',
                        ),
                        _DataTypeInfo(
                          title: '最大加速度 (PGA)',
                          description: '''
強震計が実際に観測している揺れの加速度の直近1秒間の最大値を表示します。
3方向（北―南、東―西、上―下）をベクトル合成した波形の最大値となります。''',
                        ),
                        _DataTypeInfo(
                          title: '最大速度 (PGV)',
                          description: '揺れの加速度を積分して得られる速度の1秒毎の最大値を表示します。',
                        ),
                        _DataTypeInfo(
                          title: '最大変位 (PGD)',
                          description: '揺れの加速度を2回積分して得られる変位の1秒毎の最大値を表示します。',
                        ),
                        _DataTypeInfo(
                          title: '速度応答（0.125、0.25、0.5、1.0、2.0、4.0Hz）',
                          description: '''
各周波数成分についての速度応答波形（減衰5%）の1秒毎の最大値を表示します。
低い周波数（0.125 Hz側）はゆっくりとした揺れの、高い周波数（4.0 Hz側）は速い揺れの強さを示します。''',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: _KyoshinMonitorSource(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KyoshinMonitorSource extends StatelessWidget {
  const new();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final textTheme = theme.textTheme;

    final hyperLinkColor = designSystem.colorTheme.primary;

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: '上記説明は、'),
          WidgetSpan(
            child: InkWell(
              onTap: () async => launchUrl(
                Uri.parse(
                  'https://www.kyoshin.bosai.go.jp/kyoshin/docs/new_kyoshinmonitor.shtml',
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.open_in_new, size: 12, color: hyperLinkColor),
                  Text(
                    '強震モニタについて - 防災科研',
                    style: textTheme.bodyMedium?.copyWith(
                      color: hyperLinkColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const TextSpan(text: 'から一部引用しています。'),
        ],
      ),
    );
  }
}

class _DataTypeInfo extends StatelessWidget {
  const new({
    required this.title,
    required this.description,
    this.isLast = false,
  });

  final String title;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final designSystem = context.designSystem;
    final textTheme = theme.textTheme;

    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: textTheme.bodyMedium?.copyWith(
              color: designSystem.colorTheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
