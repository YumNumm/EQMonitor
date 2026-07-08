import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShindoDbStationItem.fromJson', () {
    test('city_code があれば読み、無ければ null', () {
      final withCity = ShindoDbStationItem.fromJson(const {
        'code': '6310000',
        'name': '神戸中央区中山手',
        'latitude': 34.69,
        'longitude': 135.18,
        'city_code': '2811000',
      });
      expect(withCity.cityCode, '2811000');

      final withoutCity = ShindoDbStationItem.fromJson(const {
        'code': '5399900',
        'name': '神戸市等阪神淡路地域',
        'latitude': 34.7,
        'longitude': 135.2,
      });
      expect(withoutCity.cityCode, isNull);

      final nullCity = ShindoDbStationItem.fromJson(const {
        'code': '5399900',
        'name': '神戸市等阪神淡路地域',
        'latitude': 34.7,
        'longitude': 135.2,
        'city_code': null,
      });
      expect(nullCity.cityCode, isNull);
    });
  });
}
