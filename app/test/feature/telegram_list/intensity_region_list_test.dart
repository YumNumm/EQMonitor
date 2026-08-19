import 'package:eqmonitor/core/component/intenisty/jma_intensity_icon.dart';
import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_info_type.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/core/model/telegram/telegram_type.dart';
import 'package:eqmonitor/feature/map/features/icon/data/model/intensity_icon.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_body_diff.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/earthquake_telegram_body_model.dart';
import 'package:eqmonitor/feature/telegram_list/data/model/telegram_item.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/earthquake_telegram_tile.dart';
import 'package:eqmonitor/feature/telegram_list/ui/components/intensity_region_list.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

Future<void> _pumpIntensityRegionList(
  WidgetTester tester, {
  required List<IntensityRegionDiffEntry> entries,
  bool groupByPrefecture = false,
  Map<String, String>? prefectureMap,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: ThemeData.light().copyWith(
        extensions: <ThemeExtension<dynamic>>[
          DesignSystemThemeExtension.light(),
        ],
      ),
      home: Scaffold(
        body: IntensityRegionList(
          entries: entries,
          groupByPrefecture: groupByPrefecture,
          prefectureMap: prefectureMap,
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('震度行に共通の塗りつぶし震度アイコンを表示する', (tester) async {
    await _pumpIntensityRegionList(
      tester,
      entries: const [
        IntensityRegionDiffEntry(
          code: '08201',
          name: '水戸市',
          intensity: JmaIntensity.four,
          diffType: IntensityDiffType.same,
        ),
      ],
    );

    expect(find.byType(JmaIntensityIcon), findsOneWidget);
    final icon = tester.widget<JmaIntensityIcon>(find.byType(JmaIntensityIcon));
    expect(icon.intensity, JmaIntensity.four);
    expect(icon.type, IntensityIconType.filled);
    expect(icon.size, 28);
  });

  testWidgets('市区町村を都道府県ごとの独立した行に表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 600));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await _pumpIntensityRegionList(
      tester,
      entries: const [
        IntensityRegionDiffEntry(
          code: '08201',
          name: '水戸市',
          intensity: JmaIntensity.four,
          diffType: IntensityDiffType.same,
        ),
        IntensityRegionDiffEntry(
          code: '08202',
          name: '日立市',
          intensity: JmaIntensity.four,
          diffType: IntensityDiffType.same,
        ),
        IntensityRegionDiffEntry(
          code: '09201',
          name: '宇都宮市',
          intensity: JmaIntensity.four,
          diffType: IntensityDiffType.same,
        ),
      ],
      groupByPrefecture: true,
      prefectureMap: const {'08': '茨城県', '09': '栃木県'},
    );

    final ibarakiTop = tester.getTopLeft(find.text('茨城県')).dy;
    final tochigiTop = tester.getTopLeft(find.text('栃木県')).dy;
    expect(ibarakiTop, isNot(tochigiTop));
    expect(tester.takeException(), isNull);
  });

  testWidgets('VXSE53は都道府県ラベルがなくても市区町村を都道府県別の行に表示する', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1200, 600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final timestamp = DateTime.utc(2026, 6, 4, 12);
    final telegram = TelegramItem(
      id: 'telegram-1',
      eventId: 'event-1',
      type: TelegramType.vxse53,
      title: '震源・震度情報',
      status: TelegramStatus.normal,
      infoType: TelegramInfoType.publication,
      editorialOffice: '気象庁',
      publishingOffice: const ['気象庁'],
      pressAt: timestamp,
      reportAt: timestamp,
      infoKind: '地震情報',
      infoKindVersion: '1.0_0',
      hash: 'hash',
      createdAt: timestamp,
    );
    final body = const api.TelegramBodyUnionEarthquakeTelegramBody(
      type: 'EARTHQUAKE',
      intensityCities: [
        api.EarthquakeTelegramBodyIntensityRegion(
          code: '08201',
          name: '水戸市',
          intensity: api.JmaIntensity.value4,
        ),
        api.EarthquakeTelegramBodyIntensityRegion(
          code: '09201',
          name: '宇都宮市',
          intensity: api.JmaIntensity.value4,
        ),
      ],
    ).toEarthquakeTelegramBodyModel();

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: ThemeData.light().copyWith(
            extensions: <ThemeExtension<dynamic>>[
              DesignSystemThemeExtension.light(),
            ],
          ),
          home: Scaffold(
            body: EarthquakeTelegramTile(
              telegram: telegram,
              body: body,
              sequenceNumber: 1,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final mitoTop = tester.getTopLeft(find.text('水戸市')).dy;
    final utsunomiyaTop = tester.getTopLeft(find.text('宇都宮市')).dy;
    expect(mitoTop, isNot(utsunomiyaTop));
    expect(tester.takeException(), isNull);
  });
}
