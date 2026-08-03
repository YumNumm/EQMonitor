import 'package:eqmonitor_map/src/flutter_scene/spike_frame_timing_collector.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('keeps aggregate timings without retaining every frame', () {
    final collector = SpikeFrameTimingCollector(capacity: 120);
    for (var index = 0; index < 240; index++) {
      collector.add(
        buildDuration: Duration(microseconds: 1000 + index),
        rasterDuration: Duration(microseconds: 2000 + index),
      );
    }
    expect(collector.sampleCount, 240);
    expect(collector.retainedSampleCount, 120);
    expect(collector.snapshot().maxRasterDurationMicroseconds, 2239);
  });
}
