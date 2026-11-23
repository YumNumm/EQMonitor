import 'package:eqmonitor/core/component/sheet/basic_modal_sheet.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

void main() {
  final spacing = DesignSystemThemeExtension.light().spacing.md;

  Future<void> pumpSheet(
    WidgetTester tester, {
    required ValueNotifier<double?> targetHeight,
  }) => tester.pumpWidget(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      home: Scaffold(
        body: BasicModalSheet(
          child: SingleChildScrollView(
            child: ValueListenableBuilder(
              valueListenable: targetHeight,
              builder: (context, height, _) => Column(
                children: [
                  if (height != null)
                    SheetFitTarget(
                      child: SizedBox(key: const Key('target'), height: height),
                    ),
                  const SizedBox(key: Key('rest'), height: 900),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  double sheetTop(WidgetTester tester) =>
      tester.getTopLeft(find.byKey(const Key('rest'))).dy;

  testWidgets('sheet height follows the fit target until the user drags', (
    tester,
  ) async {
    final targetHeight = ValueNotifier<double?>(null);
    addTearDown(targetHeight.dispose);
    await pumpSheet(tester, targetHeight: targetHeight);
    await tester.pumpAndSettle();
    final initialTop = sheetTop(tester);

    targetHeight.value = 260;
    await tester.pumpAndSettle();
    expect(
      tester.getBottomLeft(find.byKey(const Key('target'))).dy,
      closeTo(600 - spacing, 1),
    );

    targetHeight.value = 320;
    await tester.pumpAndSettle();
    expect(
      tester.getBottomLeft(find.byKey(const Key('target'))).dy,
      closeTo(600 - spacing, 1),
    );

    targetHeight.value = null;
    await tester.pumpAndSettle();
    expect(sheetTop(tester), closeTo(initialTop, 1));

    // sheet パッケージはウィジェットテストのドラッグでは動かないため、ドラッグ開始の通知だけを流す。
    final restContext = tester.element(find.byKey(const Key('rest')));
    ScrollStartNotification(
      metrics: FixedScrollMetrics(
        minScrollExtent: 0,
        maxScrollExtent: 0,
        pixels: 0,
        viewportDimension: 0,
        axisDirection: AxisDirection.down,
        devicePixelRatio: 1,
      ),
      context: restContext,
      dragDetails: DragStartDetails(),
    ).dispatch(restContext);

    targetHeight.value = 100;
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.byKey(const Key('target'))).dy,
      closeTo(initialTop, 1),
    );
    expect(tester.takeException(), isNull);
  });
}
