import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'travel_time_data_source.g.dart';

@Riverpod(keepAlive: true)
TravelTimeDataSource travelTimeDataSource(Ref ref) => TravelTimeDataSource();

class TravelTimeDataSource {
  Future<TravelTimeTables> loadTables() async {
    final raw = await rootBundle.loadString('assets/tjma2001.csv');
    return compute(parseTravelTimeCsv, raw);
  }
}

/// CSV 文字列を走時テーブルへパースする。compute で isolate 実行するため
/// top-level に置く。talker (Firebase 依存の global) は isolate では使えない。
TravelTimeTables parseTravelTimeCsv(String raw) {
  final rows = raw
      .split('\n')
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
  final travelTimeTable = <TravelTimeTable>[];
  for (var i = 0; i < rows.length; i++) {
    final list = rows[i].split(',');
    try {
      travelTimeTable.add(TravelTimeTable.fromList(list));
    } on Exception catch (e) {
      // 先頭行(ヘッダー)・末尾行のパース失敗は許容してスキップ
      if (i == 0 || i == rows.length - 1) {
        continue;
      }
      throw Exception('走時表のパースに失敗しました (行$i): $e');
    }
  }
  if (travelTimeTable.isEmpty) {
    throw Exception('走時表が空です');
  }
  return TravelTimeTables(table: travelTimeTable);
}
