import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// JMA標準パレットの正準値（H-5 決定）。
///
/// このマップは `IntensityColorModel.jma()` から取得せず、独立に再宣言している。
/// これにより色定数を「自分自身」と比較するトートロジーを避け、片側が
/// 書き換わると本テストが必ず失敗する。
///
/// backend `seismic-intensity-geojson` 側の `INTENSITY_FILL_COLORS`
/// （`src/intensity-colors.ts` / `src/__tests__/intensity-colors.test.ts`）
/// にも同一の値を置いており、両リポジトリのCIで突き合わせを担保している。
/// backendは GeoJSON で出力する震度4〜7（および5-）のみを保持するため、
/// 突き合わせ対象もその範囲とする。
const _expectedJmaBackgrounds = <IntensityColorTarget, Color>{
  IntensityColorTarget.four: Color.fromARGB(255, 250, 230, 160), // #FAE6A0
  IntensityColorTarget.fiveLower: Color.fromARGB(255, 255, 230, 0), // #FFE600
  IntensityColorTarget.fiveUpper: Color.fromARGB(255, 255, 153, 0), // #FF9900
  IntensityColorTarget.sixLower: Color.fromARGB(255, 255, 40, 0), // #FF2800
  IntensityColorTarget.sixUpper: Color.fromARGB(255, 165, 0, 33), // #A50021
  IntensityColorTarget.seven: Color.fromARGB(255, 180, 0, 104), // #B40068
};

void main() {
  group('IntensityColorModel.jma', () {
    final jma = IntensityColorModel.jma();

    test('JMA標準パレット（正準値）の背景色と一致する', () {
      for (final entry in _expectedJmaBackgrounds.entries) {
        final actual = jma.fromTarget(entry.key).background;
        expect(
          actual,
          entry.value,
          reason: '震度 ${entry.key.label} の背景色がJMA標準と一致しません',
        );
      }
    });

    test('震度4はJMA標準の #FAE6A0 (ARGB 255,250,230,160) である', () {
      expect(
        jma.fromTarget(IntensityColorTarget.four).background,
        const Color.fromARGB(255, 250, 230, 160),
      );
    });
  });
}
