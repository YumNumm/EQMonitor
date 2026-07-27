import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_split_ratio.dart';
import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_settings.dart';
import 'package:eqmonitor/feature/live_monitor/data/notifier/live_monitor_settings_notifier.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_earthquake_pane.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_realtime_pane.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_split_viewport_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorSplitView extends HookConsumerWidget {
  const LiveMonitorSplitView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final orientation = mediaQuery.orientation;
    final isPortrait = orientation == Orientation.portrait;
    final avoidBounds = DisplayFeatureSubScreen.avoidBounds(
      mediaQuery,
    ).toList(growable: false);
    final settings =
        ref.watch(liveMonitorSettingsProvider).value ??
        const LiveMonitorSettings();
    final storedRatio = isPortrait
        ? settings.portraitRealtimeRatio
        : settings.landscapeRealtimeRatio;
    final localRatio = useMemoized(() => ValueNotifier(storedRatio), [
      orientation,
      storedRatio,
    ]);
    useListenable(localRatio);
    useEffect(() {
      return localRatio.dispose;
    }, [localRatio]);
    final viewportMeasurement = useState<LiveMonitorSplitViewportMeasurement?>(
      null,
    );

    final Future<void> Function() saveRatio = () async {
      final ratio = localRatio.value;
      await LiveMonitorSettingsNotifier.saveMutation.run(ref, (tsx) async {
        final current = await tsx.get(liveMonitorSettingsProvider.future);
        final updated = isPortrait
            ? current.copyWith(portraitRealtimeRatio: ratio)
            : current.copyWith(landscapeRealtimeRatio: ratio);
        await tsx.get(liveMonitorSettingsProvider.notifier).save(updated);
      });
    };

    return SizedBox.expand(
      child: LiveMonitorSplitViewportObserver(
        active: avoidBounds.isNotEmpty,
        environment: (
          screenSize: mediaQuery.size,
          viewPadding: mediaQuery.viewPadding,
          viewInsets: mediaQuery.viewInsets,
          orientation: orientation,
        ),
        onMeasurementChanged: (measurement) {
          if (viewportMeasurement.value != measurement) {
            viewportMeasurement.value = measurement;
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final totalExtent = isPortrait
                ? constraints.maxHeight
                : constraints.maxWidth;
            final standardDividerExtent = totalExtent < 24 ? totalExtent : 24.0;
            final availableExtent = totalExtent - standardDividerExtent;
            final measurement = viewportMeasurement.value;
            final measurementIsCurrent =
                measurement != null &&
                isLiveMonitorSplitViewportMeasurementCurrent(
                  measuredViewportSize: measurement.viewportSize,
                  currentViewportSize: constraints.biggest,
                ) &&
                measurement.screenSize == mediaQuery.size &&
                measurement.viewPadding == mediaQuery.viewPadding &&
                measurement.viewInsets == mediaQuery.viewInsets &&
                measurement.orientation == orientation;
            final splitViewGlobalOrigin = measurementIsCurrent
                ? measurement.globalOrigin
                : null;
            final awaitingViewportMeasurement =
                avoidBounds.isNotEmpty && splitViewGlobalOrigin == null;
            Rect? splitDisplayFeatureBounds;
            for (final screenBounds in avoidBounds) {
              final bounds = switch (splitViewGlobalOrigin) {
                final Offset origin => liveMonitorDisplayFeatureLocalBounds(
                  screenBounds: screenBounds,
                  splitViewGlobalOrigin: origin,
                  splitViewSize: constraints.biggest,
                ),
                null => null,
              };
              if (bounds == null) {
                continue;
              }
              final splitsInLayoutDirection = isPortrait
                  ? bounds.width >= constraints.maxWidth
                  : bounds.height >= constraints.maxHeight;
              if (splitsInLayoutDirection) {
                splitDisplayFeatureBounds = bounds;
                break;
              }
            }

            final featureStart = switch (splitDisplayFeatureBounds) {
              final Rect bounds when isPortrait => bounds.top,
              final Rect bounds => bounds.left,
              null => null,
            };
            final featureEnd = switch (splitDisplayFeatureBounds) {
              final Rect bounds when isPortrait => bounds.bottom,
              final Rect bounds => bounds.right,
              null => null,
            };
            final hasSplitDisplayFeature =
                featureStart != null && featureEnd != null;
            final featureCenter = hasSplitDisplayFeature
                ? (featureStart + featureEnd) / 2
                : 0.0;
            final featureRawExtent = hasSplitDisplayFeature
                ? featureEnd - featureStart
                : 0.0;
            final featureDividerExtent = featureRawExtent < 24
                ? 24.0
                : featureRawExtent;
            final featureDividerStart =
                (featureCenter - featureDividerExtent / 2)
                    .clamp(0.0, totalExtent)
                    .toDouble();
            final adaptiveDividerExtent = featureDividerExtent
                .clamp(0.0, totalExtent - featureDividerStart)
                .toDouble();
            final primaryExtent = hasSplitDisplayFeature
                ? featureDividerStart
                : availableExtent * localRatio.value;
            final dividerExtent = hasSplitDisplayFeature
                ? adaptiveDividerExtent
                : standardDividerExtent;
            final secondaryExtent = totalExtent - primaryExtent - dividerExtent;
            final colorScheme = Theme.of(context).colorScheme;
            final divider = Semantics(
              label: hasSplitDisplayFeature ? '画面の折りたたみ領域' : 'リアルタイム表示の分割割合',
              value: hasSplitDisplayFeature
                  ? null
                  : '${(localRatio.value * 100).round()}%',
              child: MouseRegion(
                cursor: hasSplitDisplayFeature
                    ? MouseCursor.defer
                    : isPortrait
                    ? SystemMouseCursors.resizeUpDown
                    : SystemMouseCursors.resizeLeftRight,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanUpdate: hasSplitDisplayFeature
                      ? null
                      : (details) {
                          final primaryDelta = isPortrait
                              ? details.delta.dy
                              : details.delta.dx;
                          localRatio.value = updateLiveMonitorSplitRatio(
                            current: localRatio.value,
                            primaryDelta: primaryDelta,
                            availableExtent: availableExtent,
                          );
                        },
                  onPanEnd: hasSplitDisplayFeature
                      ? null
                      : (_) async {
                          await saveRatio();
                        },
                  onPanCancel: hasSplitDisplayFeature
                      ? null
                      : () async {
                          await saveRatio();
                        },
                  child: Center(
                    child: SizedBox(
                      width: isPortrait ? double.infinity : 1,
                      height: isPortrait ? 1 : double.infinity,
                      child: ColoredBox(color: colorScheme.outlineVariant),
                    ),
                  ),
                ),
              ),
            );

            return IgnorePointer(
              ignoring: awaitingViewportMeasurement,
              child: Opacity(
                opacity: awaitingViewportMeasurement ? 0 : 1,
                child: Flex(
                  direction: isPortrait ? Axis.vertical : Axis.horizontal,
                  children: [
                    SizedBox(
                      width: isPortrait ? null : primaryExtent,
                      height: isPortrait ? primaryExtent : null,
                      child: const LiveMonitorRealtimePane(
                        key: ValueKey('live-monitor-realtime-map'),
                      ),
                    ),
                    SizedBox(
                      width: isPortrait ? null : dividerExtent,
                      height: isPortrait ? dividerExtent : null,
                      child: divider,
                    ),
                    SizedBox(
                      width: isPortrait ? null : secondaryExtent,
                      height: isPortrait ? secondaryExtent : null,
                      child: const LiveMonitorEarthquakePane(
                        key: ValueKey('live-monitor-earthquake-map'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
