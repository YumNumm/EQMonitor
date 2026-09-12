import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/app_lifecycle.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_json_codec.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/ui/action/debug_live_activity_action.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

class DebugLiveActivityPage extends HookConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final builder = ref.watch(debugLiveActivityContentBuilderProvider);
    final codec = ref.watch(debugLiveActivityJsonCodecProvider);
    final action = ref.watch(debugLiveActivityActionProvider);
    final controller = ref.watch(liveActivityLocalControllerProvider);
    final initialNow = useMemoized(
      () => ref.read(appClockProvider.notifier).now(),
      const [],
    );
    final logicalId = useState(debugLiveActivityLogicalId(initialNow));
    final selectedPreset = useState(DebugUnifiedPreset.shake);
    final initialJson = useMemoized(
      () => codec.encode(
        builder.unifiedFromPreset(
          preset: selectedPreset.value,
          id: logicalId.value,
          now: initialNow,
        ),
      ),
      const [],
    );
    final jsonController = useTextEditingController(text: initialJson);
    final activityIdController = useTextEditingController();
    final selectedSession = useState<DebugLiveActivitySession?>(null);
    final isBusy = useState(false);
    final refreshVersion = useState(0);
    final latestListRequest = useRef(0);
    final supportFuture = useMemoized(controller.isSupported, [controller]);
    final support = useFuture(supportFuture);
    final sessionsFuture = useMemoized(
      () async {
        final request = ++latestListRequest.value;
        final activityIdAtRequest = activityIdController.text;
        final loaded = await controller.list();
        if (!context.mounted ||
            request != latestListRequest.value ||
            activityIdAtRequest != activityIdController.text) {
          return loaded;
        }
        final selectedActivityId = activityIdController.text;
        if (selectedActivityId.isEmpty) {
          return loaded;
        }
        DebugLiveActivitySession? restored;
        for (final session in loaded) {
          if (session.activityId == selectedActivityId) {
            restored = session;
            break;
          }
        }
        selectedSession.value = restored;
        if (restored == null) {
          activityIdController.clear();
        } else {
          logicalId.value = restored.logicalId;
        }
        return loaded;
      },
      [controller, refreshVersion.value],
    );
    final sessions = useFuture(sessionsFuture);
    ref.listen(appLifecycleProvider, (previous, next) {
      if (next == AppLifecycleState.resumed &&
          previous != AppLifecycleState.resumed &&
          !isBusy.value) {
        refreshVersion.value++;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Live Activity テスト')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _LogicalIdCard(
            logicalId: logicalId.value,
            enabled: !isBusy.value,
            onNewSequence: () {
              final now = ref.read(appClockProvider.notifier).now();
              final nextId = debugLiveActivityLogicalId(now);
              logicalId.value = nextId;
              selectedSession.value = null;
              activityIdController.clear();
              jsonController.text = codec.encode(
                builder.unifiedFromPreset(
                  preset: selectedPreset.value,
                  id: nextId,
                  now: now,
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Text('プリセット', style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 8),
          _PresetChips(
            selected: selectedPreset.value,
            enabled: !isBusy.value,
            onSelected: (preset) {
              selectedPreset.value = preset;
              jsonController.text = codec.encode(
                builder.unifiedFromPreset(
                  preset: preset,
                  id: logicalId.value,
                  now: ref.read(appClockProvider.notifier).now(),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          TextField(
            controller: activityIdController,
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'OS activityId（更新・終了に使用）',
              helperText: '開始成功または実行中一覧からの選択で設定されます',
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
                    : () async {
                        isBusy.value = true;
                        try {
                          final result = await action.start(
                            ref: ref,
                            context: context,
                            rawJson: jsonController.text,
                          );
                          if (!context.mounted) {
                            return;
                          }
                          if (result != null) {
                            selectedSession.value = result;
                            activityIdController.text = result.activityId;
                            logicalId.value = result.logicalId;
                            refreshVersion.value++;
                          }
                        } finally {
                          if (context.mounted) {
                            isBusy.value = false;
                          }
                        }
                      },
              ),
              FilledButton.tonalIcon(
                icon: const Icon(Icons.refresh),
                label: const Text('更新'),
                onPressed: isBusy.value
                    ? null
                    : () async {
                        isBusy.value = true;
                        try {
                          final result = await action.update(
                            ref: ref,
                            context: context,
                            activityId: activityIdController.text.trim(),
                            rawJson: jsonController.text,
                          );
                          if (!context.mounted) {
                            return;
                          }
                          if (result == .success) {
                            refreshVersion.value++;
                          } else if (result == .activityNotFound) {
                            selectedSession.value = null;
                            activityIdController.clear();
                            refreshVersion.value++;
                          }
                        } finally {
                          if (context.mounted) {
                            isBusy.value = false;
                          }
                        }
                      },
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.stop),
                label: const Text('終了'),
                onPressed: isBusy.value
                    ? null
                    : () async {
                        isBusy.value = true;
                        try {
                          final result = await action.end(
                            ref: ref,
                            context: context,
                            activityId: activityIdController.text.trim(),
                            rawJson: jsonController.text,
                          );
                          if (!context.mounted) {
                            return;
                          }
                          if (result == .success ||
                              result == .activityNotFound) {
                            selectedSession.value = null;
                            activityIdController.clear();
                            refreshVersion.value++;
                          }
                        } finally {
                          if (context.mounted) {
                            isBusy.value = false;
                          }
                        }
                      },
              ),
            ],
          ),
          const SizedBox(height: 24),
          _ActiveSessions(
            snapshot: sessions,
            selectedActivityId: selectedSession.value?.activityId,
            enabled: !isBusy.value,
            onRefresh: () => refreshVersion.value++,
            onSelected: (session) {
              selectedSession.value = session;
              activityIdController.text = session.activityId;
              logicalId.value = session.logicalId;
            },
          ),
          _SupportabilityTile(snapshot: support),
        ],
      ),
    );
  }
}

String debugLiveActivityLogicalId(DateTime now) =>
    'debug-${now.toUtc().millisecondsSinceEpoch}';

class _LogicalIdCard extends StatelessWidget {
  const new({
    required this.logicalId,
    required this.enabled,
    required this.onNewSequence,
  });

  final String logicalId;
  final bool enabled;
  final VoidCallback onNewSequence;

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: const Icon(Icons.fingerprint),
      title: const Text('logical ID'),
      subtitle: SelectableText(logicalId),
      trailing: TextButton.icon(
        onPressed: enabled ? onNewSequence : null,
        icon: const Icon(Icons.add),
        label: const Text('新しい系列'),
      ),
    ),
  );
}

