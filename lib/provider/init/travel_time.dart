// ignore_for_file: avoid_catching_errors

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import '../../model/travel_time_table/travel_time_table.dart';

final travelTimeProvider = Provider<List<TravelTimeTable>>((ref) {
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

class TravelTimeApi {
  TravelTimeApi({required this.travelTime});

  final List<TravelTimeTable> travelTime;

  /// 走時を求めます
  /// [depth]: 震源の深さ(km)
  /// [time]: 地震発生からの経過時間(sec)
  /// ref: https://zenn.dev/iedred7584/articles/travel-time-table-converter-adcal2020#%E5%86%86%E3%81%AE%E5%A4%A7%E3%81%8D%E3%81%95%E3%82%92%E6%B1%82%E3%82%81%E3%82%8B
  TravelTimeResult? getValue(int depth, double time) {
    if (depth > 700 || time > 2000) {
      return null;
    }
    final table = travelTime.where((e) => e.depth == depth).toList();
    if (table.isEmpty) {
      return null;
    }
    try {
      final p1 = table.firstWhere((e) => e.p <= time);
      final p2 = table.lastWhere((e) => e.p >= time);
      final p = (time - p1.p) / (p2.p - p1.p) * (p2.distance - p1.distance) +
          p1.distance;
      final s1 = table.firstWhere((e) => e.s <= time);
      final s2 = table.lastWhere((e) => e.s >= time);
      final s = (time - p1.s) / (p2.s - p1.s) * (p2.distance - p1.distance) +
          s1.distance;
      return TravelTimeResult(s, p);
    } on Error {
      try {
        // P波のみ計算
        final p1 = table.firstWhere((e) => e.p <= time);
        final p2 = table.lastWhere((e) => e.p >= time);
        final p = (time - p1.p) / (p2.p - p1.p) * (p2.distance - p1.distance) +
            p1.distance;

        return TravelTimeResult(0, p);
      } on Error {
        return TravelTimeResult(0, 0);
      }
    }
  }
}

class TravelTimeResult {
  TravelTimeResult(this.sDistance, this.pDistance);

  /// S波到達予想(km)
  final double sDistance;

  /// P波到達予想(km)
  final double pDistance;
}
