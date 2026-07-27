import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/design_system_build_context_x.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/current_location_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_lpgm_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_summary_header.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_event.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class LiveMonitorEarthquakeCard extends ConsumerWidget {
  const LiveMonitorEarthquakeCard({
    required this.earthquake,
    required this.trigger,
    required this.compact,
    required this.now,
    super.key,
  });

  final Earthquake earthquake;
  final LiveMonitorEarthquakeTrigger? trigger;
  final bool compact;
  final DateTime now;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tickerNow = ref.watch(timeTickerProvider()).value ?? now;
    final effectiveTrigger =
        trigger ?? latestSupportedTelegramTrigger(earthquake);
    final displayMode = preferredIntensityMode(
      earthquake: earthquake,
      trigger: effectiveTrigger,
    );
    final latestPublication = latestSupportedTelegramTrigger(earthquake);
    final publicationAt = switch ((latestPublication, effectiveTrigger)) {
      (LiveMonitorTelegramTrigger(:final reportedAt), _) => reportedAt,
      (_, LiveMonitorTelegramTrigger(:final reportedAt)) => reportedAt,
      _ => null,
    };
    final elapsed = publicationAt == null
        ? null
        : tickerNow.toUtc().difference(publicationAt.toUtc());
    final elapsedLabel = switch (elapsed) {
      final Duration value when value.isNegative => null,
      final Duration value when value.inDays > 0 => '${value.inDays}日経過',
      final Duration value when value.inHours > 0 => '${value.inHours}時間経過',
      final Duration value when value.inMinutes > 0 => '${value.inMinutes}分経過',
      final Duration value => '${value.inSeconds}秒経過',
      null => null,
    };
    final triggerLabel = switch (effectiveTrigger) {
      LiveMonitorTelegramTrigger(kind: .vxse51) => '震度速報',
      LiveMonitorTelegramTrigger(kind: .vxse52) => '震源に関する情報',
      LiveMonitorTelegramTrigger(kind: .vxse53) => '震源・震度に関する情報',
      LiveMonitorTelegramTrigger(kind: .vxse61) => '顕著な地震の震源要素更新のお知らせ',
      LiveMonitorTelegramTrigger(kind: .vxse62) => '長周期地震動に関する観測情報',
      LiveMonitorTelegramTrigger() => null,
      LiveMonitorEstimatedIntensityTrigger() => null,
      null => null,
    };
    final triggerAt = switch (effectiveTrigger) {
      LiveMonitorTelegramTrigger(:final reportedAt) => reportedAt,
      LiveMonitorEstimatedIntensityTrigger() => null,
      null => null,
    };
    final generatedAt = switch (trigger) {
      LiveMonitorEstimatedIntensityTrigger(:final generatedAt) => generatedAt,
      _ => null,
    };
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    final spacing = context.designSystem.spacing;
    final colorTheme = context.designSystem.colorTheme;
    final shape = context.designSystem.shape;
    final compactRegions = compact
        ? maximumIntensityRegions(earthquake)
        : const <IntensityRegion>[];
    final regionGroups = compact
        ? const <LiveMonitorIntensityRegionGroup>[]
        : orderedIntensityRegions(earthquake);
    final children = <Widget>[
      if (publicationAt != null)
        Text(
          '最新発表 ${dateFormat.format(publicationAt.toLocal())}'
          '${elapsedLabel == null ? '' : '（$elapsedLabel）'}',
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(color: colorTheme.onSurfaceVariant),
        ),
      if (triggerLabel != null)
        Text(
          '$triggerLabel'
          '${triggerAt == null ? '' : ' ${dateFormat.format(triggerAt.toLocal())}'}',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      EarthquakeSummaryHeader(item: earthquake, showStatusWatermark: true),
      CurrentLocationIntensityCard(item: earthquake),
      if (displayMode == IntensityDisplayMode.lpgm)
        EarthquakeLpgmIntensityCard(item: earthquake),
      if (effectiveTrigger is LiveMonitorEstimatedIntensityTrigger)
        _EstimatedIntensitySummary(generatedAt: generatedAt),
      if (compactRegions.isNotEmpty || regionGroups.isNotEmpty)
        Text(
          compact ? '最大震度を観測した地域' : '地域ごとの震度',
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      for (final region in compactRegions)
        _CompactIntensityRegionRow(region: region),
      for (final group in regionGroups)
        _IntensityRegionGroupRow(
          intensity: group.intensity,
          regions: group.regions,
        ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final maximumHeight = compact && constraints.hasBoundedHeight
            ? constraints.maxHeight * 0.5
            : constraints.maxHeight;
        return Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maximumHeight),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              color: colorTheme.surfaceContainerHigh,
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(shape.card),
                side: BorderSide(color: colorTheme.outlineVariant),
              ),
              child: ListView.separated(
                shrinkWrap: compact,
                padding: EdgeInsets.all(spacing.sm),
                itemCount: children.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: spacing.sm),
                itemBuilder: (context, index) => children[index],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _EstimatedIntensitySummary extends StatelessWidget {
  const _EstimatedIntensitySummary({required this.generatedAt});

  final DateTime? generatedAt;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');
    final generatedAtLabel = switch (generatedAt) {
      final DateTime value => dateFormat.format(value.toLocal()),
      null => null,
    };
    return Row(
      children: [
        const Icon(Icons.layers_outlined),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '推計震度分布'
            '${generatedAtLabel == null ? '' : ' $generatedAtLabel生成'}',
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class _CompactIntensityRegionRow extends StatelessWidget {
  const _CompactIntensityRegionRow({required this.region});

  final IntensityRegion region;

  @override
  Widget build(BuildContext context) {
    final intensity = region.maxIntensity;
    return Row(
      children: [
        if (intensity != null)
          JmaIntensityIcon(intensity: intensity, type: .filled, size: 32),
        if (intensity != null) const SizedBox(width: 8),
        Expanded(child: Text(region.region.name.ja)),
      ],
    );
  }
}

class _IntensityRegionGroupRow extends StatelessWidget {
  const _IntensityRegionGroupRow({
    required this.intensity,
    required this.regions,
  });

  final JmaIntensity intensity;
  final List<IntensityRegion> regions;

  @override
  Widget build(BuildContext context) {
    final spacing = context.designSystem.spacing;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        JmaIntensityIcon(intensity: intensity, type: .filled, size: 40),
        SizedBox(width: spacing.sm),
        Expanded(
          child: Wrap(
            spacing: spacing.sm,
            runSpacing: spacing.xs,
            children: regions
                .map((region) => Text(region.region.name.ja))
                .toList(growable: false),
          ),
        ),
      ],
    );
  }
}
