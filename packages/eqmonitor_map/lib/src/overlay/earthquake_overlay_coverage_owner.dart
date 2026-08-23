import 'package:eqmonitor_map/src/overlay/earthquake_overlay_coverage.dart';
import 'package:flutter/foundation.dart';

/// coverageの最新値と、値変更時だけの通知を所有する。
final class EarthquakeOverlayCoverageOwner {
  EarthquakeOverlayCoverageOwner({this.onChanged});

  var _coverage = const EarthquakeOverlayCoverage.hidden();
  ValueChanged<EarthquakeOverlayCoverage>? onChanged;

  EarthquakeOverlayCoverage get coverage => _coverage;

  void hide() => publish(const EarthquakeOverlayCoverage.hidden());

  void publish(EarthquakeOverlayCoverage next) {
    if (next == _coverage) {
      return;
    }
    _coverage = next;
    onChanged?.call(next);
  }
}
