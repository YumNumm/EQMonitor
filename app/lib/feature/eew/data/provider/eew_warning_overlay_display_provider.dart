import 'package:eqmonitor/core/provider/clock/app_clock.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/logic/eew_warning_display_model_builder.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/data/provider/eew_warning_overlay_candidate_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_warning_overlay_display_provider.g.dart';

@riverpod
EewWarningOverlayDisplayModel? eewWarningOverlayDisplay(Ref ref) {
  final candidates = ref.watch(eewWarningOverlayCandidatesProvider);
  if (candidates.isEmpty) {
    return null;
  }
  final ticker = ref.watch(timeTickerProvider());
  final now = ticker.value ?? ref.read(appClockProvider.notifier).now();
  return ref
      .watch(eewWarningDisplayModelBuilderProvider)
      .build(candidates: candidates, now: now.toUtc());
}
