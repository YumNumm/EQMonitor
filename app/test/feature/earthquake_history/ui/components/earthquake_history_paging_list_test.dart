import 'package:eqmonitor/core/component/layout/history_selection.dart';
import 'package:eqmonitor/core/theme/build_theme.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_config_model.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/components/earthquake_history_paging_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:m3e_core/m3e_core.dart';
import 'package:material_ui/material_ui.dart';
import 'package:paging_view/paging_view.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../earthquake_activity_test_data.dart';

void main() {
  for (final grouped in [false, true]) {
    testWidgets(
      'segmented history preserves group boundaries and selection: grouped=$grouped',
      (
        tester,
      ) async {
        tz.initializeTimeZones();
        final source = _HistorySource();
        addTearDown(source.dispose);
        await source.refresh();
        final light = AppTheme.eqmonitorDefault().light;
        if (light == null) fail('default light theme is required');
        String? selected;
        await tester.pumpWidget(
          MaterialApp(
            theme: AppThemeDataBuilder.build(
              colorSet: light,
              brightness: Brightness.light,
            ),
            home: Scaffold(
              body: CustomScrollView(
                slivers: [
                  EarthquakeHistoryPagingList(
                    dataSource: source,
                    parameter: const EarthquakeHistoryParameter.all(
                      sortBy: .eventId,
                      sortOrder: .desc,
                    ),
                    config: EarthquakeHistoryListConfig(
                      dateHeaderDisplayMode: grouped ? .always : .never,
                    ),
                    selectedEventId: 'second',
                    onSelect: (eventId) => selected = eventId,
                  ),
                ],
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final segments = tester
            .widgetList<M3ESegmentedItem>(find.byType(M3ESegmentedItem))
            .toList();
        expect(
          segments.map((item) => item.position),
          grouped
              ? [
                  M3ESegmentedItemPosition.first,
                  M3ESegmentedItemPosition.last,
                  M3ESegmentedItemPosition.single,
                ]
              : [
                  M3ESegmentedItemPosition.first,
                  M3ESegmentedItemPosition.middle,
                  M3ESegmentedItemPosition.last,
                ],
        );
        expect(
          tester
              .widgetList<HistorySelection>(find.byType(HistorySelection))
              .map((item) => item.selected),
          [false, true, false],
        );
        if (grouped) {
          final paging = tester
              .widget<
                SliverGroupedPagingList<String?, String, EarthquakePartial>
              >(
                find.byType(
                  SliverGroupedPagingList<String?, String, EarthquakePartial>,
                ),
              );
          expect(paging.stickyHeader, isTrue);
          expect(find.text('2026/01/02'), findsOneWidget);
          expect(find.text('2026/01/01'), findsOneWidget);
        }
        await tester.tap(find.byType(EarthquakeHistoryListTile).at(1));
        expect(selected, 'second');
        source.includeLast = false;
        await source.refresh();
        await tester.pumpAndSettle();
        expect(
          tester
              .widgetList<M3ESegmentedItem>(find.byType(M3ESegmentedItem))
              .map((item) => item.position),
          [M3ESegmentedItemPosition.first, M3ESegmentedItemPosition.last],
        );
        expect(tester.takeException(), isNull);
      },
    );
  }
}

class _Repository extends TestEarthquakeHistoryRepository;

class _HistorySource extends EarthquakeHistoryDataSource {
  new()
    : super(
        repository: _Repository(),
        parameter: const EarthquakeHistoryParameter.all(
          sortBy: .eventId,
          sortOrder: .desc,
        ),
      );

  bool includeLast = true;

  @override
  Future<LoadResult<String?, EarthquakePartial>> load(
    LoadAction<String?> action,
  ) async => Success(
    page: PageData(
      data: [
        testActivityEarthquake(
          eventId: 'first',
          originTime: DateTime.utc(2026, 1, 2, 1),
        ),
        testActivityEarthquake(
          eventId: 'second',
          originTime: DateTime.utc(2026, 1, 2),
        ),
        if (includeLast)
          testActivityEarthquake(
            eventId: 'third',
            originTime: DateTime.utc(2026, 1, 1),
          ),
      ],
    ),
  );
}
