import 'package:eqmonitor/feature/tsunami/data/model/tsunami_telegram_meta.dart';
import 'package:flutter/material.dart';

/// 横スクロールタイムライン行コンポーネント。
///
/// [label] を固定左カラムとして表示し、[telegrams] の各電文に対して
/// [cellBuilder] が返す文字列を横並びのセルとして表示する。
class TsunamiTimelineRow extends StatelessWidget {
  const TsunamiTimelineRow({
    required this.label,
    required this.telegrams,
    required this.cellBuilder,
    super.key,
  });

  final String label;
  final List<TsunamiTelegramMeta> telegrams;

  /// telegramId に対するセル表示文字列を返すコールバック。
  /// 変化なし (値なし) の場合は null を返す → "—" を表示。
  final String? Function(String telegramId) cellBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              label,
              style: theme.textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final t in telegrams)
                  Container(
                    width: 140,
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.dividerColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      cellBuilder(t.telegramId) ?? '—',
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
