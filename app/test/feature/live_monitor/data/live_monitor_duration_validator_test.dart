import 'package:eqmonitor/feature/live_monitor/data/logic/live_monitor_duration_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('整数3〜300だけを受理する', () {
    expect(validateLiveMonitorDuration('3').seconds, 3);
    expect(validateLiveMonitorDuration('300').seconds, 300);
    expect(
      validateLiveMonitorDuration('').error,
      LiveMonitorDurationValidationError.empty,
    );
    expect(
      validateLiveMonitorDuration('3.5').error,
      LiveMonitorDurationValidationError.notInteger,
    );
    expect(
      validateLiveMonitorDuration('301').error,
      LiveMonitorDurationValidationError.outOfRange,
    );
  });

  test('保存中に再編集した入力は保存済み値で上書きしない', () {
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        didCommit: true,
        hasFocus: false,
        currentRaw: '60',
        currentRevision: 1,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isTrue,
    );
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        didCommit: true,
        hasFocus: true,
        currentRaw: '60',
        currentRevision: 1,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isFalse,
    );
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        didCommit: true,
        hasFocus: false,
        currentRaw: '90',
        currentRevision: 2,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isFalse,
    );
  });

  test('保存失敗時は同じ入力でも保存済み値を反映しない', () {
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        didCommit: false,
        hasFocus: false,
        currentRaw: '60',
        currentRevision: 1,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isFalse,
    );
  });

  test('保存に成功した世代と一致するdraftだけを破棄する', () {
    expect(
      shouldClearLiveMonitorDurationDraft(
        didCommit: true,
        currentRaw: '60',
        currentRevision: 1,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isTrue,
    );
    expect(
      shouldClearLiveMonitorDurationDraft(
        didCommit: false,
        currentRaw: '60',
        currentRevision: 1,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isFalse,
    );
    expect(
      shouldClearLiveMonitorDurationDraft(
        didCommit: true,
        currentRaw: '90',
        currentRevision: 2,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isFalse,
    );
  });

  test('同じrawに戻っても古い世代の保存でdraftを破棄しない', () {
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        didCommit: true,
        hasFocus: false,
        currentRaw: '60',
        currentRevision: 3,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isFalse,
    );
    expect(
      shouldClearLiveMonitorDurationDraft(
        didCommit: true,
        currentRaw: '60',
        currentRevision: 3,
        committedRaw: '60',
        committedRevision: 1,
      ),
      isFalse,
    );
  });
}
