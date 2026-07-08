import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShindoDbIntensityClass', () {
    test('API の全階級コードが変換されること', () {
      const cases = <api.CatalogIntensityClass, ShindoDbIntensityClass>{
        api.CatalogIntensityClass.value1: ShindoDbIntensityClass.one,
        api.CatalogIntensityClass.value2: ShindoDbIntensityClass.two,
        api.CatalogIntensityClass.value3: ShindoDbIntensityClass.three,
        api.CatalogIntensityClass.value4: ShindoDbIntensityClass.four,
        api.CatalogIntensityClass.value5: ShindoDbIntensityClass.five,
        api.CatalogIntensityClass.value6: ShindoDbIntensityClass.six,
        api.CatalogIntensityClass.value7: ShindoDbIntensityClass.seven,
        api.CatalogIntensityClass.value9: ShindoDbIntensityClass.unknownFelt,
        api.CatalogIntensityClass.a: ShindoDbIntensityClass.fiveLower,
        api.CatalogIntensityClass.b: ShindoDbIntensityClass.fiveUpper,
        api.CatalogIntensityClass.c: ShindoDbIntensityClass.sixLower,
        api.CatalogIntensityClass.d: ShindoDbIntensityClass.sixUpper,
        api.CatalogIntensityClass.l: ShindoDbIntensityClass.local,
        api.CatalogIntensityClass.s: ShindoDbIntensityClass.semiLocal,
        api.CatalogIntensityClass.m: ShindoDbIntensityClass.semiConspicuous,
        api.CatalogIntensityClass.r: ShindoDbIntensityClass.conspicuous,
        api.CatalogIntensityClass.f: ShindoDbIntensityClass.felt,
        api.CatalogIntensityClass.x: ShindoDbIntensityClass.nearbyFelt,
      };
      expect(cases.length, api.CatalogIntensityClass.values.length);
      for (final entry in cases.entries) {
        expect(
          entry.key.toShindoDbIntensityClass,
          entry.value,
          reason: '${entry.key}',
        );
      }
    });

    test('orderIndex は仕様の表示順で単調であること', () {
      const ordered = [
        ShindoDbIntensityClass.seven,
        ShindoDbIntensityClass.sixUpper,
        ShindoDbIntensityClass.sixLower,
        ShindoDbIntensityClass.six,
        ShindoDbIntensityClass.fiveUpper,
        ShindoDbIntensityClass.fiveLower,
        ShindoDbIntensityClass.five,
        ShindoDbIntensityClass.four,
        ShindoDbIntensityClass.three,
        ShindoDbIntensityClass.two,
        ShindoDbIntensityClass.one,
        ShindoDbIntensityClass.unknownFelt,
        ShindoDbIntensityClass.conspicuous,
        ShindoDbIntensityClass.semiConspicuous,
        ShindoDbIntensityClass.semiLocal,
        ShindoDbIntensityClass.local,
        ShindoDbIntensityClass.felt,
        ShindoDbIntensityClass.nearbyFelt,
      ];
      expect(ordered.toSet().length, ShindoDbIntensityClass.values.length);
      for (var i = 0; i + 1 < ordered.length; i++) {
        expect(
          ordered[i].orderIndex > ordered[i + 1].orderIndex,
          isTrue,
          reason: '${ordered[i]} > ${ordered[i + 1]}',
        );
      }
    });

    test('数値階級は色を持ち、歴史的階級は色を持たないこと', () {
      expect(
        ShindoDbIntensityClass.five.colorJmaIntensity,
        JmaIntensity.fiveLower,
      );
      expect(
        ShindoDbIntensityClass.six.colorJmaIntensity,
        JmaIntensity.sixLower,
      );
      expect(ShindoDbIntensityClass.five.exactJmaIntensity, isNull);
      expect(
        ShindoDbIntensityClass.fiveLower.exactJmaIntensity,
        JmaIntensity.fiveLower,
      );
      for (final v in [
        ShindoDbIntensityClass.unknownFelt,
        ShindoDbIntensityClass.local,
        ShindoDbIntensityClass.felt,
        ShindoDbIntensityClass.nearbyFelt,
      ]) {
        expect(v.colorJmaIntensity, isNull, reason: '$v');
        expect(v.isNumeric, isFalse, reason: '$v');
        expect(v.historicalDescription, isNotNull, reason: '$v');
      }
    });
  });
}
