import 'dart:async';

import 'package:eqmonitor/feature/notification/data/notifier/test_live_activity_notifier.dart';
import 'package:eqmonitor/feature/notification/ui/action/test_live_activity_action.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const TestLiveActivityPanel({super.key}) extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preset = useState(DebugEewPreset.forecast);
    final status = ref.watch(testLiveActivityProvider);
    final showing = ref.watch(TestLiveActivityNotifier.showMutation);
    final ending = ref.watch(TestLiveActivityNotifier.endMutation);
    final action = ref.watch(testLiveActivityActionProvider);
    final busy = showing is MutationPending || ending is MutationPending;
    final active = status.value?.isActive ?? false;
    final supported = status.value?.isSupported ?? false;
    final endsAt = status.value?.endsAt;
    // 自動終了までの残りをボタンへ出すため、表示中は毎秒描き直す
    final tick = useState(0);
    useEffect(() {
      if (endsAt == null) {
        return null;
      }
      final timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => tick.value++,
      );
      return timer.cancel;
    }, [endsAt]);
    final remaining = endsAt?.difference(DateTime.now());
    final remainingSeconds = remaining == null || remaining.isNegative
        ? null
        : (remaining.inMilliseconds / 1000).ceil();
    // 状態を保持するため、画面を開いたときにロック画面側で消された表示を取り込む
    useEffect(() {
      Future.microtask(() => ref.invalidate(testLiveActivityProvider));
      return null;
    }, const []);
    useOnAppLifecycleStateChange((previous, next) {
      if (next == AppLifecycleState.resumed && !busy) {
        ref.invalidate(testLiveActivityProvider);
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ライブアクティビティ', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        const Text('緊急地震速報のテスト表示を、この端末のロック画面やDynamic Islandで確認できます。'),
        const SizedBox(height: 12),
        if (status.isLoading) const LinearProgressIndicator(),
        if (status.hasError) ...[
          const Text('ライブアクティビティの状態を確認できませんでした。'),
          TextButton(
            onPressed: busy
                ? null
                : () => ref.invalidate(testLiveActivityProvider),
            child: const Text('再確認'),
          ),
        ] else if (status.hasValue) ...[
          if (!supported)
            const Text('この端末ではライブアクティビティを利用できません。iOSの対応状況と設定を確認してください。'),
          if (active) const Text('テストを表示中です'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final entry in const {
                DebugEewPreset.forecast: '予報',
                DebugEewPreset.warning: '警報',
                DebugEewPreset.finalReport: '最終報',
                DebugEewPreset.canceled: '取消',
              }.entries)
                ChoiceChip(
                  label: Text(entry.value),
                  selected: preset.value == entry.key,
                  onSelected: busy || !supported
                      ? null
                      : (_) => preset.value = entry.key,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              M3EFilledButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: Text(active ? 'テスト表示を更新' : 'テスト表示を開始'),
                onPressed: busy || !supported
                    ? null
                    : () => action.run(
                        ref: ref,
                        context: context,
                        preset: preset.value,
                      ),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.stop),
                label: Text(
                  remainingSeconds == null
                      ? 'テスト表示を終了'
                      : 'テスト表示を終了 '
                            '(${remainingSeconds ~/ 60}:'
                            "${(remainingSeconds % 60).toString().padLeft(2, '0')})",
                ),
                onPressed: busy || !active
                    ? null
                    : () => action.run(ref: ref, context: context),
              ),
            ],
          ),
          if (busy) ...[
            const SizedBox(height: 8),
            const LinearProgressIndicator(),
          ],
        ],
      ],
    );
  }
}
