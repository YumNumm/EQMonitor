import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:eqmonitor/core/component/widget/kmoni_caution.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              color: theme.colorScheme.primaryContainer,
              child: SwitchListTile.adaptive(
                value: state.useKmoni,
                onChanged: (value) async {
                  if (value) {
                    final result = await showOkCancelAlertDialog(
                      context: context,
                      title: '強震モニタの注意',
                      message: '強震モニタを有効すると、'
                          '強震モニタの注意点に同意したものとみなします。',
                      okLabel: '同意する',
                      cancelLabel: 'キャンセル',
                    );
                    final isAccepted = result == OkCancelResult.ok;

                    if (isAccepted) {
                      ref.read(kmoniSettingsProvider.notifier).toggleUseKmoni();
                    }
                    return;
                  }
                  ref.read(kmoniSettingsProvider.notifier).toggleUseKmoni();
                },
                title: const Text('強震モニタを表示する'),
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SheetHeader(title: '強震モニタの注意点'),
                  KmoniCautionWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
