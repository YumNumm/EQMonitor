import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../model/travel_time_table/travel_time_table.dart';

final TravelTimeProvider = Provider<List<TravelTimeTable>>((ref) {
  throw UnimplementedError('TravelTimeTableが読み込まれていません');
});

Future<List<TravelTimeTable>> loadTravelTimeTable() async {
  final logger = Logger();
  // 走時表読み込み開始
  // ストップウォッチ
  final stopWatch = Stopwatch()..start();
  // CSV読みこみ
  final file = await rootBundle.loadString('assets/tjma2001.csv');
  // 改行で区切る
  final csv = file.split('\n');
  final travelTimeTable = <TravelTimeTable>[];
  for (final row in csv) {
    try {
      travelTimeTable.add(TravelTimeTable.fromList(row.split(',')));
    } on Exception catch (e) {
      logger.e(e);
    }
  }
  // 走時表読み込み終了
  stopWatch.stop();
  logger.d('走時表を読み込みました: ${stopWatch.elapsedMicroseconds / 1000}ms');
  return travelTimeTable;
}
