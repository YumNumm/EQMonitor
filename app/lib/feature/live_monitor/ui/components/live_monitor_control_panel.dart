import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_duration_validator.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_control_panel_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorControlPanel extends HookConsumerWidget {
  const LiveMonitorControlPanel({
    required this.onDurationChanged,
    required this.onDurationCommit,
    required this.onExit,
    required this.settings,
    super.key,
  });

  final int Function(String raw) onDurationChanged;
  final Future<bool> Function({required String raw, required int? revision})
  onDurationCommit;
  final Future<void> Function() onExit;
  final LiveMonitorSettings settings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final durationController = useTextEditingController(
      text: settings.earthquakeDisplaySeconds.toString(),
    );
    final durationFocusNode = useFocusNode();
    final durationError = useState<String?>(null);
    final durationRevision = useRef<int?>(null);

    final Future<bool> Function({required String raw, required int? revision})
    saveDuration = ({required raw, required revision}) async {
      final validation = validateLiveMonitorDuration(raw);
      final seconds = validation.seconds;
      if (seconds == null) {
        durationError.value = '3〜300の整数を入力してください';
        return false;
      }
      durationError.value = null;
      final didCommit = await onDurationCommit(raw: raw, revision: revision);
      if (!context.mounted) {
        return false;
      }
      if (!didCommit &&
          isCurrentLiveMonitorDurationGeneration(
            currentRaw: durationController.text,
            currentRevision: durationRevision.value,
            committedRaw: raw,
            committedRevision: revision,
          )) {
        durationError.value = '表示時間を保存できませんでした';
      }
      return didCommit;
    };

    useEffect(() {
      void handleFocusChanged() async {
        if (!durationFocusNode.hasFocus) {
          final committedRaw = durationController.text;
          final committedRevision = durationRevision.value;
          final didCommit = await saveDuration(
            raw: committedRaw,
            revision: committedRevision,
          );
          if (!context.mounted) {
            return;
          }
          if (!shouldApplyCommittedLiveMonitorDuration(
            didCommit: didCommit,
            hasFocus: durationFocusNode.hasFocus,
            currentRaw: durationController.text,
            currentRevision: durationRevision.value,
            committedRaw: committedRaw,
            committedRevision: committedRevision,
          )) {
            return;
          }
          final resolvedSettings = ref.read(liveMonitorSettingsProvider).value;
          if (resolvedSettings != null) {
            durationError.value = null;
            final resolvedText = resolvedSettings.earthquakeDisplaySeconds
                .toString();
            if (durationController.text != resolvedText) {
              durationController.value = durationController.value.copyWith(
                text: resolvedText,
                selection: TextSelection.collapsed(offset: resolvedText.length),
              );
            }
          }
        }
      }

      durationFocusNode.addListener(handleFocusChanged);
      return () => durationFocusNode.removeListener(handleFocusChanged);
    }, [durationController, durationFocusNode]);

    useEffect(() {
      final resolvedText = settings.earthquakeDisplaySeconds.toString();
      if (!durationFocusNode.hasFocus &&
          durationController.text != resolvedText) {
        durationController.value = durationController.value.copyWith(
          text: resolvedText,
          selection: TextSelection.collapsed(offset: resolvedText.length),
        );
      }
      return null;
    }, [settings.earthquakeDisplaySeconds]);

    final panelHeight = MediaQuery.sizeOf(context).height * 0.9;
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      minimum: const EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 560, maxHeight: panelHeight),
        child: Material(
          color: colorScheme.surfaceContainerHigh,
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(28),
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'LiveMonitor モード',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      final committedRaw = durationController.text;
                      final committedRevision = durationRevision.value;
                      final didCommit = await saveDuration(
                        raw: committedRaw,
                        revision: committedRevision,
                      );
                      if (!context.mounted ||
                          !didCommit ||
                          !isCurrentLiveMonitorDurationGeneration(
                            currentRaw: durationController.text,
                            currentRevision: durationRevision.value,
                            committedRaw: committedRaw,
                            committedRevision: committedRevision,
                          )) {
                        return;
                      }
                      ref
                          .read(liveMonitorControlPanelProvider.notifier)
                          .close();
                    },
                    tooltip: '閉じる',
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('表示方式', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              SegmentedButton<LiveMonitorDisplayMode>(
                segments: const [
                  ButtonSegment(
                    value: LiveMonitorDisplayMode.automatic,
                    label: Text('自動切替'),
                    icon: Icon(Icons.auto_awesome),
                  ),
                  ButtonSegment(
                    value: LiveMonitorDisplayMode.split,
                    label: Text('分割表示'),
                    icon: Icon(Icons.splitscreen),
                  ),
                ],
                selected: {settings.displayMode},
                onSelectionChanged: (selection) async {
                  final displayMode = selection.first;
                  await LiveMonitorSettingsNotifier.saveMutation.run(ref, (
                    tsx,
                  ) async {
                    await tsx
                        .get(liveMonitorSettingsProvider.notifier)
                        .updateSettings(
                          transform: (current) =>
                              current.copyWith(displayMode: displayMode),
                        );
                  });
                },
              ),
              const SizedBox(height: 20),
              TextField(
                controller: durationController,
                focusNode: durationFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: '地震情報の表示時間（秒）',
                  helperText: '3〜300秒',
                  errorText: durationError.value,
                ),
                onChanged: (raw) {
                  durationRevision.value = onDurationChanged(raw);
                  durationError.value =
                      validateLiveMonitorDuration(raw).error == null
                      ? null
                      : '3〜300の整数を入力してください';
                },
                onSubmitted: (raw) async {
                  await saveDuration(
                    raw: raw,
                    revision: durationRevision.value,
                  );
                },
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('画面の点灯を維持'),
                value: settings.keepScreenAwake,
                onChanged: (keepScreenAwake) async {
                  await LiveMonitorSettingsNotifier.saveMutation.run(ref, (
                    tsx,
                  ) async {
                    await tsx
                        .get(liveMonitorSettingsProvider.notifier)
                        .updateSettings(
                          transform: (current) => current.copyWith(
                            keepScreenAwake: keepScreenAwake,
                          ),
                        );
                  });
                },
              ),
              const SizedBox(height: 12),
              Wrap(
                alignment: WrapAlignment.end,
                spacing: 8,
                runSpacing: 8,
                children: [
                  TextButton(
                    onPressed: () async {
                      final committedRaw = durationController.text;
                      final committedRevision = durationRevision.value;
                      final didCommit = await saveDuration(
                        raw: committedRaw,
                        revision: committedRevision,
                      );
                      if (!context.mounted ||
                          !didCommit ||
                          !isCurrentLiveMonitorDurationGeneration(
                            currentRaw: durationController.text,
                            currentRevision: durationRevision.value,
                            committedRaw: committedRaw,
                            committedRevision: committedRevision,
                          )) {
                        return;
                      }
                      ref
                          .read(liveMonitorControlPanelProvider.notifier)
                          .close();
                    },
                    child: const Text('閉じる'),
                  ),
                  FilledButton.tonalIcon(
                    onPressed: () async {
                      await onExit();
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text('LiveMonitor モードを終了'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
