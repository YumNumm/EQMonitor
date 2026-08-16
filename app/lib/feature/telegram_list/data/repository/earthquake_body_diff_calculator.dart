import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_intensity_region_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_quake_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'earthquake_body_diff_calculator.g.dart';

@riverpod
EarthquakeBodyDiffCalculator earthquakeBodyDiffCalculator(Ref ref) =>
    const EarthquakeBodyDiffCalculator();

class EarthquakeBodyDiffCalculator {
  const EarthquakeBodyDiffCalculator();

  /// [current] が現報、[previous] が前報の震度地域リスト。
  /// [previous] が null または空の場合は初報扱いで全て [IntensityDiffType.same]。
  List<IntensityRegionDiffEntry> computeIntensityRegionDiff({
    required List<EarthquakeTelegramBodyIntensityRegionModel> current,
    List<EarthquakeTelegramBodyIntensityRegionModel>? previous,
  }) {
    final currentEntries = [
      for (final entry in current)
        if (entry.intensity case final intensity?)
          (entry: entry, intensity: intensity),
    ];

    if (previous == null || previous.isEmpty) {
      return [
        for (final (:entry, :intensity) in currentEntries)
          IntensityRegionDiffEntry(
            code: entry.code,
            name: entry.name,
            intensity: intensity,
            diffType: IntensityDiffType.same,
          ),
      ];
    }

    final previousIntensityByCode = Map.fromEntries([
      for (final entry in previous)
        ?switch (entry.intensity) {
          final intensity? => MapEntry(entry.code, intensity),
          null => null,
        },
    ]);

    return [
      for (final (:entry, :intensity) in currentEntries)
        computeIntensityRegionDiffEntry(
          entry: entry,
          intensity: intensity,
          previousIntensity: previousIntensityByCode[entry.code],
        ),
    ];
  }

  /// 差分がない場合は null を返す。
  HypocenterDiff? computeHypocenterDiff({
    required EarthquakeTelegramBodyQuakeModel? current,
    EarthquakeTelegramBodyQuakeModel? previous,
  }) {
    if (current == null) {
      return null;
    }

    final diff = HypocenterDiff(
      oldMagnitude: previous?.magnitude,
      newMagnitude: current.magnitude,
      oldDepth: previous?.depth,
      newDepth: current.depth,
      oldEpicenterName: previous?.epicenterName,
      newEpicenterName: current.epicenterName,
      oldMaxIntensity: previous?.maxIntensity,
      newMaxIntensity: current.maxIntensity,
    );

    if (!diff.hasAnyChange()) {
      return null;
    }

    return diff;
  }

  IntensityRegionDiffEntry computeIntensityRegionDiffEntry({
    required EarthquakeTelegramBodyIntensityRegionModel entry,
    required JmaIntensity intensity,
    required JmaIntensity? previousIntensity,
  }) {
    if (previousIntensity == null) {
      return IntensityRegionDiffEntry(
        code: entry.code,
        name: entry.name,
        intensity: intensity,
        diffType: IntensityDiffType.added,
      );
    }

    final currentOrder = intensity.orderIndex;
    final previousOrder = previousIntensity.orderIndex;

    if (currentOrder > previousOrder) {
      return IntensityRegionDiffEntry(
        code: entry.code,
        name: entry.name,
        intensity: intensity,
        diffType: IntensityDiffType.upgraded,
        previousIntensity: previousIntensity,
      );
    }

    if (currentOrder < previousOrder) {
      return IntensityRegionDiffEntry(
        code: entry.code,
        name: entry.name,
        intensity: intensity,
        diffType: IntensityDiffType.downgraded,
        previousIntensity: previousIntensity,
      );
    }

    return IntensityRegionDiffEntry(
      code: entry.code,
      name: entry.name,
      intensity: intensity,
      diffType: IntensityDiffType.same,
    );
  }
}
