import '../../const/obspoint.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

final kyoshinKansokutenProvider = Provider<List<KyoshinKansokuten>>((ref) {
  throw UnimplementedError('観測点データが読み込まれていません');
});

Future<List<KyoshinKansokuten>> loadKyoshinKansokuten() async {
  final stopwatch = Stopwatch()..start();

  final kansokuten = await rootBundle.loadString('assets/kmoni/kansokuten.csv');
  // 改行で区切る
  final rowsAsListOfStrings = kansokuten.split('\n');

  final obsPoints = <KyoshinKansokuten>[];
  for (final row in rowsAsListOfStrings) {
    obsPoints.add(KyoshinKansokuten.fromList(row.split(',')));
  }
  stopwatch.stop();
  Logger().d('観測点データを読み込みました: ${stopwatch.elapsedMicroseconds / 1000}ms');

  return obsPoints;
}
