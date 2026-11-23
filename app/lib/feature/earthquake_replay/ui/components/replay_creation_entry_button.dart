import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/router/router.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_creation_range_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_file_path_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_creation_entry_available_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';

class const ReplayCreationEntryButton({
  required final DateTime? originTime,
  required final String label,
  required final bool isExpanded,
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = originTime;
    if (time == null ||
        !ref.watch(replayCreationEntryAvailableProvider(originTime: time))) {
      return const SizedBox.shrink();
    }
    final designSystem = context.designSystem;
    final button = M3EFilledButton.tonalIcon(
      onPressed: () async => DebugReplayCreationRoute(
        startTimeMs: ref
            .read(replayCreationRangeResolverProvider)
            .initialStartTime(originTime: time)
            .millisecondsSinceEpoch,
        name: ref
            .read(replayFilePathResolverProvider)
            .suggestedName(label: label, time: time),
      ).push<void>(context),
      icon: const Icon(Icons.fiber_manual_record_rounded),
      label: const Text('リプレイファイルを作成'),
      decoration: M3EButtonDecoration.styleFrom(
        minimumSize: isExpanded ? const Size(double.infinity, 48) : null,
        backgroundColor: designSystem.colorTheme.secondaryContainer,
        foregroundColor: designSystem.colorTheme.onSecondaryContainer,
      ),
    );
    return isExpanded
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: button,
          )
        : button;
  }
}
