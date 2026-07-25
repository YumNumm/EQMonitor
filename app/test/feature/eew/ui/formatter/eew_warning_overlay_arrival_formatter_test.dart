import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_arrival_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('arrival text distinguishes future, arrived, and unknown', () {
    expect(
      formatEewWarningOverlayArrival(
        state: EewWarningArrivalState.unarrived,
        secondsUntilArrival: 10,
      ),
      'あと約10秒',
    );
    expect(
      formatEewWarningOverlayArrival(
        state: EewWarningArrivalState.arrived,
        secondsUntilArrival: null,
      ),
      '到達と推定',
    );
    expect(
      formatEewWarningOverlayArrival(
        state: EewWarningArrivalState.unknown,
        secondsUntilArrival: null,
      ),
      isNull,
    );
  });

  test('unarrived without remaining seconds stays unknown', () {
    expect(
      formatEewWarningOverlayArrival(
        state: EewWarningArrivalState.unarrived,
        secondsUntilArrival: null,
      ),
      isNull,
    );
  });
}
