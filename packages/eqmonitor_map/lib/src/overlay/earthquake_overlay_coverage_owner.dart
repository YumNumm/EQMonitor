import 'package:eqmonitor_map/src/overlay/earthquake_map_overlay_snapshot.dart';
import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:flutter/foundation.dart';

/// commit済みoverlay identityとcoverageの最新値をatomicに所有する。
final class EarthquakeOverlayCoverageOwner {
  EarthquakeOverlayCoverageOwner({this.onChanged});

  var _snapshot = const EarthquakeOverlayCoverageSnapshot.hidden();
  ValueChanged<EarthquakeOverlayCoverageSnapshot>? onChanged;

  EarthquakeOverlayCoverage get coverage => _snapshot.coverage;
  EarthquakeOverlayCoverageSnapshot get snapshot => _snapshot;

  void hide({required EarthquakeMapOverlaySnapshot? overlay}) => publish(
    overlay: overlay,
    coverage: const EarthquakeOverlayCoverage.hidden(),
    diagnostic: const EarthquakeOverlayCoverageDiagnostic.empty(),
  );

  void publish({
    required EarthquakeMapOverlaySnapshot? overlay,
    required EarthquakeOverlayCoverage coverage,
    required EarthquakeOverlayCoverageDiagnostic diagnostic,
  }) {
    final next = overlay == null
        ? const EarthquakeOverlayCoverageSnapshot.hidden()
        : EarthquakeOverlayCoverageSnapshot(
            versionStamp: overlay.versionStamp,
            coverage: coverage,
            diagnostic: diagnostic,
          );
    if (next == _snapshot) {
      return;
    }
    _snapshot = next;
    onChanged?.call(next);
  }
}
