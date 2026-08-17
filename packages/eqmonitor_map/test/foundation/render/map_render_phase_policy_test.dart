import 'package:eqmonitor_map/src/foundation/render/map_render_phase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final background = createMapRenderPhaseId(value: 'background');

  test('preserves caller order without retaining its list alias', () {
    final phases = [background, MapRenderPhaseId.labelForeground];
    final policy = createMapRenderPhasePolicy(
      version: 2,
      orderedPhases: phases,
    );
    phases.removeAt(0);

    expect(policy.version, 2);
    expect(policy.orderedPhases, [
      background,
      MapRenderPhaseId.labelForeground,
    ]);
    expect(policy.rankOf(background), 0);
    expect(policy.rankOf(MapRenderPhaseId.labelForeground), 1);
    expect(() => policy.orderedPhases.add(background), throwsUnsupportedError);
    final unknown = createMapRenderPhaseId(value: 'unknown');
    expect(() => policy.rankOf(unknown), throwsArgumentError);
  });

  test('rejects invalid version and phase orders', () {
    for (final version in [0, -1]) {
      expect(
        () => createMapRenderPhasePolicy(
          version: version,
          orderedPhases: [MapRenderPhaseId.labelForeground],
        ),
        throwsArgumentError,
      );
    }
    for (final phases in [
      <MapRenderPhaseId>[],
      [
        MapRenderPhaseId.labelForeground,
        createMapRenderPhaseId(value: 'labelForeground'),
      ],
      [background],
    ]) {
      expect(
        () => createMapRenderPhasePolicy(version: 1, orderedPhases: phases),
        throwsArgumentError,
      );
    }
  });
}
