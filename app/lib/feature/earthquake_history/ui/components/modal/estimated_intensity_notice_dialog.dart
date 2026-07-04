import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EstimatedIntensityNoticeDialog extends StatelessWidget {
  const EstimatedIntensityNoticeDialog({super.key});

  static Future<void> show(BuildContext context) => showDialog<void>(
        context: context,
        builder: (context) => const EstimatedIntensityNoticeDialog(),
      );

  static const _jmaUrl =
      'https://www.jma.go.jp/jma/kishou/know/jishin/suikei/kaisetsu.html';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: const Text('推計震度分布図について'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _BulletText(
              '推計震度分布図で示すメッシュの震度は、'
              'それぞれの震度の矩形内が同一震度であることを示すものではなく、'
              'メッシュの境界線が震度の境界でもありません。',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            _BulletText(
              '推計震度の値は1階級程度異なる場合があります。',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            _BulletText(
              '大きな震度の面的な広がり具合やその形状に着目することが重要です。'
              '地震発生直後に応急対応すべき優先箇所の判別や'
              '避難ルート・避難場所の選定等に活用頂けます。',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'EQMonitorでは、推計震度分布図(250mメッシュ)を'
              'サーバで処理し掲載しています。',
              style: theme.textTheme.bodySmall?.copyWith(
                color: context.designSystem.colorTheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () => launchUrl(Uri.parse(_jmaUrl)),
              child: Text(
                '推計震度分布図について - 気象庁',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: context.designSystem.colorTheme.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: context.designSystem.colorTheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class _BulletText extends StatelessWidget {
  const _BulletText(this.text, {this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('・', style: style),
        Expanded(child: Text(text, style: style)),
      ],
    );
  }
}
