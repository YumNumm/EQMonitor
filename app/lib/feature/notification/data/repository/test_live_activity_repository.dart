import 'package:eqmonitor/feature/notification/data/model/test_live_activity_status.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/controller/live_activity_local_controller.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_preset.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_live_activity_repository.g.dart';

@riverpod
TestLiveActivityRepository testLiveActivityRepository(Ref ref) =>
    TestLiveActivityRepository(
      controller: ref.watch(liveActivityLocalControllerProvider),
      builder: ref.watch(debugLiveActivityContentBuilderProvider),
    );

class const TestLiveActivityRepository({
  required final LiveActivityLocalController controller,
  required final DebugLiveActivityContentBuilder builder,
}) {
  Future<TestLiveActivityStatus> status() async => TestLiveActivityStatus(
    isSupported: await controller.isSupported(),
    isActive: await controller.hasTestActivity(),
  );

  Future<void> show(DebugEewPreset preset) async {
    final content = builder.eewFromPreset(
      preset: preset,
      eventId: 'eqmonitor-local-test-eew',
      now: DateTime.now(),
    );
    await controller.showTestActivity(contentState: content);
  }

  Future<void> end() => controller.endTestActivity();
}
