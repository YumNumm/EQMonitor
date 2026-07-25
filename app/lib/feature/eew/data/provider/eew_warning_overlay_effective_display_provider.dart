import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/data/notifier/eew_warning_overlay_simulation_notifier.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_display_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_effective_display_provider.g.dart';

@riverpod
EewWarningOverlayDisplayModel? eewWarningOverlayEffectiveDisplay(Ref ref) {
  final real = ref.watch(eewWarningOverlayDisplayProvider);
  final simulation = ref.watch(eewWarningOverlaySimulationProvider);
  return real ?? simulation;
}
