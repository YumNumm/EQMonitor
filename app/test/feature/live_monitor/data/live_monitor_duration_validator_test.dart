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
        committedRaw: '60',
      ),
      isTrue,
    );
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        didCommit: true,
        hasFocus: true,
        currentRaw: '60',
        committedRaw: '60',
      ),
      isFalse,
    );
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        didCommit: true,
        hasFocus: false,
        currentRaw: '90',
        committedRaw: '60',
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
        committedRaw: '60',
      ),
      isFalse,
    );
  });

  test('保存に成功した世代と一致するdraftだけを破棄する', () {
    expect(
      shouldClearLiveMonitorDurationDraft(
        didCommit: true,
        currentDraft: '60',
        committedRaw: '60',
      ),
      isTrue,
    );
    expect(
      shouldClearLiveMonitorDurationDraft(
        didCommit: false,
        currentDraft: '60',
        committedRaw: '60',
      ),
      isFalse,
    );
    expect(
      shouldClearLiveMonitorDurationDraft(
        didCommit: true,
        currentDraft: '90',
        committedRaw: '60',
      ),
      isFalse,
    );
  });

  test('同じrawの保存が進行中なら新しい保存を始めない', () {
    expect(
      shouldJoinLiveMonitorDurationSave(inFlightRaw: '60', requestedRaw: '60'),
      isTrue,
    );
    expect(
      shouldJoinLiveMonitorDurationSave(inFlightRaw: '60', requestedRaw: '90'),
      isFalse,
    );
  });
}
