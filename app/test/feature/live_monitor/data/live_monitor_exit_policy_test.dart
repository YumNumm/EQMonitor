import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_exit_policy.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const policy = LiveMonitorExitPolicy();

  test('panel起点の終了確認はpanelが閉じたら継続しない', () {
    expect(
      policy.shouldContinueExit(
        source: LiveMonitorExitRequestSource.panel,
        isPanelOpen: true,
      ),
      isTrue,
    );
    expect(
      policy.shouldContinueExit(
        source: LiveMonitorExitRequestSource.panel,
        isPanelOpen: false,
      ),
      isFalse,
    );
  });

  test('system back起点の終了確認はpanel状態に依存しない', () {
    expect(
      policy.shouldContinueExit(
        source: LiveMonitorExitRequestSource.systemBack,
        isPanelOpen: false,
      ),
      isTrue,
    );
  });

  group('resolveExitDraft', () {
    test('draftなしまたは保存済みなら通常の終了確認へ進む', () {
      expect(
        policy.resolveExitDraft(
          didCommit: true,
          exitingRaw: null,
          exitingRevision: null,
          currentRaw: null,
          currentRevision: null,
        ),
        LiveMonitorExitDraftDecision.continueExit,
      );
      expect(
        policy.resolveExitDraft(
          didCommit: true,
          exitingRaw: '12',
          exitingRevision: 1,
          currentRaw: null,
          currentRevision: null,
        ),
        LiveMonitorExitDraftDecision.continueExit,
      );
    });

    test('現在のdraftを保存できなければ破棄終了確認を要求する', () {
      expect(
        policy.resolveExitDraft(
          didCommit: false,
          exitingRaw: '12',
          exitingRevision: 1,
          currentRaw: '12',
          currentRevision: 1,
        ),
        LiveMonitorExitDraftDecision.confirmDiscard,
      );
    });

    test('保存待機中にdraftが更新されたら新しい入力を破棄せず終了を中止する', () {
      expect(
        policy.resolveExitDraft(
          didCommit: false,
          exitingRaw: '12',
          exitingRevision: 1,
          currentRaw: '13',
          currentRevision: 2,
        ),
        LiveMonitorExitDraftDecision.cancel,
      );
      expect(
        policy.resolveExitDraft(
          didCommit: true,
          exitingRaw: '12',
          exitingRevision: 1,
          currentRaw: '13',
          currentRevision: 2,
        ),
        LiveMonitorExitDraftDecision.cancel,
      );
    });

    test('別経路ですでにdraftが破棄された場合は保存失敗でも終了確認へ進む', () {
      expect(
        policy.resolveExitDraft(
          didCommit: false,
          exitingRaw: '12',
          exitingRevision: 1,
          currentRaw: null,
          currentRevision: null,
        ),
        LiveMonitorExitDraftDecision.continueExit,
      );
    });
  });
}
