import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_hypocenter_information_card.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_earthquake_card_presenter.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_earthquake_publication_card.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_measured_card_overlay.dart';
import 'package:flutter/material.dart';

class LiveMonitorEarthquakeOverlay extends StatelessWidget {
  const LiveMonitorEarthquakeOverlay({
    required this.earthquake,
    required this.presentation,
    required this.initialNow,
    required this.onTopHeightChanged,
    required this.onBottomHeightChanged,
    super.key,
  });

  final Earthquake earthquake;
  final LiveMonitorEarthquakePresentation presentation;
  final DateTime initialNow;
  final ValueChanged<double> onTopHeightChanged;
  final ValueChanged<double> onBottomHeightChanged;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Align(
        alignment: Alignment.topLeft,
        child: LiveMonitorMeasuredCardOverlay(
          onHeightChanged: onTopHeightChanged,
          child: switch (presentation.publicationAt) {
            final DateTime reportedAt => LiveMonitorEarthquakePublicationCard(
              reportedAt: reportedAt,
              initialNow: initialNow,
            ),
            null => const SizedBox.shrink(),
          },
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: LiveMonitorMeasuredCardOverlay(
          onHeightChanged: onBottomHeightChanged,
          child: EarthquakeHypocenterInformationCard(item: earthquake),
        ),
      ),
    ],
  );
}