class _PresetChips extends StatelessWidget {
  const new({
    required this.selected,
    required this.enabled,
    required this.onSelected,
  });

  final DebugUnifiedPreset selected;
  final bool enabled;
  final ValueChanged<DebugUnifiedPreset> onSelected;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 4,
    children: [
      for (final preset in DebugUnifiedPreset.values)
        ChoiceChip(
          label: Text(preset.label),
          selected: selected == preset,
          onSelected: enabled ? (_) => onSelected(preset) : null,
        ),
    ],
  );
}

class _ActiveSessions extends StatelessWidget {
  const new({
    required this.snapshot,
    required this.selectedActivityId,
    required this.enabled,
    required this.onRefresh,
    required this.onSelected,
  });

  final AsyncSnapshot<List<DebugLiveActivitySession>> snapshot;
  final String? selectedActivityId;
  final bool enabled;
  final VoidCallback onRefresh;
  final ValueChanged<DebugLiveActivitySession> onSelected;

  @override
  Widget build(BuildContext context) => Card(
    child: Column(
      children: [
        ListTile(
          title: const Text('実行中の Live Activity'),
          trailing: IconButton(
            onPressed: enabled ? onRefresh : null,
            tooltip: '一覧を再読み込み',
            icon: const Icon(Icons.refresh),
          ),
        ),
        if (snapshot.connectionState != ConnectionState.done)
          const Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          )
        else if (snapshot.hasError)
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('実行中一覧を取得できませんでした'),
          )
        else if (snapshot.data case final sessions? when sessions.isNotEmpty)
          for (final session in sessions)
            ListTile(
              selected: session.activityId == selectedActivityId,
              leading: const Icon(Icons.bolt),
              title: Text(session.activityId),
              subtitle: Text(
                session.eventId == null
                    ? 'logical: ${session.logicalId}'
                    : 'logical: ${session.logicalId}\nevent: ${session.eventId}',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: enabled ? () => onSelected(session) : null,
            )
        else
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text('実行中の Live Activity はありません'),
          ),
      ],
    ),
  );
}

class _SupportabilityTile extends StatelessWidget {
  const new({required this.snapshot});

  final AsyncSnapshot<bool> snapshot;

  @override
  Widget build(BuildContext context) {
    final text = switch (snapshot.data) {
      null => snapshot.hasError ? '対応状況を確認できませんでした' : '対応状況を確認中...',
      true => 'この端末はローカル Live Activity に対応しています',
      false => 'この端末はローカル Live Activity に非対応です（iOS 16.1+ が必要）',
    };
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(text, style: Theme.of(context).textTheme.bodySmall),
    );
  }
}
