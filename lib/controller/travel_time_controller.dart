import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:eqmonitor/const/travel_time_table/travel_time_table.dart';
import 'package:eqmonitor/model/travel_time_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../utils/logger/filter.dart';

class TravelTimeController extends StateNotifier<TravelTimeModel> {
  TravelTimeController()
      : super(
          const TravelTimeModel(
            travelTimeTable: [],
            loadDuration: null,
          ),
        );

  final logger = Logger(
    filter: MyFilter(),
    output: MyOutput(),
    printer: PrettyPrinter(
      methodCount: 1,
      printTime: true,
    ),
  );

  void onInit() {
    if (state.travelTimeTable.isEmpty) {
      // 走時表読み込み開始
      loadTravelTimeCsv();
    }
  }

  Future<void> loadTravelTimeCsv() async {
    // 走時表読み込み開始
    // ストップウォッチ
    final stopWatch = Stopwatch()..start();
    // CSV読みこみ
    final file = await rootBundle.load('assets/tjma2001.csv');
    final rowsAsListOfValues = const CsvToListConverter().convert<String>(
      utf8.decode(file.buffer.asUint8List()),
      shouldParseNumbers: false,
    );
    final travelTimeTable = <TravelTimeTable>[];
    for (final row in rowsAsListOfValues) {
      travelTimeTable.add(TravelTimeTable.fromList(row));
    }
    // 走時表読み込み終了
    stopWatch.stop();
    logger.d('走時表を読み込みました: ${stopWatch.elapsedMicroseconds / 1000}ms');

    state = state.copyWith(
      travelTimeTable: travelTimeTable,
      loadDuration: stopWatch.elapsed,
    );
  }
}
