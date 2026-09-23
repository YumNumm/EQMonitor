import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_display_mode.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_intensity_card.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/estimated_intensity_notice_content.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/region_intensity.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

class _LayerHarness extends HookWidget {
  const new({
    this.availableModes = IntensityDisplayMode.values,
    this.textScale = 1,
  });

  final List<IntensityDisplayMode> availableModes;
  final double textScale;

  @override
  Widget build(BuildContext context) {
    final mode = useState(IntensityDisplayMode.jma);
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: [DesignSystemThemeExtension.light()],
      ),
      home: Scaffold(
        body: MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.linear(textScale),
          ),
          child: ListView(
            children: [
              EarthquakeIntensityCard(
                item: const Earthquake(
                  eventId: 'test-event',
                  status: .normal,
                  originTime: null,
                  originTimePrecision: .second,
                  arrivalTime: null,
                  dataSources: [.jmaDisasterInformationXml],
                  telegramTypes: [],
                  hypocenter: null,
                  intensity: EarthquakeIntensity(
                    maxIntensity: .three,
                    maxLpgmIntensity: .one,
                    regions: {},
                    intensityTree: {},
                    lpgmIntensityTree: {},
                  ),
                  estimatedIntensityTileUrl: null,
                ),
                displayMode: mode.value,
                onDisplayModeChanged: (value) => mode.value = value,
                availableModes: availableModes,
                source: .jmaDisasterInformationXml,
                showDatabaseBadge: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('メニューで3種類のレイヤーを切り替え、選択中の表示と内容を更新する', (tester) async {
    await tester.pumpWidget(const _LayerHarness());
    expect(find.byType(JmaIntensityContent), findsOneWidget);
    expect(find.text('長周期地震動階級'), findsNothing);

    await tester.tap(find.text('各地の震度'));
    await tester.pumpAndSettle();
    expect(find.text('推計震度'), findsOneWidget);
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);

    await tester.tap(find.text('長周期地震動階級'));
    await tester.pumpAndSettle();
    expect(find.byType(LpgmIntensityContent), findsOneWidget);
    expect(find.byType(JmaIntensityContent), findsNothing);
    expect(find.text('長周期地震動階級'), findsOneWidget);
    expect(find.text('推計震度'), findsNothing);

    await tester.tap(find.text('長周期地震動階級'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('推計震度'));
    await tester.pumpAndSettle();
    expect(find.byType(EstimatedIntensityNoticeContent), findsOneWidget);
    expect(find.byType(LpgmIntensityContent), findsNothing);

    await tester.tap(find.text('推計震度'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('各地の震度'));
    await tester.pumpAndSettle();
    expect(find.byType(JmaIntensityContent), findsOneWidget);
    expect(find.byType(EstimatedIntensityNoticeContent), findsNothing);
  });

  testWidgets('利用できないレイヤーをメニューに表示しない', (tester) async {
    await tester.pumpWidget(
      const _LayerHarness(availableModes: [.jma, .estimated]),
    );
    await tester.tap(find.text('各地の震度'));
    await tester.pumpAndSettle();
    expect(find.text('長周期地震動階級'), findsNothing);
    expect(find.text('推計震度'), findsOneWidget);
  });

  testWidgets('レイヤーが1種類なら見出しのみを表示する', (tester) async {
    await tester.pumpWidget(const _LayerHarness(availableModes: [.jma]));
    expect(find.text('各地の震度'), findsOneWidget);
    expect(find.byType(MenuAnchor), findsNothing);
    expect(find.byType(JmaIntensityContent), findsOneWidget);
  });

  testWidgets('幅320と文字拡大でも長いレイヤー名がオーバーフローしない', (tester) async {
    tester.view.physicalSize = const Size(320, 1000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const _LayerHarness(textScale: 2));
    await tester.tap(find.text('各地の震度'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('長周期地震動階級'));
    await tester.pumpAndSettle();
    expect(find.byType(LpgmIntensityContent), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
