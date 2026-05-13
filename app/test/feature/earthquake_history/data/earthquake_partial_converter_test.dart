import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_depth.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_magnitude.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/origin_time_precision.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:json_annotation/json_annotation.dart';

void main() {
  group('OriginTimePrecisionApiExtension', () {
    test('全列挙値が変換されること', () {
      const cases = <api.OriginTimePrecision, OriginTimePrecision>{
        api.OriginTimePrecision.millisecond: OriginTimePrecision.millisecond,
        api.OriginTimePrecision.second: OriginTimePrecision.second,
        api.OriginTimePrecision.minute: OriginTimePrecision.minute,
        api.OriginTimePrecision.hour: OriginTimePrecision.hour,
        api.OriginTimePrecision.day: OriginTimePrecision.day,
        api.OriginTimePrecision.month: OriginTimePrecision.month,
      };
      for (final entry in cases.entries) {
        expect(
          entry.key.toOriginTimePrecision,
          entry.value,
          reason: '${entry.key}',
        );
      }
    });

    test('双方向の往復で同じ値になること', () {
      for (final v in OriginTimePrecision.values) {
        expect(v.toApiOriginTimePrecision.toOriginTimePrecision, v);
      }
    });
  });

  group('EarthquakeDataSourceApiExtension', () {
    test('JMA_INTENSITY_DATABASE / JMA_DISASTER_INFORMATION_XML が変換されること', () {
      expect(
        api.EarthquakeDatasource.jmaIntensityDatabase.toEarthquakeDataSource,
        EarthquakeDataSource.jmaIntensityDatabase,
      );
      expect(
        api.EarthquakeDatasource.jmaDisasterInformationXml
            .toEarthquakeDataSource,
        EarthquakeDataSource.jmaDisasterInformationXml,
      );
    });

    test('双方向の往復で同じ値になること', () {
      for (final v in EarthquakeDataSource.values) {
        expect(v.toApiEarthquakeDataSource.toEarthquakeDataSource, v);
      }
    });
  });

  group('EarthquakeMagnitudeApiExtension', () {
    test('NORMAL かつ value 設定済みなら EarthquakeMagnitude.value', () {
      const m = api.Magnitude(type: api.Type3.normal, value: 6.5);
      expect(m.toEarthquakeMagnitude, isA<EarthquakeMagnitudeValue>());
      expect(
        (m.toEarthquakeMagnitude as EarthquakeMagnitudeValue).value,
        6.5,
      );
    });

    test('NORMAL で value が null だと CheckedFromJsonException', () {
      const m = api.Magnitude(type: api.Type3.normal);
      expect(
        () => m.toEarthquakeMagnitude,
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('UNKNOWN は EarthquakeMagnitude.unknown', () {
      const m = api.Magnitude(type: api.Type3.unknown);
      expect(m.toEarthquakeMagnitude, isA<EarthquakeMagnitudeUnknown>());
    });

    test('OVER_M8 は EarthquakeMagnitude.overM8', () {
      const m = api.Magnitude(type: api.Type3.overM8);
      expect(m.toEarthquakeMagnitude, isA<EarthquakeMagnitudeOverM8>());
    });
  });

  group('EarthquakeDepthApiExtension', () {
    test('SHALLOW は EarthquakeDepth.shallow', () {
      const d = api.Depth(type: api.DepthType.shallow);
      expect(d.toEarthquakeDepth, isA<EarthquakeDepthShallow>());
    });

    test('NORMAL かつ value 設定済みなら EarthquakeDepth.value', () {
      const d = api.Depth(type: api.DepthType.normal, value: 20);
      expect(d.toEarthquakeDepth, isA<EarthquakeDepthValue>());
      expect((d.toEarthquakeDepth as EarthquakeDepthValue).value, 20);
    });

    test('NORMAL で value が null だと CheckedFromJsonException', () {
      const d = api.Depth(type: api.DepthType.normal);
      expect(
        () => d.toEarthquakeDepth,
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('OVER_700 は EarthquakeDepth.over700km', () {
      const d = api.Depth(type: api.DepthType.over700);
      expect(d.toEarthquakeDepth, isA<EarthquakeDepthOver700km>());
    });

    test('UNKNOWN は EarthquakeDepth.unknown', () {
      const d = api.Depth(type: api.DepthType.unknown);
      expect(d.toEarthquakeDepth, isA<EarthquakeDepthUnknown>());
    });

    test('NORMAL で value=0 でも EarthquakeDepth.value(0) になること', () {
      const d = api.Depth(type: api.DepthType.normal, value: 0);
      expect((d.toEarthquakeDepth as EarthquakeDepthValue).value, 0);
    });
  });
}
