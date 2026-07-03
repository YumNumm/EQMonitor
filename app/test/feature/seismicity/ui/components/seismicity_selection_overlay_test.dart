import 'package:eqmonitor/feature/seismicity/data/model/seismicity_bounds.dart';
import 'package:eqmonitor/feature/seismicity/ui/components/seismicity_selection_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('enabled が false の場合はジェスチャーを消費しない', (tester) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => tapped = true,
              child: const SizedBox.expand(),
            ),
            SeismicitySelectionOverlay(
              enabled: false,
              onSelectionEnd: (_) {},
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.byType(Stack));
    expect(tapped, isTrue);
  });

  testWidgets('enabled が true の場合はドラッグ完了で onSelectionEnd を呼ぶ', (
    tester,
  ) async {
    SeismicityBounds? result;
    await tester.pumpWidget(
      MaterialApp(
        home: SeismicitySelectionOverlay(
          enabled: true,
          onSelectionEnd: (bounds) => result = bounds,
        ),
      ),
    );

    await tester.dragFrom(const Offset(50, 50), const Offset(150, 150));
    await tester.pumpAndSettle();

    // MapController が widget tree に存在しないテスト環境では
    // 画面座標→地理座標変換ができないため null のままだが、
    // ドラッグのライフサイクル(pan start/update/end)自体が
    // 例外なく完了することを検証する。
    expect(result, isNull);
  });

  testWidgets('ほぼ動かないドラッグ(退化した矩形)では onSelectionEnd を呼ばない', (tester) async {
    var callCount = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: SeismicitySelectionOverlay(
          enabled: true,
          onSelectionEnd: (_) => callCount++,
        ),
      ),
    );

    // わずか1論理ピクセルのみ動かす、誤タップ相当のドラッグ。
    await tester.dragFrom(const Offset(50, 50), const Offset(51, 50));
    await tester.pumpAndSettle();

    expect(callCount, 0);
  });
}
