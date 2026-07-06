import 'package:eqmonitor/core/startup/startup_profiler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('mark records elapsed micros from injected clock', () {
    var now = 0;
    final profiler = StartupProfiler(clockMicros: () => now);
    now = 1500;
    profiler.mark('firebase_init');
    now = 4200;
    profiler.mark('run_app');

    expect(profiler.timingsMicros, {'firebase_init': 1500, 'run_app': 4200});
  });

  test('measure records an explicit interval', () {
    final profiler = StartupProfiler(clockMicros: () => 0);
    profiler.measure('travel_time_parse', 9000);
    expect(profiler.timingsMicros['travel_time_parse'], 9000);
  });

  test('timingsMicros returns an unmodifiable copy', () {
    final profiler = StartupProfiler(clockMicros: () => 0);
    profiler.mark('a');
    expect(() => profiler.timingsMicros['b'] = 1, throwsUnsupportedError);
  });
}
