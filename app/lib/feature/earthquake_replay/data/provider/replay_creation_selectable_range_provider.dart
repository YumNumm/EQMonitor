import 'package:eqmonitor/feature/earthquake_replay/data/logic/replay_creation_range_resolver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_creation_selectable_range_provider.g.dart';

@riverpod
Stream<ReplayCreationRange> replayCreationSelectableRange(Ref ref) async* {
  final resolver = ref.watch(replayCreationRangeResolverProvider);
  yield resolver.selectableRange();
  yield* Stream.periodic(
    const Duration(seconds: 10),
    (_) => resolver.selectableRange(),
  );
}
