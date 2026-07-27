import 'package:eqmonitor/feature/live_monitor/data/service/live_monitor_scheduler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_scheduler_provider.g.dart';

@riverpod
LiveMonitorScheduler liveMonitorScheduler(Ref ref) {
  final scheduler = LiveMonitorScheduler();
  ref.onDispose(scheduler.cancel);
  return scheduler;
}
