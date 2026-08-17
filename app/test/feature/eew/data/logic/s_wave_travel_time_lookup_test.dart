import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:eqmonitor/feature/eew/data/logic/s_wave_travel_time_lookup.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('深さ別テーブルを一度準備して複数の震央距離を補間する', () {
    const lookup = SWaveTravelTimeLookup();
    const tables = TravelTimeTables(
      table: [
        TravelTimeTable(p: 10, s: 20, depth: 100, distance: 100),
        TravelTimeTable(p: 5, s: 10, depth: 100, distance: 0),
        TravelTimeTable(p: 8, s: 16, depth: 200, distance: 50),
      ],
    );

    final result = lookup.lookupAll(
      tables: tables,
      depth: 100,
      distancesKm: const [-1, 0, 50, 100, 101],
    );

    expect(result, [null, 10, 15, 20, null]);
  });

  test('対象深さの走時表がない場合は全距離をnullにする', () {
    const lookup = SWaveTravelTimeLookup();

    final result = lookup.lookupAll(
      tables: const TravelTimeTables(table: []),
      depth: 100,
      distancesKm: const [0, 50],
    );

    expect(result, [null, null]);
  });
}
