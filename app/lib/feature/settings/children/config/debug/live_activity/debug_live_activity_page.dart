import 'dart:io';

import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/gen/fonts.gen.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DebugLiveActivityPage extends HookConsumerWidget {
  const DebugLiveActivityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiClient = ref.watch(apiClientProvider);
    final trigger = useState(LiveActivityStartTrigger.eew);
    final isLoading = useState(false);
    final activeLiveActivity = useState<_ActiveLiveActivity?>(null);

    if (!Platform.isIOS) {
      return Scaffold(
        appBar: AppBar(title: const Text('Live Activity テスト')),
        body: const Center(
          child: Text('Live Activity は iOS でのみ利用できます'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Live Activity テスト')),
      body: switch (apiClient) {
        AsyncData(:final value) => _Body(
            api: value,
            trigger: trigger,
            isLoading: isLoading,
            activeLiveActivity: activeLiveActivity,
          ),
        AsyncError(:final error) => Center(child: Text('API初期化エラー: $error')),
        _ => const Center(child: CircularProgressIndicator.adaptive()),
      },
    );
  }
}

class _Body extends HookConsumerWidget {
  const _Body({
    required this.api,
    required this.trigger,
    required this.isLoading,
    required this.activeLiveActivity,
  });

  final ApiClient api;
  final ValueNotifier<LiveActivityStartTrigger> trigger;
  final ValueNotifier<bool> isLoading;
  final ValueNotifier<_ActiveLiveActivity?> activeLiveActivity;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final active = activeLiveActivity.value;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('開始トリガー', style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                SegmentedButton<LiveActivityStartTrigger>(
                  segments: const [
                    ButtonSegment(
                      value: LiveActivityStartTrigger.eew,
                      label: Text('EEW'),
                      icon: Icon(Icons.warning_amber),
                    ),
                    ButtonSegment(
                      value: LiveActivityStartTrigger.shakeDetection,
                      label: Text('揺れ検知'),
                      icon: Icon(Icons.sensors),
                    ),
                  ],
                  selected: {trigger.value},
                  onSelectionChanged: (selected) =>
                      trigger.value = selected.first,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: isLoading.value
                        ? null
                        : () => _start(context),
                    icon: isLoading.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.play_arrow),
                    label: const Text('Live Activity を開始'),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (active != null) ...[
          const SizedBox(height: 16),
          _ActiveCard(
            active: active,
            api: api,
            isLoading: isLoading,
            onEnded: () => activeLiveActivity.value = null,
          ),
        ],
      ],
    );
  }

  Future<void> _start(BuildContext context) async {
    isLoading.value = true;
    final messenger = ScaffoldMessenger.of(context);
    try {
      final response = await api.device.postV2DeviceMeLiveActivityTest(
        body: TestLiveActivityStartRequest(startTrigger: trigger.value),
      );
      final data = response.data;
      activeLiveActivity.value = _ActiveLiveActivity(
        liveActivityId: data.liveActivityId,
        eventId: data.eventId,
        startTrigger: data.startTrigger,
      );
      messenger.showSnackBar(
        const SnackBar(content: Text('Live Activity を開始しました')),
      );
    } on Object catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('開始に失敗: $e')),
      );
    } finally {
      isLoading.value = false;
    }
  }
}

class _ActiveCard extends HookWidget {
  const _ActiveCard({
    required this.active,
    required this.api,
    required this.isLoading,
    required this.onEnded,
  });

  final _ActiveLiveActivity active;
  final ApiClient api;
  final ValueNotifier<bool> isLoading;
  final VoidCallback onEnded;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pendingAction = useState<String?>(null);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.circle, size: 10, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text('アクティブ', style: theme.textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 12),
            _InfoRow(
              label: 'Live Activity ID',
              value: active.liveActivityId,
            ),
            const SizedBox(height: 4),
            _InfoRow(label: 'Event ID', value: active.eventId),
            const SizedBox(height: 4),
            _InfoRow(
              label: 'トリガー',
              value: active.startTrigger == LiveActivityStartTrigger.eew
                  ? 'EEW'
                  : '揺れ検知',
            ),
            const SizedBox(height: 8),
            Text(
              'updateToken 登録完了後に Update/End が利用できます。'
              '登録前は 409 Conflict が返ります。',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: pendingAction.value != null
                        ? null
                        : () => _update(context, pendingAction),
                    child: pendingAction.value == 'update'
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Update'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: pendingAction.value != null
                        ? null
                        : () => _end(context, pendingAction),
                    style: FilledButton.styleFrom(
                      backgroundColor:
                          theme.colorScheme.errorContainer,
                      foregroundColor:
                          theme.colorScheme.onErrorContainer,
                    ),
                    child: pendingAction.value == 'end'
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('End'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _update(
    BuildContext context,
    ValueNotifier<String?> pendingAction,
  ) async {
    pendingAction.value = 'update';
    final messenger = ScaffoldMessenger.of(context);
    try {
      final response =
          await api.device.postV2DeviceMeLiveActivityTestLiveActivityIdUpdate(
        liveActivityId: active.liveActivityId,
        body: TestLiveActivityUpdateRequest(
          contentState: {'eventId': active.eventId},
        ),
      );
      messenger.showSnackBar(
        SnackBar(content: Text(response.data.message)),
      );
    } on Object catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('Update に失敗: $e')),
      );
    } finally {
      pendingAction.value = null;
    }
  }

  Future<void> _end(
    BuildContext context,
    ValueNotifier<String?> pendingAction,
  ) async {
    pendingAction.value = 'end';
    final messenger = ScaffoldMessenger.of(context);
    try {
      final response =
          await api.device.postV2DeviceMeLiveActivityTestLiveActivityIdEnd(
        liveActivityId: active.liveActivityId,
        body: const TestLiveActivityEndRequest(),
      );
      messenger.showSnackBar(
        SnackBar(content: Text(response.data.message)),
      );
      onEnded();
    } on Object catch (e) {
      messenger.showSnackBar(
        SnackBar(content: Text('End に失敗: $e')),
      );
    } finally {
      pendingAction.value = null;
    }
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: value));
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$label をコピーしました'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      },
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodySmall?.copyWith(
                fontFamily: FontFamily.googleSansCode,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Icon(
            Icons.copy,
            size: 14,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _ActiveLiveActivity {
  const _ActiveLiveActivity({
    required this.liveActivityId,
    required this.eventId,
    required this.startTrigger,
  });

  final String liveActivityId;
  final String eventId;
  final LiveActivityStartTrigger startTrigger;
}
