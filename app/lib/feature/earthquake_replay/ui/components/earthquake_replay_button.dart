import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/action/replay_open_action.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/notifier/replay_notifier.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_kyoshin_archive_window_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

class const EarthquakeReplayButton({
  required final Earthquake earthquake,
  super.key,
}) extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final window = ref.watch(
      replayKyoshinArchiveWindowProvider(
        originTime: earthquake.originTime,
        precision: earthquake.originTimePrecision,
      ),
    );
    if (window == null) {
      return const SizedBox.shrink();
    }
    final isOpening =
        ref.watch(ReplayNotifier.openEarthquakeMutation) is MutationPending;
    final designSystem = context.designSystem;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: M3EFilledButton.tonalIcon(
        onPressed: isOpening
            ? null
            : () async => ref
                  .read(replayOpenActionProvider)
                  .openEarthquake(ref, context, earthquake: earthquake),
        icon: const Icon(Icons.history_rounded),
        label: const Text('強震モニタで再生'),
        decoration: M3EButtonDecoration.styleFrom(
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: designSystem.colorTheme.secondaryContainer,
          foregroundColor: designSystem.colorTheme.onSecondaryContainer,
        ),
      ),
    );
  }
}
