import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/travel_time/model/travel_time_table.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'travel_time_data_source.g.dart';

@Riverpod(keepAlive: true)
TravelTimeDataSource travelTimeDataSource(Ref ref) => TravelTimeDataSource();

class TravelTimeDataSource {
  Future<List<TravelTimeTable>> loadTables() async {
    const path = 'assets/tjma2001.csv';
    final data = await rootBundle.loadString(path);
    final rows = data
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
          talker.warning('走時表: スキップ行[$i]: $e');
          continue;
        }
        throw Exception('走時表のパースに失敗しました (行$i): $e');
      }
    }
    if (travelTimeTable.isEmpty) {
      throw Exception('走時表が空です');
    }
    return travelTimeTable;
  }
}
