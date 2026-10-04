import 'package:eqmonitor/feature/notification/data/model/test_live_activity_status.dart';
import 'package:eqmonitor/feature/notification/data/repository/test_live_activity_repository.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_live_activity_notifier.g.dart';

@riverpod
class TestLiveActivityNotifier extends _$TestLiveActivityNotifier {
  @override
  Future<TestLiveActivityStatus> build() =>
      ref.watch(testLiveActivityRepositoryProvider).status();

  static final showMutation = Mutation<void>();

  Future<void> show(DebugEewPreset preset) async {
    final repository = ref.read(testLiveActivityRepositoryProvider);
    await repository.show(preset);
    state = AsyncData(await repository.status());
  }

  static final endMutation = Mutation<void>();

  Future<void> end() async {
    final repository = ref.read(testLiveActivityRepositoryProvider);
    await repository.end();
    state = AsyncData(await repository.status());
  }
}
