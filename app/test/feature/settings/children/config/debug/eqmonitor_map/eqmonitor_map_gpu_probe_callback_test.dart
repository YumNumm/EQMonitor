import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart';
import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('dispose後に遅延到達したresource counterを破棄する', () {
    var isMounted = true;
    final received = <MapGpuResourceCounterSnapshot>[];
    final guard = EqmonitorMapDebugGpuCounterCallbackGuard(
      isMounted: () => isMounted,
      onSnapshot: received.add,
    );
    const beforeDispose = MapGpuResourceCounterSnapshot(
      texture: MapGpuResourceKindCounter.zero,
      topology: MapGpuResourceKindCounter.zero,
      instance: MapGpuResourceKindCounter.zero,
      node: MapGpuResourceKindCounter.zero,
      rendererContextGeneration: 1,
    );
    const afterDispose = MapGpuResourceCounterSnapshot(
      texture: MapGpuResourceKindCounter.zero,
      topology: MapGpuResourceKindCounter.zero,
      instance: MapGpuResourceKindCounter.zero,
      node: MapGpuResourceKindCounter.zero,
      rendererContextGeneration: 2,
    );

    guard.publish(beforeDispose);
    isMounted = false;
    guard.publish(afterDispose);

    expect(received, [same(beforeDispose)]);
  });
}
