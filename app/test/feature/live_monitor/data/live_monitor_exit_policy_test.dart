import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_exit_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('panel起点の終了確認はpanelが閉じたら継続しない', () {
    expect(
      shouldContinueLiveMonitorExit(
        source: LiveMonitorExitRequestSource.panel,
        isPanelOpen: true,
      ),
      isTrue,
    );
    expect(
      shouldContinueLiveMonitorExit(
        source: LiveMonitorExitRequestSource.panel,
        isPanelOpen: false,
      ),
      isFalse,
    );
  });

  test('system back起点の終了確認はpanel状態に依存しない', () {
    expect(
      shouldContinueLiveMonitorExit(
        source: LiveMonitorExitRequestSource.systemBack,
        isPanelOpen: false,
      ),
      isTrue,
    );
  });
}
