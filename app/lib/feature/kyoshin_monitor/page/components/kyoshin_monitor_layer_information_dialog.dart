import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RealtimeDataTypeInfoDialog extends StatelessWidget {
  const RealtimeDataTypeInfoDialog({super.key});

  static Future<void> show(BuildContext context) async => showDialog<void>(
    context: context,
    builder: (context) => const RealtimeDataTypeInfoDialog(),
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('強震モニタのデータ種別について'),
      content: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
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
            ),
            SizedBox(height: 8),
            _KyoshinMonitorSource(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}

class _KyoshinMonitorSource extends StatelessWidget {
  const _KyoshinMonitorSource();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final hyperLinkColor = colorScheme.primary;

    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: '上記説明は、'),
          WidgetSpan(
            child: InkWell(
              onTap:
                  () async => launchUrl(
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
                    style: textTheme.bodyMedium!.copyWith(
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
  const _DataTypeInfo({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: textTheme.bodyMedium!.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
