import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

const _notices = <({String title, String body})>[
  (
    title: '緊急地震速報ではありません',
    body:
        '揺れ検知は、観測点で揺れを検知したことをお知らせする機能です。'
        '気象庁が発表する緊急地震速報（警報・予報）や震度速報とは異なり、'
        'これから到達する揺れの予想や、震源・規模を示すものではありません。',
  ),
  (
    title: '防災科研へのお問い合わせはご遠慮ください',
    body:
        '揺れ検知は、強震モニタを提供する国立研究開発法人防災科学技術研究所（防災科研）の'
        'システムとは完全に別に、EQMonitorが独自に運用しています。'
        '防災科研は本機能の運用に関与していません。'
        '本機能に関するお問い合わせ、不具合の報告、ご意見を防災科研に送ることはおやめください。'
        'お問い合わせは、設定の「問い合わせ」からお願いします。',
  ),
  (
    title: '誤検知・検知漏れがあります',
    body:
        '地震以外の振動、観測機器や通信の不具合により、'
        '地震が発生していなくても検知することがあります。'
        '反対に、地震が発生しても検知しない、または検知が遅れることがあります。',
  ),
  (
    title: '実際の揺れと一致しないことがあります',
    body:
        '表示される揺れの強さは観測点での値にもとづくもので、'
        'お住まいの場所の揺れや、後に発表される震度とは異なる場合があります。'
        '観測点のない地域の揺れは検知できません。',
  ),
  (
    title: '防災上の判断には公式の情報を使用してください',
    body:
        '避難などの判断には、気象庁や自治体が発表する情報を必ず確認してください。'
        '揺れ検知のみに依存した利用はしないでください。',
  ),
  (
    title: 'Beta機能です',
    body:
        '検知の基準、表示内容、仕様は予告なく変更することがあります。'
        'また、提供を一時停止または終了することがあります。',
  ),
  (
    title: '免責',
    body:
        '本機能の利用または利用できなかったことにより生じた損害について、'
        'EQMonitorの開発者は責任を負いかねます。',
  ),
];

class ShakeDetectionNoticeDialog extends HookWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final isAgreed = useState(false);
    final designSystem = context.designSystem;
    final colorTheme = designSystem.colorTheme;
    final spacing = designSystem.spacing;
    final typography = designSystem.typography;
    final bodyStyle = typography.bodyMedium.copyWith(
      color: colorTheme.onSurfaceVariant,
    );

    return AlertDialog(
      scrollable: true,
      title: const Text('揺れ検知（Beta）を有効にしますか？'),
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          Text(
            '揺れ検知は、Proプラン向けに試験提供している機能です。'
            '有効にする前に、以下の内容をご確認ください。',
            style: bodyStyle,
          ),
          for (final (index, notice) in _notices.indexed) ...[
            SizedBox(height: spacing.lg),
            Text(
              '${index + 1}. ${notice.title}',
              style: typography.titleSmall.copyWith(
                color: colorTheme.onSurface,
              ),
            ),
            SizedBox(height: spacing.xs),
            Text(notice.body, style: bodyStyle),
          ],
          SizedBox(height: spacing.lg),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: .leading,
            title: const Text('上記の注意事項を確認し、同意します'),
            value: isAgreed.value,
            onChanged: (value) => isAgreed.value = value ?? false,
          ),
        ],
      ),
      actions: [
        M3ETextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('キャンセル'),
        ),
        M3EFilledButton(
          onPressed: isAgreed.value
              ? () => Navigator.of(context).pop(true)
              : null,
          child: const Text('同意して有効にする'),
        ),
      ],
    );
  }
}
