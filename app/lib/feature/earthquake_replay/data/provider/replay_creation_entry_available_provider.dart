import 'package:eqmonitor/feature/debug/data/model/debug_access_level.dart';
import 'package:eqmonitor/feature/debug/data/provider/debug_access_level_provider.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_creation_range_resolver.dart';
import 'package:eqmonitor/feature/earthquake_replay/data/provider/replay_creation_selectable_range_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_creation_entry_available_provider.g.dart';

@riverpod
bool replayCreationEntryAvailable(Ref ref, {required DateTime? originTime}) {
  final range = ref.watch(replayCreationSelectableRangeProvider).value;
  return ref.watch(debugAccessLevelProvider) != DebugAccessLevel.none &&
      originTime != null &&
      range != null &&
      ref
          .watch(replayCreationRangeResolverProvider)
          .contains(range: range, time: originTime);
}
