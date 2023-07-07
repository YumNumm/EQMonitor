import 'package:eqmonitor/feature/home/features/kmoni/viewmodel/kmoni_view_settings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniSettingsPage extends ConsumerWidget {
  const KmoniSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kmoniSettingsProvider);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('強震モニタ設定'),
      ),
      body: Column(
        children: [
          Card(
            elevation: 0,
            color: theme.colorScheme.primaryContainer,
            child: SwitchListTile.adaptive(
              value: state.useKmoni,
              onChanged: (_) =>
                  ref.read(kmoniSettingsProvider.notifier).toggleUseKmoni(),
              title: const Text('強震モニタを表示する'),
            ),
          ),
          const SizedBox(height: 8),
          const Divider(),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: theme.colorScheme.onPrimaryContainer,
                width: 0,
              ),
            ),
            child: ListTile(
              title: Text(
                '強震モニタ利用に関わる注意事項',
                style: theme.textTheme.titleMedium,
              ),
              subtitle: Column(
                children: [
                  (
                    '強震モニタは防災科研により提供されています',
                    '強震モニタは、国立研究開発法人防災科学技術研究所が運用・提供しています。',
                  ),
                  (
                    '防災科研へ本アプリに関する問い合わせを行わないでください',
                    '本アプリは防災科研とは無関係に開発しております。\n'
                        '防災科研に不具合や意見を送信することは迷惑となりますので、行わないでください。',
                  ),
                  (
                    '事前の予告なしに提供が停止される場合があります',
                    '防災科研の都合により、事前の予告なしに提供が終了する場合があります。\n'
                        'あらかじめご了承ください',
                  )
                ]
                    .map(
                      (e) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Flexible(
                                child: Text(
                                  e.$1,
                                  style: theme.textTheme.titleSmall,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 16),
                              Flexible(
                                child: Text(
                                  e.$2,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
