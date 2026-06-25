import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart'
    as data_prefs;
import 'package:eqmonitor/feature/telemetry/data/provider/telemetry_recorder_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:telemetry_store/telemetry_store.dart';

part 'app_launch_recorder_provider.g.dart';

@Riverpod(keepAlive: true)
Future<AppLaunchRecorder> appLaunchRecorder(Ref ref) async {
  final recorder = ref.watch(telemetryRecorderProvider);
  final prefs = await ref.watch(data_prefs.sharedPreferencesProvider.future);
  return AppLaunchRecorder(recorder, prefs);
}
