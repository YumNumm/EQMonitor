import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_publication_time_formatter.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LiveMonitorEarthquakePublicationCard extends ConsumerWidget {
  const LiveMonitorEarthquakePublicationCard({
    required this.reportedAt,
    required this.initialNow,
    super.key,
  });

  final DateTime reportedAt;
  final DateTime initialNow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now =
        ref.watch(timeTickerProvider(const Duration(minutes: 1))).value ??
        initialNow;
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Text(
          const LiveMonitorPublicationTimeFormatter().format(
            reportedAt: reportedAt,
            now: now,
          ),
        ),
      ),
    );
  }
}
