import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/live_activity/data/model/debug_live_activity_session.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'debug_live_activity_repository.g.dart';

@Riverpod(keepAlive: true)
Future<DebugLiveActivityRepository> debugLiveActivityRepository(Ref ref) async =>
    DebugLiveActivityRepository(api: await ref.watch(apiClientProvider.future));

class DebugLiveActivityRepository {
  const DebugLiveActivityRepository({required api.ApiClient api}) : _api = api;

  final api.ApiClient _api;

  Future<Result<DebugLiveActivitySession, Exception>> start({
    required api.LiveActivityStartTrigger startTrigger,
    api.LiveActivityContentState? contentState,
    api.Alert? alert,
  }) => Result.capture(() async {
    final response = await _api.device.postV2DeviceMeLiveActivityTest(
      body: api.TestLiveActivityStartRequest(
        startTrigger: startTrigger,
        contentState: contentState,
        alert: alert,
      ),
    );
    final data = response.data;
    return DebugLiveActivitySession(
      liveActivityId: data.liveActivityId,
      eventId: data.eventId,
      startTrigger: data.startTrigger,
    );
  });

  Future<Result<api.TestLiveActivitySendResponse, Exception>> update({
    required String liveActivityId,
    required api.LiveActivityContentState contentState,
  }) => Result.capture(() async {
    final response = await _api.device
        .postV2DeviceMeLiveActivityTestLiveActivityIdUpdate(
          liveActivityId: liveActivityId,
          body: api.TestLiveActivityUpdateRequest(contentState: contentState),
        );
    return response.data;
  });

  Future<Result<api.TestLiveActivitySendResponse, Exception>> end({
    required String liveActivityId,
    api.LiveActivityContentState? contentState,
  }) => Result.capture(() async {
    final response = await _api.device
        .postV2DeviceMeLiveActivityTestLiveActivityIdEnd(
          liveActivityId: liveActivityId,
          body: api.TestLiveActivityEndRequest(contentState: contentState),
        );
    return response.data;
  });
}
