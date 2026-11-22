import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'replay_control_panel_expanded_notifier.g.dart';

@riverpod
class ReplayControlPanelExpanded extends _$ReplayControlPanelExpanded {
  @override
  bool build() => false;

  void toggle() => state = !state;

  void collapse() => state = false;
}
