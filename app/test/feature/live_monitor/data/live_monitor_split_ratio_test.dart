import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_split_ratio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('drag deltaをPane比率へ変換する', () {
    expect(
      updateLiveMonitorSplitRatio(
        current: 0.5,
        primaryDelta: 100,
        availableExtent: 1000,
      ),
      0.6,
    );
  });

  test('drag後のPane比率を0.2〜0.8へ制限する', () {
    expect(
      updateLiveMonitorSplitRatio(
        current: 0.75,
        primaryDelta: 200,
        availableExtent: 1000,
      ),
      0.8,
    );
    expect(
      updateLiveMonitorSplitRatio(
        current: 0.25,
        primaryDelta: -200,
        availableExtent: 1000,
      ),
      0.2,
    );
  });

  test('利用可能範囲が0以下なら現在比率を制限して維持する', () {
    expect(
      updateLiveMonitorSplitRatio(
        current: 0.9,
        primaryDelta: -100,
        availableExtent: 0,
      ),
      0.8,
    );
    expect(
      updateLiveMonitorSplitRatio(
        current: 0.1,
        primaryDelta: 100,
        availableExtent: -1000,
      ),
      0.2,
    );
  });
}
