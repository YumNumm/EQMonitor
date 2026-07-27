import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_split_ratio.dart';
import 'package:flutter/widgets.dart';
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

  test('portrait SafeArea下のdisplay featureをSplitView local座標へ変換する', () {
    expect(
      liveMonitorDisplayFeatureLocalBounds(
        screenBounds: const Rect.fromLTRB(0, 400, 800, 420),
        splitViewGlobalOrigin: const Offset(0, 24),
        splitViewSize: const Size(800, 752),
      ),
      const Rect.fromLTRB(0, 376, 800, 396),
    );
  });

  test('landscape SafeArea下のdisplay featureをSplitView local座標へ変換する', () {
    expect(
      liveMonitorDisplayFeatureLocalBounds(
        screenBounds: const Rect.fromLTRB(640, 0, 672, 800),
        splitViewGlobalOrigin: const Offset(48, 0),
        splitViewSize: const Size(1232, 800),
      ),
      const Rect.fromLTRB(592, 0, 624, 800),
    );
  });

  test('SplitView外のdisplay featureはlocal boundsを返さない', () {
    expect(
      liveMonitorDisplayFeatureLocalBounds(
        screenBounds: const Rect.fromLTRB(0, 0, 800, 20),
        splitViewGlobalOrigin: const Offset(0, 24),
        splitViewSize: const Size(800, 752),
      ),
      isNull,
    );
  });
}
