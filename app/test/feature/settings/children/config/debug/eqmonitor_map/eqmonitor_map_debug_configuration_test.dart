import 'package:eqmonitor/feature/settings/children/config/debug/eqmonitor_map/eqmonitor_map_debug_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('debug mapはsprite resource上限をcaller側で明示する', () {
    final limits = EqmonitorMapDebugConfiguration.limitsFor(
      minZoom: 2,
      maxZoom: 12,
    );

    expect(limits.spriteRendererLimits.maxActiveAtlases, 1);
    expect(limits.spriteRendererLimits.maxTopologyVariants, 1);
    expect(limits.spriteRendererLimits.maxPolicyBatches, 1);
  });
}
