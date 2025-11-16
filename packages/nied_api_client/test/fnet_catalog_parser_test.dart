import 'package:nied_api_client/src/fnet/parser/fnet_catalog_parser.dart';
import 'package:nied_api_client/src/hinet/fnet/model/fnet_event.dart';
import 'package:test/test.dart';

void main() {
  group('FnetCatalogParser', () {
    late FnetCatalogParser parser;

    setUp(() {
      parser = const FnetCatalogParser();
    });

    test('正しいF-netカタログデータをパースできる', () {
      // 実際のF-netカタログデータのフォーマット
      // Origin_Time Latitude Longitude JMA_Depth JMA_Magnitude Region_Name Strike Dip Rake Seismic_Moment MT_Depth MT_Magnitude Variance_Reduction Mxx Mxy Mxz Myy Myz Mzz Unit Number_of_Stations
      const sampleData = '''
# F-net Catalog
Origin_Time Latitude Longitude JMA_Depth JMA_Magnitude Region_Name Strike Dip Rake Seismic_Moment MT_Depth MT_Magnitude Variance_Reduction Mxx Mxy Mxz Myy Myz Mzz Unit Number_of_Stations
2025/11/01,14:44:06.18 35.5 139.8 50.0 4.5 KANTO 68;181 45;70 90;-90 1.89e+15 48.0 4.3 85.5 1.5e+15 -0.5e+15 0.8e+15 -1.0e+15 0.3e+15 -0.5e+15 1.0e+15 25
2025/11/02,08:30:12.45 36.2 140.1 30.0 3.8 IBARAKI 120;250 60;45 -45;135 5.6e+14 28.5 3.6 78.2 4.0e+14 -1.2e+14 0.5e+14 -3.0e+14 0.8e+14 -1.0e+14 8.0e+14 18
''';

      final events = parser.parse(sampleData);

      expect(events, isA<List<FnetEvent>>());
      expect(events.length, equals(2));

      // 最初のイベントを検証
      final firstEvent = events[0];
      expect(firstEvent.originTime.year, equals(2025));
      expect(firstEvent.originTime.month, equals(11));
      expect(firstEvent.originTime.day, equals(1));
      expect(firstEvent.originTime.hour, equals(14));
      expect(firstEvent.originTime.minute, equals(44));
      expect(firstEvent.latitude, equals(35.5));
      expect(firstEvent.longitude, equals(139.8));
      expect(firstEvent.jmaDepth, equals(50.0));
      expect(firstEvent.jmaMagnitude, equals(4.5));
      expect(firstEvent.regionName, equals('KANTO'));
      expect(firstEvent.strike.plane1, equals(68));
      expect(firstEvent.strike.plane2, equals(181));
      expect(firstEvent.dip.plane1, equals(45));
      expect(firstEvent.dip.plane2, equals(70));
      expect(firstEvent.rake.plane1, equals(90));
      expect(firstEvent.rake.plane2, equals(-90));
      expect(firstEvent.seismicMoment, equals(1.89e+15));
      expect(firstEvent.mtDepth, equals(48.0));
      expect(firstEvent.momentMagnitude, equals(4.3));
      expect(firstEvent.varianceReduction, equals(85.5));
      expect(firstEvent.momentTensor.mxx, equals(1.5e+15));
      expect(firstEvent.momentTensor.mxy, equals(-0.5e+15));
      expect(firstEvent.unit, equals(1.0e+15));
      expect(firstEvent.numberOfStations, equals(25));

      // 2番目のイベントを検証
      final secondEvent = events[1];
      expect(secondEvent.regionName, equals('IBARAKI'));
      expect(secondEvent.jmaMagnitude, equals(3.8));
      expect(secondEvent.numberOfStations, equals(18));
    });

    test('空のデータを処理できる', () {
      const emptyData = '';
      final events = parser.parse(emptyData);
      expect(events, isEmpty);
    });

    test('コメント行のみのデータを処理できる', () {
      const commentOnlyData = '''
# This is a comment
# Another comment
''';
      final events = parser.parse(commentOnlyData);
      expect(events, isEmpty);
    });

    test('不正な行をスキップして処理を続行できる', () {
      const mixedData = '''
2025/11/01,14:44:06.18 35.5 139.8 50.0 4.5 KANTO 68;181 45;70 90;-90 1.89e+15 48.0 4.3 85.5 1.5e+15 -0.5e+15 0.8e+15 -1.0e+15 0.3e+15 -0.5e+15 1.0e+15 25
invalid line data
2025/11/02,08:30:12.45 36.2 140.1 30.0 3.8 IBARAKI 120;250 60;45 -45;135 5.6e+14 28.5 3.6 78.2 4.0e+14 -1.2e+14 0.5e+14 -3.0e+14 0.8e+14 -1.0e+14 8.0e+14 18
''';

      final events = parser.parse(mixedData);
      expect(events.length, equals(2));
    });

    test('秒の小数点以下が正しくパースされる', () {
      const data =
          '2025/11/01,14:44:06.18 35.5 139.8 50.0 4.5 KANTO 68;181 45;70 90;-90 1.89e+15 48.0 4.3 85.5 1.5e+15 -0.5e+15 0.8e+15 -1.0e+15 0.3e+15 -0.5e+15 1.0e+15 25';

      final events = parser.parse(data);
      expect(events.length, equals(1));

      final event = events[0];
      // 06.18秒 = 6秒 + 180ミリ秒
      expect(event.originTime.second, equals(6));
      expect(event.originTime.millisecond, equals(180));
    });
  });
}
