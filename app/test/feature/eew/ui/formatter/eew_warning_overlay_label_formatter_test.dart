import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_label_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const formatter = EewWarningOverlayLabelFormatter();

  test('fullscreen semantics identifies real and simulation sources', () {
    expect(
      formatter.semanticsLabel(source: EewWarningOverlaySource.real),
      '緊急地震速報警報',
    );
    expect(
      formatter.semanticsLabel(source: EewWarningOverlaySource.simulation),
      '訓練／シミュレーションの緊急地震速報',
    );
  });
}
