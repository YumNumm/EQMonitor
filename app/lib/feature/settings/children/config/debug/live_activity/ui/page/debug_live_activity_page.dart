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
import 'package:eqmonitor/feature/shake_detection/data/model/shake_detection_event.dart';
import 'package:eqmonitor/feature/shake_detection/data/provider/shake_detection_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

/// デバッグ用。アプリ内から ActivityKit を用いて EEW / 揺れ検知の
/// Live Activity をローカル開始・更新・終了し、表示を検証する。
class DebugLiveActivityPage extends HookConsumerWidget {
  const DebugLiveActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final kind = useState(DebugLiveActivityKind.eew);
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
          Text('種別', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          SegmentedButton<DebugLiveActivityKind>(
            segments: [
              for (final value in DebugLiveActivityKind.values)
                ButtonSegment(value: value, label: Text(value.label)),
            ],
            selected: {kind.value},
            onSelectionChanged: isBusy.value
                ? null
                : (selected) {
                    kind.value = selected.first;
                    session.value = null;
                    activityIdController.clear();
                    jsonController.clear();
                  },
          ),
          const SizedBox(height: 24),
          Text('プリセット', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _PresetChips(
            kind: kind.value,
            onEewPreset: (preset) => fill(
              builder.eewFromPreset(
                preset: preset,
                eventId: _generateEventId(ref, 'eew'),
                now: ref.read(appClockProvider.notifier).now(),
              ),
            ),
            onShakePreset: (preset) => fill(
              builder.shakeFromPreset(
                preset: preset,
                eventId: _generateEventId(ref, 'shake'),
                now: ref.read(appClockProvider.notifier).now(),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('実データから読み込み', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _RealDataSection(
            kind: kind.value,
            onEewSelected: (eew) => fill(builder.eewFromTelegram(eew)),
            onShakeSelected: (event) => fill(builder.shakeFromEvent(event)),
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
                          kind: kind.value,
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
                          kind: kind.value,
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
                          kind: kind.value,
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
          if (session.value case final current?)
            _SessionCard(session: current),
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
  const _PresetChips({
    required this.kind,
    required this.onEewPreset,
    required this.onShakePreset,
  });

  final DebugLiveActivityKind kind;
  final ValueChanged<DebugEewPreset> onEewPreset;
  final ValueChanged<DebugShakePreset> onShakePreset;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: switch (kind) {
        DebugLiveActivityKind.eew => [
          for (final preset in DebugEewPreset.values)
            ActionChip(
              label: Text(preset.label),
              onPressed: () => onEewPreset(preset),
            ),
        ],
        DebugLiveActivityKind.shakeDetection => [
          for (final preset in DebugShakePreset.values)
            ActionChip(
              label: Text(preset.label),
              onPressed: () => onShakePreset(preset),
            ),
        ],
      },
    );
  }
}

class _RealDataSection extends ConsumerWidget {
  const _RealDataSection({
    required this.kind,
    required this.onEewSelected,
    required this.onShakeSelected,
  });

  final DebugLiveActivityKind kind;
  final ValueChanged<EewTelegramItem> onEewSelected;
  final ValueChanged<ShakeDetectionEvent> onShakeSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (kind) {
      DebugLiveActivityKind.eew => _buildEew(context, ref),
      DebugLiveActivityKind.shakeDetection => _buildShake(context, ref),
    };
  }

  Widget _buildEew(BuildContext context, WidgetRef ref) {
    final eews = ref.watch(eewAliveTelegramProvider) ?? const <EewTelegramItem>[];
    if (eews.isEmpty) {
      return const Text('発表中の EEW はありません');
    }
    return Column(
      children: [
        for (final eew in eews)
          ListTile(
            dense: true,
            title: Text('${eew.hypocenter?.name ?? eew.headline ?? '(不明)'} '
                '第${eew.serialNo}報'),
            subtitle: Text(eew.eventId),
            trailing: const Icon(Icons.download),
            onTap: () => onEewSelected(eew),
          ),
      ],
    );
  }

  Widget _buildShake(BuildContext context, WidgetRef ref) {
    final events = ref.watch(shakeDetectionProvider);
    if (events.isEmpty) {
      return const Text('進行中の揺れ検知はありません');
    }
    return Column(
      children: [
        for (final event in events)
          ListTile(
            dense: true,
            title: Text('${event.level.name} 第${event.serialNo}報'),
            subtitle: Text(event.eventId),
            trailing: const Icon(Icons.download),
            onTap: () => onShakeSelected(event),
          ),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

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
  const _SupportabilityTile();

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
