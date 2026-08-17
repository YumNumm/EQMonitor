import 'package:eqmonitor/core/provider/travel_time/data/travel_time_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Real CSV format: p,s,depth,distance (no header row)
  // Example from assets/tjma2001.csv:
  //   0.416,0.703,0,2
  //   1.243,2.099,0,6

  test('parseTravelTimeCsv parses p/s/depth/distance rows', () {
    const raw = '0.416,0.703,0,2\n1.243,2.099,0,6';
    final tables = TravelTimeCsvParser.parse(raw);
    expect(tables.table, hasLength(2));
    final first = tables.table.first;
    expect(first.p, closeTo(0.416, 1e-9));
    expect(first.s, closeTo(0.703, 1e-9));
    expect(first.depth, 0);
    expect(first.distance, 2);
    final second = tables.table[1];
    expect(second.p, closeTo(1.243, 1e-9));
    expect(second.s, closeTo(2.099, 1e-9));
    expect(second.depth, 0);
    expect(second.distance, 6);
  });

  test('parseTravelTimeCsv skips first row on parse failure', () {
    // ヘッダー行がある場合でも先頭のパース失敗はスキップ
    const raw = 'p,s,depth,distance\n0.416,0.703,0,2';
    final tables = TravelTimeCsvParser.parse(raw);
    expect(tables.table, hasLength(1));
    expect(tables.table.first.distance, 2);
  });

  test('parseTravelTimeCsv throws on empty result', () {
    expect(() => TravelTimeCsvParser.parse(''), throwsException);
  });
}
