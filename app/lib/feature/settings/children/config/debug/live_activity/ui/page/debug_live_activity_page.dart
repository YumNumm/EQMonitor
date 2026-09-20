import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_kind.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_json_codec.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/ui/action/debug_live_activity_action.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// デバッグ用。アプリ内から ActivityKit を用いて EEW の
/// Live Activity をローカル開始・更新・終了し、表示を検証する。
class DebugLiveActivityPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const kind = DebugLiveActivityKind.eew;
    final jsonController = useTextEditingController();
    final activityIdController = useTextEditingController();
    final session = useState<DebugLiveActivitySession?>(null);
    final isBusy = useState(false);

    final builder = ref.watch(debugLiveActivityContentBuilderProvider);
    final codec = ref.watch(debugLiveActivityJsonCodecProvider);
    final action = ref.watch(debugLiveActivityActionProvider);

    void fill(Map<String, dynamic> contentState) =>
        jsonController.text = codec.encode(contentState);

    Future<void> run(Future<void> Function() task) async {
      if (isBusy.value) {
        return;
      }
      isBusy.value = true;
      try {
        await task();
      } finally {
        isBusy.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Live Activity テスト')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('プリセット', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _PresetChips(
            onEewPreset: (preset) => fill(
              builder.eewFromPreset(
                preset: preset,
                eventId: _generateEventId(ref, 'eew'),
                now: ref.read(appClockProvider.notifier).now(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('実データから読み込み', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _RealDataSection(
            onEewSelected: (eew) => fill(builder.eewFromTelegram(eew)),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: activityIdController,
            decoration: const InputDecoration(
              labelText: 'activityId（更新・終了に使用）',
              helperText: '開始成功時に自動入力されます',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: jsonController,
            minLines: 6,
            maxLines: 20,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
            decoration: const InputDecoration(
              labelText: 'ContentState (JSON)',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              FilledButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('開始'),
                onPressed: isBusy.value
                    ? null
                    : () => run(() async {
                        final result = await action.start(
                          ref: ref,
                          context: context,
                          kind: kind,
                          rawJson: jsonController.text,
                        );
                        if (result != null) {
                          session.value = result;
                          activityIdController.text = result.activityId;
                        }
                      }),
              ),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.refresh),
                label: const Text('更新'),
                onPressed: isBusy.value
                    ? null
                    : () => run(() async {
                        await action.update(
                          ref: ref,
                          context: context,
                          kind: kind,
                          activityId: activityIdController.text.trim(),
                          rawJson: jsonController.text,
                        );
                      }),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.stop),
                label: const Text('終了'),
                onPressed: isBusy.value
                    ? null
                    : () => run(() async {
                        final ended = await action.end(
                          ref: ref,
                          context: context,
                          kind: kind,
                          activityId: activityIdController.text.trim(),
                          rawJson: jsonController.text,
                        );
                        if (ended) {
                          session.value = null;
                        }
                      }),
              ),
            ],
          ),
          const SizedBox(height: 24),
          if (session.value case final current?) _SessionCard(session: current),
          const _SupportabilityTile(),
        ],
      ),
    );
  }

  String _generateEventId(WidgetRef ref, String prefix) {
    final now = ref.read(appClockProvider.notifier).now();
    return 'debug-$prefix-${now.millisecondsSinceEpoch}';
  }
}

class _PresetChips extends StatelessWidget {
  const new({required this.onEewPreset});

  final ValueChanged<DebugEewPreset> onEewPreset;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        for (final preset in DebugEewPreset.values)
          ActionChip(
            label: Text(preset.label),
            onPressed: () => onEewPreset(preset),
          ),
      ],
    );
  }
}

class _RealDataSection extends ConsumerWidget {
  const new({required this.onEewSelected});

  final ValueChanged<EewTelegramItem> onEewSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews =
        ref.watch(eewAliveTelegramProvider) ?? const <EewTelegramItem>[];
    if (eews.isEmpty) {
      return const Text('発表中の EEW はありません');
    }
    return Column(
      children: [
        for (final eew in eews)
          ListTile(
            dense: true,
            title: Text(
              '${eew.hypocenter?.name ?? eew.headline ?? '(不明)'} '
              '第${eew.serialNo}報',
            ),
            subtitle: Text(eew.eventId),
            trailing: const Icon(Icons.download),
            onTap: () => onEewSelected(eew),
          ),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  const new({required this.session});

  final DebugLiveActivitySession session;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.bolt),
        title: Text(session.activityId),
        subtitle: Text('${session.kind.label} / ${session.eventId}'),
        trailing: const Icon(Icons.copy),
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: session.activityId));
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('activityId をコピーしました')),
            );
          }
        },
      ),
    );
  }
}

class _SupportabilityTile extends ConsumerWidget {
  const new();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(liveActivityLocalControllerProvider);
    return FutureBuilder<bool>(
      future: controller.isSupported(),
      builder: (context, snapshot) {
        final supported = snapshot.data;
        final text = switch (supported) {
          null => '対応状況を確認中...',
          true => 'この端末は Live Activity のローカル開始に対応しています',
          false => 'この端末は Live Activity のローカル開始に非対応です（iOS 16.1+ が必要）',
        };
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(text, style: Theme.of(context).textTheme.bodySmall),
        );
      },
    );
  }
}
