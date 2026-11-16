import 'package:eqmonitor/core/provider/travel_time/provider/travel_time_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shake_eew_correlator/shake_eew_correlator.dart';

part 'shake_eew_correlator_provider.g.dart';

@Riverpod(keepAlive: true)
Future<ShakeEewCorrelator> shakeEewCorrelator(Ref ref) async {
  final tables = await ref.watch(travelTimeInternalProvider.future);
  return ShakeEewCorrelator(
    travelTimeTable: TravelTimeTable(
      entries: [
        for (final row in tables.table)
          TravelTimeEntry(
            pSeconds: row.p,
            sSeconds: row.s,
            depth: row.depth.toDouble(),
            distance: row.distance.toDouble(),
          ),
      ],
    ),
  );
}
