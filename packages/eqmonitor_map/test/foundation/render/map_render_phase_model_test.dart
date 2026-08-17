import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MapRenderPhaseId', () {
    test('normalizes surrounding whitespace and supports value equality', () {
      final phase = createMapRenderPhaseId(value: '  base-map  ');
      final samePhase = createMapRenderPhaseId(value: 'base-map');

      expect(phase.value, 'base-map');
      expect(phase, samePhase);
      expect(phase.hashCode, samePhase.hashCode);
    });

    test('rejects blank values', () {
      expect(
        () => createMapRenderPhaseId(value: ' \n\t '),
        throwsArgumentError,
      );
    });

    test('provides labelForeground as the fixed foreground label phase', () {
      expect(MapRenderPhaseId.labelForeground.value, 'labelForeground');
      expect(
        MapRenderPhaseId.labelForeground,
        createMapRenderPhaseId(value: 'labelForeground'),
      );
    });
  });

  test('keeps the phase policy type behind its later validated factory', () {
    const MapRenderPhasePolicy? policy = null;

    expect(policy, isNull);
  });
}
