import 'package:eqmonitor/feature/home/ui/component/map/layer/kyoshin_monitor_observation_layer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('marker size変更では同じ source の layer 定義だけが変わる', () {
    const builder = KyoshinMonitorObservationLayerBuilder();
    final small = builder.build(radiusScaleFactor: 0.65);
    final large = builder.build(radiusScaleFactor: 1.35);

    expect(small.sourceId, large.sourceId);
    expect(
      small.paint['circle-stroke-width'],
      isNot(large.paint['circle-stroke-width']),
    );
  });
}
