import 'package:eqmonitor/feature/home/features/travel_time/model/travel_time_table.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'travel_time_data_source.g.dart';

@Riverpod(keepAlive: true)
TravelTimeDataSource travelTimeDataSource(TravelTimeDataSourceRef ref) =>
    TravelTimeDataSource();

class TravelTimeDataSource {
  Future<List<TravelTimeTable>> loadTables() async {
    const path = 'assets/tjma2001.csv';
    final data = await rootBundle.loadString(path);
    final csv = data.split('\n').where((element) => element != '');
    final travelTimeTable = <TravelTimeTable>[];
    for (final row in csv) {
      final list = row.split(',');
      try {
        travelTimeTable.add(TravelTimeTable.fromList(list));
      } on Exception catch (_) {}
    }
    return travelTimeTable;
  }
}
