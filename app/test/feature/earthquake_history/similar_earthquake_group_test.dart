import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_partial.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_type.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similar_earthquake_group.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/similarity_grade.dart';
import 'package:flutter_test/flutter_test.dart';

EarthquakePartial _dummyPartial(String eventId) => EarthquakePartial(
  eventId: eventId,
  status: TelegramStatus.normal,
  originTime: null,
  originTimePrecision: OriginTimePrecision.minute,
  arrivalTime: null,
  dataSource: EarthquakeDataSource.jmaIntensityDatabase,
  hypocenter: null,
  intensity: null,
  earthquakeType: EarthquakeType.normal,
  telegramTypes: const [],
  estimatedIntensityTileUrl: null,
);

void main() {
  test('grade は score から導出される', () {
    final groupA = SimilarEarthquakeGroup(
      representative: _dummyPartial('20260101000000'),
      score: 30,
      groupedEarthquakes: const [],
    );
    expect(groupA.grade, SimilarityGrade.a);

    final groupD = SimilarEarthquakeGroup(
      representative: _dummyPartial('20260101000001'),
      score: 300,
      groupedEarthquakes: const [],
    );
    expect(groupD.grade, SimilarityGrade.d);
  });
}
