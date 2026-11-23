import 'package:eqmonitor/core/component/progress/accessible_progress_indicator.dart';
import 'package:eqmonitor/core/component/widget/app_switch.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/util/byte_size_formatter.dart';
import 'package:eqmonitor/core/util/date_time_format.dart';
import 'package:eqmonitor/core/util/haptic.dart';
import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/action/replay_creation_action.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_creation_range_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/replay_creation_request.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/model/saved_replay_file.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_creation_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/saved_replay_files_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_creation_selectable_range_provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const ReplayCreationPage({super.key}) extends HookConsumerWidget {
  static const durations = [
    Duration(minutes: 1),
    Duration(minutes: 3),
    Duration(minutes: 5),
    Duration(minutes: 10),
    Duration(minutes: 20),
    Duration(minutes: 30),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final range = ref.watch(replayCreationSelectableRangeProvider).value;
    final selectedStart = useState<DateTime?>(null);
    final duration = useState(const Duration(minutes: 5));
    final imageKinds = useState({ReplayCreationImageKind.shindo});
    final includeEew = useState(true);
    final includePreRoll = useState(true);
    final progress = ref.watch(replayCreationProvider);
    final isCreating =
        ref.watch(ReplayCreationNotifier.createMutation) is MutationPending;
    final spacing = context.designSystem.spacing;

    if (range == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('リプレイファイルを作成')),
        body: const Center(child: AccessibleCircularProgressIndicator()),
      );
    }

    const minute = Duration.millisecondsPerMinute;
    final minStartMinute =
        (range.earliest.millisecondsSinceEpoch + minute - 1) ~/ minute;
    final maxStartMinute =
        range.latest.subtract(duration.value).millisecondsSinceEpoch ~/ minute;
    final startMinute =
        ((selectedStart.value?.millisecondsSinceEpoch ?? 0) ~/ minute).clamp(
          minStartMinute,
          maxStartMinute,
        );
    final request = ReplayCreationRequest(
      startTime: DateTime.fromMillisecondsSinceEpoch(
        (selectedStart.value == null ? maxStartMinute : startMinute) * minute,
        isUtc: true,
      ),
      duration: duration.value,
      imageKinds: imageKinds.value,
      includeEew: includeEew.value,
      includePreRoll: includePreRoll.value,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('リプレイファイルを作成')),
      body: ListView(
        padding: EdgeInsets.only(bottom: spacing.xl),
        children: [
          const _SectionHeader(title: '期間'),
          ListTile(
            title: Text(
              '${request.startTime.formatWithTz(.monthDayHourMinuteSecond)}'
              ' 〜 ${request.endTime.formatWithTz(.hourMinuteSecond)}',
            ),
            subtitle: Text(
              '強震モニタの画像を取得できるのは '
              '${range.earliest.formatWithTz(.monthDayHourMinute)} 以降です',
            ),
          ),
          Slider(
            min: minStartMinute.toDouble(),
            max: maxStartMinute.toDouble(),
            divisions: maxStartMinute - minStartMinute,
            value: request.startTime.millisecondsSinceEpoch / minute,
            label: request.startTime.formatWithTz(.hourMinute),
            onChanged: isCreating
                ? null
                : (value) =>
                      selectedStart.value = DateTime.fromMillisecondsSinceEpoch(
                        value.round() * minute,
                        isUtc: true,
                      ),
            onChangeEnd: isCreating
                ? null
                : (_) => HapticFeedback.selectionClick(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: spacing.lg),
            child: Wrap(
              spacing: spacing.sm,
              children: [
                for (final option in durations)
                  ChoiceChip(
                    label: Text('${option.inMinutes}分'),
                    selected: option == duration.value,
                    onSelected: isCreating
                        ? null
                        : (_) => HapticUtil.selection(
                            () => duration.value = option,
                          ),
                  ),
              ],
            ),
          ),
          const _SectionHeader(title: '含めるデータ'),
          for (final kind in ReplayCreationImageKind.values)
            CheckboxListTile(
              title: Text('強震モニタ: ${kind.label}'),
              subtitle: kind == .shindo
                  ? const Text('再生時の観測点表示と揺れ検知に使います')
                  : null,
              value: imageKinds.value.contains(kind),
              onChanged: isCreating
                  ? null
                  : (value) => HapticUtil.selection(
                      () => imageKinds.value = value ?? false
                          ? {...imageKinds.value, kind}
                          : imageKinds.value.difference({kind}),
                    ),
            ),
          AppSwitchListTile(
            title: '緊急地震速報',
            subtitle: 'EQMonitor API から期間内の全報を取得します',
            value: includeEew.value,
            onChanged: isCreating ? null : (value) => includeEew.value = value,
          ),
          AppSwitchListTile(
            title: '開始前の画像も含める',
            subtitle:
                '揺れ検知の平常値に使う'
                '${ReplayCreationRangeResolver.preRoll.inSeconds}秒前からの画像を追加します',
            value: includePreRoll.value,
            onChanged: isCreating
                ? null
                : (value) => includePreRoll.value = value,
          ),
          Padding(
            padding: EdgeInsets.all(spacing.lg),
            child: isCreating
                ? _CreationProgress(progress: progress)
                : FilledButton.icon(
                    onPressed: imageKinds.value.isEmpty
                        ? null
                        : () => HapticUtil.light(
                            () => ref
                                .read(replayCreationActionProvider)
                                .create(ref, context, request: request),
                          ),
                    icon: const Icon(Icons.save_alt_rounded),
                    label: const Text('作成してアプリ内に保存'),
                  ),
          ),
          const _SectionHeader(title: '保存済みのリプレイファイル'),
          const _SavedReplayFileList(),
        ],
      ),
    );
  }
}

