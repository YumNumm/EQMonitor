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
        hasFocus: false,
        currentRaw: '60',
        committedRaw: '60',
      ),
      isTrue,
    );
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        hasFocus: true,
        currentRaw: '60',
        committedRaw: '60',
      ),
      isFalse,
    );
    expect(
      shouldApplyCommittedLiveMonitorDuration(
        hasFocus: false,
        currentRaw: '90',
        committedRaw: '60',
      ),
      isFalse,
    );
  });
}
