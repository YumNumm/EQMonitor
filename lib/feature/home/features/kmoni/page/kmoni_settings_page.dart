import 'package:eqmonitor/core/component/widget/kmoni_caution.dart';
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
              subtitle: const KmoniCautionWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
