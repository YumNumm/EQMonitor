import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/app_group/app_group_values_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/app_group/debug_app_group_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugAppGroupPage extends HookConsumerWidget {
  const DebugAppGroupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(appGroupValuesProvider);
    final action = ref.watch(debugAppGroupActionProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('App Groups UserDefaults'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            tooltip: 'プロバイダから再同期',
            onPressed: () => action.syncFromProvider(ref, context),
          ),
        ],
      ),
      body: switch (values) {
        AsyncLoading() => const Center(child: CircularProgressIndicator()),
        AsyncError(:final error) => Center(child: Text('エラー: $error')),
        AsyncData(:final value) => _Body(values: value, action: action),
      },
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.values, required this.action});

  final AppGroupValues values;
  final DebugAppGroupAction action;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        const _SectionHeader('Widget 設定（group.net.yumnumm.eqmonitor）'),
        ListTile(
          leading: const Icon(Icons.http),
          title: const Text('apiServerUrl'),
          subtitle: Text(
            values.apiServerUrl ?? '(未設定)',
            style: const TextStyle(fontFamily: FontFamily.googleSansCode),
          ),
          trailing: switch (values.apiServerUrl) {
            final url? => IconButton(
              icon: const Icon(Icons.copy),
              tooltip: 'コピー',
              onPressed: () => Clipboard.setData(ClipboardData(text: url)),
            ),
            null => null,
          },
          onTap: () => action.editApiServerUrl(ref, context),
        ),
        AppSwitchListTile(
          title: 'debugMode',
          subtitle: values.debugMode?.toString() ?? '(未設定)',
          value: values.debugMode ?? false,
          onChanged: (v) => action.setDebugMode(ref, value: v),
        ),
        const Divider(),
        const ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('Widget への反映について'),
          subtitle: Text(
            '変更はウィジェットの次回タイムライン更新時に反映されます。'
            '「再同期」ボタンでアプリ側プロバイダの値を App Groups に書き直します。',
          ),
          isThreeLine: true,
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: context.designSystem.colorTheme.primary,
        ),
      ),
    );
  }
}
