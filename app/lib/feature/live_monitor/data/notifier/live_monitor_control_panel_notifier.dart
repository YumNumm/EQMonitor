import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'live_monitor_control_panel_notifier.g.dart';

@riverpod
class LiveMonitorControlPanelNotifier
    extends _$LiveMonitorControlPanelNotifier {
  @override
  bool build() => false;

  void open() => state = true;

  void close() => state = false;
}
