import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/ui/action/debug_live_activity_action.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugLiveActivityPage extends HookConsumerWidget {
  const DebugLiveActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trigger = useState(api.LiveActivityStartTrigger.eew);
    final session = useState<DebugLiveActivitySession?>(null);
    final isBusy = useState(false);
    final contentStateController = useTextEditingController();
    final alertController = useTextEditingController();
    final liveActivityIdController = useTextEditingController();
    final action = ref.watch(debugLiveActivityActionProvider);

    final body = ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _TriggerSelector(trigger: trigger),
        const SizedBox(height: 16),
        _JsonTextField(
          controller: contentStateController,
          label: 'ContentState JSON',
          hintText: '空ならサーバ既定を利用します',
        ),
        const SizedBox(height: 16),
        _JsonTextField(
          controller: alertController,
          label: 'Alert JSON',
          hintText: '任意。例: {"title":"テスト","body":"本文"}',
        ),
        const SizedBox(height: 16),
        TextField(
          controller: liveActivityIdController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'live_activity_id',
            hintText: '開始後に自動反映。手入力も可能です',
          ),
        ),
        const SizedBox(height: 16),
        _ActionButtons(
          isBusy: isBusy.value,
          onStart: () async {
            isBusy.value = true;
            try {
              final startedSession = await action.start(
                ref,
                context,
                startTrigger: trigger.value,
                contentStateJson: contentStateController.text,
                alertJson: alertController.text,
              );
              if (startedSession == null || !context.mounted) {
                return;
              }
              session.value = startedSession;
              liveActivityIdController.text = startedSession.liveActivityId;
            } finally {
              if (context.mounted) {
                isBusy.value = false;
              }
            }
          },
          onUpdate: () async {
            isBusy.value = true;
            try {
              await action.update(
                ref,
                context,
                liveActivityId: liveActivityIdController.text,
                contentStateJson: contentStateController.text,
              );
            } finally {
              if (context.mounted) {
                isBusy.value = false;
              }
            }
          },
          onEnd: () async {
            isBusy.value = true;
            try {
              final ended = await action.end(
                ref,
                context,
                liveActivityId: liveActivityIdController.text,
                contentStateJson: contentStateController.text,
              );
              if (ended && context.mounted) {
                session.value = null;
              }
            } finally {
              if (context.mounted) {
                isBusy.value = false;
              }
            }
          },
        ),
        const SizedBox(height: 16),
        _SessionCard(session: session.value),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Live Activity テスト')),
      body: body,
    );
  }
}

class _TriggerSelector extends StatelessWidget {
  const _TriggerSelector({required this.trigger});

  final ValueNotifier<api.LiveActivityStartTrigger> trigger;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('開始トリガー', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        SegmentedButton<api.LiveActivityStartTrigger>(
          segments: const [
            ButtonSegment(
              value: api.LiveActivityStartTrigger.eew,
              label: Text('EEW'),
              icon: Icon(Icons.flash_on),
            ),
            ButtonSegment(
              value: api.LiveActivityStartTrigger.shakeDetection,
              label: Text('揺れ検知'),
              icon: Icon(Icons.sensors),
            ),
          ],
          selected: {trigger.value},
          onSelectionChanged: (selected) => trigger.value = selected.first,
        ),
      ],
    );
  }
}

class _JsonTextField extends StatelessWidget {
  const _JsonTextField({
    required this.controller,
    required this.label,
    required this.hintText,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      minLines: 4,
      maxLines: 10,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: hintText,
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.isBusy,
    required this.onStart,
    required this.onUpdate,
    required this.onEnd,
  });

  final bool isBusy;
  final VoidCallback onStart;
  final VoidCallback onUpdate;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        FilledButton.icon(
          onPressed: isBusy ? null : onStart,
          icon: const Icon(Icons.play_arrow),
          label: const Text('開始'),
        ),
        FilledButton.tonalIcon(
          onPressed: isBusy ? null : onUpdate,
          icon: const Icon(Icons.refresh),
          label: const Text('更新'),
        ),
        OutlinedButton.icon(
          onPressed: isBusy ? null : onEnd,
          icon: const Icon(Icons.stop),
          label: const Text('終了'),
        ),
        if (isBusy)
          const Padding(
            padding: EdgeInsets.all(8),
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
      ],
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final DebugLiveActivitySession? session;

  @override
  Widget build(BuildContext context) {
    final currentSession = session;
    if (currentSession == null) {
      return const Card(
        child: ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('セッションなし'),
          subtitle: Text(
            '開始に成功すると live_activity_id / event_id / trigger を表示します',
          ),
        ),
      );
    }

    final triggerLabel = switch (currentSession.startTrigger) {
      api.LiveActivityStartTrigger.eew => 'EEW',
      api.LiveActivityStartTrigger.shakeDetection => '揺れ検知',
    };

    return Card(
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.live_tv_outlined),
            title: Text('現在のセッション'),
            subtitle: Text('各行をタップすると Clipboard にコピーします'),
          ),
          _CopyListTile(
            title: 'live_activity_id',
            value: currentSession.liveActivityId,
          ),
          _CopyListTile(title: 'event_id', value: currentSession.eventId),
          _CopyListTile(title: 'trigger', value: triggerLabel),
        ],
      ),
    );
  }
}

class _CopyListTile extends StatelessWidget {
  const _CopyListTile({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(value),
      trailing: const Icon(Icons.copy),
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: value));
        if (!context.mounted) {
          return;
        }
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$title をコピーしました')));
      },
    );
  }
}
