import 'package:eqmonitor/feature/live_monitor/data/model/live_monitor_map_focus.dart';
import 'package:eqmonitor/feature/live_monitor/ui/components/live_monitor_map_host.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('LiveMonitor の地理範囲を MapLibre の方角へ対応付ける', () {
    const bounds = LiveMonitorGeoBounds(
      minLat: 30,
      maxLat: 45,
      minLng: 125,
      maxLng: 150,
    );

    final converted = bounds.toLngLatBounds();

    expect(converted.longitudeWest, 125);
    expect(converted.longitudeEast, 150);
    expect(converted.latitudeSouth, 30);
    expect(converted.latitudeNorth, 45);
  });

  test('LiveMonitor の各辺 padding を EdgeInsets へ対応付ける', () {
    const padding = LiveMonitorMapPadding(
      top: 10,
      right: 20,
      bottom: 30,
      left: 40,
    );

    expect(padding.toEdgeInsets(), const EdgeInsets.fromLTRB(40, 10, 20, 30));
  });
}
