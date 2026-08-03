import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('exports the EQMonitor-only library identity', () {
    expect(eqmonitorMapLibrary.packageName, 'eqmonitor_map');
    expect(eqmonitorMapLibrary.supportedPlatforms, const ['ios', 'android']);
  });
}
