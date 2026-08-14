import 'package:eqmonitor/core/designsystem/extensions/design_system_theme_extension.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_observation_first_height.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_region_station.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_state.dart';
import 'package:eqmonitor/feature/tsunami/data/model/tsunami_station_observation.dart';
import 'package:eqmonitor/feature/tsunami/data/model/value/tsunami_warning_kind.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_observation_station_tile.dart';
import 'package:eqmonitor/feature/tsunami/ui/components/tsunami_region_list.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

/// `_ObservationExpansion`(StatefulWidget)の展開・折りたたみ振る舞いを、
/// HookWidget化前に固定するテスト。
void main() {
  testWidgets('観測点を表示ボタンをタップすると観測点一覧が展開・折りたたみされる', (tester) async {
    final tsunami = _tsunami(
      regions: [
        TsunamiRegion(
          code: '100',
          name: 'テスト予報区',
          kind: TsunamiWarningKind.warning,
          lastKind: TsunamiWarningKind.warning,
          stations: [
            TsunamiRegionStation(
              code: 'ST1',
              name: 'テスト観測点',
              observation: const TsunamiStationObservation(
                sensor: 'coastal',
                firstHeight: TsunamiObservationFirstHeight(
                  arrivalTime: null,
                  initial: null,
                  isUnidentifiable: null,
                  isMissing: false,
                  revise: null,
                ),
                maxHeight: null,
              ),
            ),
          ],
        ),
      ],
    );

    await tester.pumpWidget(
      _TestApp(home: TsunamiRegionList(tsunami: tsunami)),
    );
    await tester.pumpAndSettle();

    expect(find.text('観測点を表示 (1)'), findsOneWidget);
    expect(find.byType(TsunamiObservationStationTile), findsNothing);

    await tester.tap(find.text('観測点を表示 (1)'));
    await tester.pumpAndSettle();

    expect(find.byType(TsunamiObservationStationTile), findsOneWidget);

    await tester.tap(find.text('観測点を表示 (1)'));
    await tester.pumpAndSettle();

    expect(find.byType(TsunamiObservationStationTile), findsNothing);
  });
}

TsunamiState _tsunami({required List<TsunamiRegion> regions}) => TsunamiState(
  id: 'test-tsunami',
  eventIds: const [],
  isActive: true,
  isCanceled: false,
  updatedAt: DateTime.utc(2024),
  earthquakes: const [],
  latestTelegrams: const [],
  regions: regions,
  offshoreStations: const [],
);

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});

  final Widget home;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData.light().copyWith(
      extensions: [DesignSystemThemeExtension.light()],
    );
    return MaterialApp(
      theme: theme,
      home: Scaffold(body: home),
    );
  }
}
