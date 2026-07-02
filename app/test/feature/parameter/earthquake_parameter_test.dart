import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeParameterStationItem.fromJson', () {
    Map<String, Object?> stationJson({required String status}) => {
      'code': '0110100',
      'no_code': '011012625',
      'name': {'ja': '札幌中央区北２条', 'en': ''},
      'kana': 'さっぽろしちゅうおうくきたにじょう',
      'status': status,
      'source_status': '現',
      'owner': '気象庁',
      'location': {'lat': 43.0672, 'lon': 141.3519},
      'arv_400': 1.517,
    };

    test('"OPERATING" → EarthquakeStationStatus.operating', () {
      final item = EarthquakeParameterStationItem.fromJson(
        stationJson(status: 'OPERATING'),
      );
      expect(item.status, EarthquakeStationStatus.operating);
    });

    test('"NEW" → EarthquakeStationStatus.valueNew', () {
      final item = EarthquakeParameterStationItem.fromJson(
        stationJson(status: 'NEW'),
      );
      expect(item.status, EarthquakeStationStatus.valueNew);
    });

    test('"UNKNOWN" → EarthquakeStationStatus.unknown', () {
      final item = EarthquakeParameterStationItem.fromJson(
        stationJson(status: 'UNKNOWN'),
      );
      expect(item.status, EarthquakeStationStatus.unknown);
    });

    test('"CHANGED" → EarthquakeStationStatus.changed', () {
      final item = EarthquakeParameterStationItem.fromJson(
        stationJson(status: 'CHANGED'),
      );
      expect(item.status, EarthquakeStationStatus.changed);
    });

    test('"ABOLISHED" → EarthquakeStationStatus.abolished', () {
      final item = EarthquakeParameterStationItem.fromJson(
        stationJson(status: 'ABOLISHED'),
      );
      expect(item.status, EarthquakeStationStatus.abolished);
    });
  });
}
