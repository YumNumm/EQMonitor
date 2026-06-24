// ignore_for_file: avoid_eqmonitor_api_in_ui
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_details_notifier.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_playback_selection_notifier.dart';
import 'package:eqmonitor/feature/tsunami/data/notifier/tsunami_telegrams_provider.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'effective_tsunami_state_provider.g.dart';

@riverpod
TsunamiState? effectiveTsunamiState(
  Ref ref,
  String tsunamiId,
) {
  final detailsAsync = ref.watch(tsunamiDetailsProvider(tsunamiId));
  final latestState = detailsAsync.value;
  if (latestState == null) {
    return null;
  }

  ref.listen(
    tsunamiDetailsProvider(tsunamiId),
    (previous, next) {
      final prevUpdatedAt = previous?.value?.updatedAt;
      final nextUpdatedAt = next.value?.updatedAt;
      if (prevUpdatedAt != nextUpdatedAt) {
        ref.read(tsunamiPlaybackSelectionProvider.notifier).resetToLatest();
      }
    },
  );

  final selection = ref.watch(tsunamiPlaybackSelectionProvider);
  final selectedIndex = selection.selectedIndex;

  if (selectedIndex == null) {
    return latestState;
  }

  final telegramsAsync = ref.watch(tsunamiTelegramsProvider(tsunamiId));
  final telegrams = telegramsAsync.value;
  if (telegrams == null || selectedIndex >= telegrams.length) {
    return latestState;
  }

  return telegrams[selectedIndex].state;
}
