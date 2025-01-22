import 'dart:async';

import 'package:eqmonitor/core/component/widget/kmoni_caution.dart';
import 'package:eqmonitor/feature/home/component/kmoni/kmoni_settings_dialog.dart';
import 'package:eqmonitor/feature/home/component/sheet/sheet_header.dart';
import 'package:eqmonitor/feature/kyoshin_monitor/data/provider/kyoshin_monitor_settings.dart';
import 'package:eqmonitor/feature/setup/pages/kmoni_warn.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class KmoniSettingsPage extends ConsumerWidget {
  const KmoniSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kyoshinMonitorSettingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('強震モニタ設定'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const KmoniSettingsUseToggle(),
            const SizedBox(height: 8),
            const Divider(),
            if (state.useKmoni) const KmoniSettingsDialogInside(),
          ],
        ),
      ),
    );
  }
}

class KmoniSettingsUseToggle extends ConsumerWidget {
  const KmoniSettingsUseToggle({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(kyoshinMonitorSettingsProvider);
    final theme = Theme.of(context);
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      color: theme.colorScheme.primaryContainer,
      child: SwitchListTile.adaptive(
        value: state.useKmoni,
        onChanged: (value) async {
          if (value) {
            final barWidget = Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 36,
              height: 4,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: theme.colorScheme.onSurface,
                boxShadow: const <BoxShadow>[
                  BoxShadow(color: Colors.black12, blurRadius: 12),
                ],
              ),
            );
            final result = await showModalBottomSheet<bool>(
              context: context,
              isScrollControlled: true,
              builder: (context) => SafeArea(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.8,
                  child: Column(
                    children: [
                      barWidget,
                      const Expanded(
                        child: SingleChildScrollView(
                          child: SafeArea(
                            child: Column(
                              children: [
                                SheetHeader(title: '強震モニタの注意点'),
                                KmoniCautionWidget(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      UseKmoniButton(
                        onDisabled: () => Navigator.of(context).pop(false),
                        onEnabled: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                ),
              ),
            );
            final isAccepted = result != null && result;

            if (isAccepted) {
              unawaited(
                ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                      state.copyWith(useKmoni: value),
                    ),
              );
            }
            return;
          } else {
            unawaited(
              ref.read(kyoshinMonitorSettingsProvider.notifier).save(
                    state.copyWith(useKmoni: value),
                  ),
            );
          }
        },
        title: const Text('強震モニタを表示する'),
      ),
    );
  }
}
