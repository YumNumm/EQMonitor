import 'package:eqmonitor/feature/home/component/eew/eew_widget.dart';
import 'package:eqmonitor/feature/home/component/map/home_map_view.dart';
import 'package:eqmonitor/feature/home/component/shake-detect/shake_detection_card.dart';
import 'package:eqmonitor/feature/home/component/sheet/home_earthquake_history_sheet.dart';
import 'package:eqmonitor/feature/shake_detection/provider/shake_detection_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sheet/sheet.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Stack(
        children: [
          HomeMapView(),
          _Sheet(),
        ],
      ),
    );
  }
}

class _Sheet extends StatelessWidget {
  const _Sheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      bottom: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final size = (
            width: constraints.maxWidth,
            height: constraints.maxHeight,
          );
          final isLandscape = size.width > size.height;
          final sheet = Sheet(
            elevation: 4,
            initialExtent: size.height * 0.2,
            physics: const SnapSheetPhysics(
              stops: [0.1, 0.2, 0.5, 1],
            ),
            child: Material(
              color: colorScheme.surfaceContainer,
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: 36,
                    height: 4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    child: Expanded(
                      child: _SheetBody(),
                    ),
                  ),
                ],
              ),
            ),
          );

          if (isLandscape) {
            return Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: size.width * 0.5,
                height: size.height,
                child: sheet,
              ),
            );
          }
          return sheet;
        },
      ),
    );
  }
}

class _SheetBody extends ConsumerWidget {
  const _SheetBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          EewWidgets(),
          _ShakeDetectionList(),
          HomeEarthquakeHistorySheet(),
        ],
      ),
    );
  }
}

class _ShakeDetectionList extends ConsumerWidget {
  const _ShakeDetectionList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shakeDetectionEvents = ref.watch(shakeDetectionProvider);

    return switch (shakeDetectionEvents) {
      AsyncData(:final value) when value.isNotEmpty => Column(
          children: [
            ...value.map(
              (event) => ShakeDetectionCard(event: event),
            ),
          ],
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
