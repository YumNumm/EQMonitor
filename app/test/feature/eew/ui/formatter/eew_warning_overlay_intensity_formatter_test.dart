import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_warning_overlay_display_model.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_intensity_formatter.dart';
import 'package:eqmonitor/feature/eew/ui/formatter/eew_warning_overlay_label_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const intensityFormatter = EewWarningOverlayIntensityFormatter();
  const labelFormatter = EewWarningOverlayLabelFormatter();

  test('formats split JMA intensities with Japanese suffixes', () {
    expect(
      intensityFormatter.format(
        intensity: JmaIntensity.fiveLower,
        isOver: false,
      ),
      '5弱',
    );
    expect(
      intensityFormatter.format(
        intensity: JmaIntensity.fiveUpper,
        isOver: false,
      ),
      '5強',
    );
    expect(
      intensityFormatter.format(
        intensity: JmaIntensity.sixLower,
        isOver: false,
      ),
      '6弱',
    );
    expect(
      intensityFormatter.format(
        intensity: JmaIntensity.sixUpper,
        isOver: false,
      ),
      '6強',
    );
  });

  test('formats unknown and over values without duplicated qualifiers', () {
    expect(
      intensityFormatter.format(intensity: JmaIntensity.unknown, isOver: true),
      '不明',
    );
    expect(
      intensityFormatter.format(
        intensity: JmaIntensity.fiveUnknown,
        isOver: true,
      ),
      '5弱以上',
    );
    expect(
      intensityFormatter.format(intensity: JmaIntensity.sixLower, isOver: true),
      '6弱以上',
    );
  });

  test('fixed simulation intensity copy is 6弱', () {
    expect(
      intensityFormatter.format(
        intensity: JmaIntensity.sixLower,
        isOver: false,
      ),
      '6弱',
    );
  });

  test('banner label keeps simulation identity', () {
    expect(
      labelFormatter.bannerLabel(
        source: EewWarningOverlaySource.simulation,
        reportLabel: '訓練／シミュレーション',
      ),
      '訓練／シミュレーション',
    );
    expect(
      labelFormatter.bannerLabel(
        source: EewWarningOverlaySource.real,
        reportLabel: '緊急地震速報（警報） 第3報',
      ),
      '緊急地震速報（警報）',
    );
  });
}