class const _SectionHeader({required final String title})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final designSystem = context.designSystem;
    final spacing = designSystem.spacing;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        spacing.lg,
        spacing.lg,
        spacing.lg,
        spacing.xs,
      ),
      child: Text(title, style: designSystem.typography.titleSmall),
    );
  }
}

class const _CreationProgress({
  required final ReplayCreationProgress? progress,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final spacing = context.designSystem.spacing;
    final current = progress;
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        LinearProgressIndicator(
          value: current == null || current.total == 0
              ? null
              : current.completed / current.total,
        ),
        SizedBox(height: spacing.sm),
        Text(
          current == null
              ? '準備しています'
              : current.completed < current.total
              ? '強震モニタの画像を取得しています '
                    '(${current.completed}/${current.total})'
              : 'ファイルを書き出しています',
        ),
        SizedBox(height: spacing.sm),
        OutlinedButton(
          onPressed: () => HapticUtil.light(
            () => ref.read(replayCreationProvider.notifier).cancel(),
          ),
          child: const Text('中止'),
        ),
      ],
    );
  }
}

class const _SavedReplayFileList() extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final files = ref.watch(savedReplayFilesProvider);
    final canExport =
        ref.watch(debugAccessLevelProvider) == DebugAccessLevel.full;
    return switch (files) {
      AsyncValue(:final value?) when value.isEmpty => const ListTile(
        title: Text('保存済みのファイルはありません'),
      ),
      AsyncValue(:final value?) => Column(
        children: [
          for (final file in value)
            _SavedReplayFileTile(file: file, canExport: canExport),
        ],
      ),
      AsyncValue(:final error?) => ListTile(
        title: Text('一覧の取得に失敗しました: $error'),
      ),
      _ => const Center(child: AccessibleCircularProgressIndicator()),
    };
  }
}

class const _SavedReplayFileTile({
  required final SavedReplayFile file,
  required final bool canExport,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final action = ref.watch(replayCreationActionProvider);
    return ListTile(
      title: Text(file.name),
      subtitle: Text(
        '${const ByteSizeFormatter().format(file.sizeBytes)}・'
        '${file.modifiedAt.formatWithTz(.monthDayHourMinute)} 作成',
      ),
      onTap: () async => action.play(context, file: file),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          IconButton(
            icon: const Icon(Icons.play_arrow_rounded),
            tooltip: '再生',
            onPressed: () async => action.play(context, file: file),
          ),
          if (canExport)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.ios_share_rounded),
                tooltip: '外部へエクスポート',
                onPressed: () async => action.export(ref, context, file: file),
              ),
            ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded),
            tooltip: '削除',
            onPressed: () async => action.delete(ref, context, file: file),
          ),
        ],
      ),
    );
  }
}
