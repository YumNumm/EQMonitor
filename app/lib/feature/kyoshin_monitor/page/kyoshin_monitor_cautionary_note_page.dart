import 'package:collection/collection.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sheet/route.dart';

class KyoshinMonitorCautionaryNoteModalRoute extends GoRouteData {
  const KyoshinMonitorCautionaryNoteModalRoute();

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return const CupertinoSheetPage<bool>(
      child: _Page(),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page();

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return CupertinoPageScaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: theme.barBackgroundColor,
        middle: const Text(
          '強震モニタについて',
          style: TextStyle(),
        ),
        trailing: TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('キャンセル'),
        ),
        automaticallyImplyLeading: false,
      ),
      child: const KyoshinMonitorCautionaryNoteList(),
    );
  }
}

class KyoshinMonitorCautionaryNoteList extends StatelessWidget {
  const KyoshinMonitorCautionaryNoteList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '強震モニタの利用にあたって、以下の点に注意してください。',
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          ...[
            (
              '防災科研へ本アプリに関する問い合わせを行わないでください',
              '本アプリは防災科研とは無関係に開発しています。\n'
                  '防災科研に不具合や意見を送信することは迷惑となりますので、行わないでください。',
            ),
            (
              '強震モニタは防災科研により提供されています',
              '強震モニタは、国立研究開発法人防災科学技術研究所が運用・提供しています。',
            ),
            (
              '事前の予告なしに提供が停止される場合があります',
              '防災科研の都合により、事前の予告なしに提供が終了する場合があります。\n'
                  'あらかじめご了承ください',
            ),
            (
              '強震モニタは、揺れの様子を直感的に捉えることを目的としています',
              '強震モニタではリアルタイムで観測値を処理しているため、ノイズや障害により観測値が変動する可能性があります'
            ),
          ].mapIndexed(
            (index, e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                                fontFamily: FontFamily.jetBrainsMono,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            e.$1,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (e.$2.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.only(left: 36),
                        child: Text(
                          e.$2,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () => context.pop(true),
                    child: const Text('同意して有効化'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
