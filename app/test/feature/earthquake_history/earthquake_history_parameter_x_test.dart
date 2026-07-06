import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/telegram/telegram_status.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter_x.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeHistoryParameterX', () {
    // 共通フィルタ付きの All パラメータ
    const baseAll = EarthquakeHistoryParameterAll(
      sortBy: EarthquakeSortBy.magnitude,
      sortOrder: SortOrder.asc,
      magnitudeGte: 5,
      statuses: [TelegramStatus.normal],
    );

    group('withRegion', () {
      test(
        '1. All(magnitudeGte:5, statuses) → prefecture で共通フィルタ引き継ぎ・sortBy強制eventId',
        () {
          const result = (
            searchType: RegionSearchType.prefecture,
            code: '32',
            name: '島根県',
            intensityGte: JmaIntensity.three,
            intensityLte: JmaIntensity.fiveLower,
          );
          final param = baseAll.withRegion(result);
          expect(param, isA<EarthquakeHistoryParameterPrefecture>());
          final p = param as EarthquakeHistoryParameterPrefecture;
          expect(p.prefectureCode, '32');
          expect(p.intensityGte, JmaIntensity.three);
          expect(p.intensityLte, JmaIntensity.fiveLower);
          expect(p.magnitudeGte, 5.0);
          expect(p.statuses, [TelegramStatus.normal]);
          // sortBy は eventId に強制される
          expect(p.sortBy, EarthquakeSortBy.eventId);
          // sortOrder は元の値を引き継ぐ
          expect(p.sortOrder, SortOrder.asc);
        },
      );

      test('2a. searchType=region → EarthquakeHistoryParameterRegion', () {
        const result = (
          searchType: RegionSearchType.region,
          code: '010100',
          name: '道央',
          intensityGte: null,
          intensityLte: null,
        );
        final param = baseAll.withRegion(result);
        expect(param, isA<EarthquakeHistoryParameterRegion>());
        final p = param as EarthquakeHistoryParameterRegion;
        expect(p.regionCode, '010100');
        expect(p.sortBy, EarthquakeSortBy.eventId);
      });

      test('2b. searchType=city → EarthquakeHistoryParameterCity', () {
        const result = (
          searchType: RegionSearchType.city,
          code: '01100',
          name: '札幌市',
          intensityGte: null,
          intensityLte: null,
        );
        final param = baseAll.withRegion(result);
        expect(param, isA<EarthquakeHistoryParameterCity>());
        final p = param as EarthquakeHistoryParameterCity;
        expect(p.cityCode, '01100');
        expect(p.sortBy, EarthquakeSortBy.eventId);
      });

      test('2c. searchType=station → EarthquakeHistoryParameterStation', () {
        const result = (
          searchType: RegionSearchType.station,
          code: '0110100',
          name: '札幌',
          intensityGte: null,
          intensityLte: null,
        );
        final param = baseAll.withRegion(result);
        expect(param, isA<EarthquakeHistoryParameterStation>());
        final p = param as EarthquakeHistoryParameterStation;
        expect(p.stationCode, '0110100');
        expect(p.sortBy, EarthquakeSortBy.eventId);
      });

      test('3. Prefecture(...).withRegion(city) → City に切り替わり共通フィルタ引き継ぎ', () {
        const prefParam = EarthquakeHistoryParameterPrefecture(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          prefectureCode: '32',
          magnitudeGte: 3.0,
          intensityGte: JmaIntensity.two,
          intensityLte: JmaIntensity.four,
          statuses: [TelegramStatus.normal],
        );
        const result = (
          searchType: RegionSearchType.city,
          code: '01100',
          name: '札幌市',
          intensityGte: JmaIntensity.fiveLower,
          intensityLte: null,
        );
        final param = prefParam.withRegion(result);
        expect(param, isA<EarthquakeHistoryParameterCity>());
        final p = param as EarthquakeHistoryParameterCity;
        expect(p.cityCode, '01100');
        // intensity は result の値で上書き
        expect(p.intensityGte, JmaIntensity.fiveLower);
        expect(p.intensityLte, isNull);
        // 共通フィルタは引き継ぐ
        expect(p.magnitudeGte, 3.0);
        expect(p.statuses, [TelegramStatus.normal]);
        expect(p.sortBy, EarthquakeSortBy.eventId);
        expect(p.sortOrder, SortOrder.desc);
      });

      test(
        '4a. Prefecture(...).toAll() → All、共通フィルタ引き継ぎ、intensityGte/Lte も引き継ぐ',
        () {
          const prefParam = EarthquakeHistoryParameterPrefecture(
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
            prefectureCode: '32',
            magnitudeGte: 3.0,
            intensityGte: JmaIntensity.two,
            intensityLte: JmaIntensity.four,
            statuses: [TelegramStatus.normal],
          );
          final param = prefParam.toAll();
          expect(param, isA<EarthquakeHistoryParameterAll>());
          final p = param;
          expect(p.magnitudeGte, 3.0);
          expect(p.statuses, [TelegramStatus.normal]);
          expect(p.sortBy, EarthquakeSortBy.eventId);
          expect(p.sortOrder, SortOrder.desc);
          // intensityGte/Lte も引き継ぐ
          expect(p.intensityGte, JmaIntensity.two);
          expect(p.intensityLte, JmaIntensity.four);
        },
      );

      test('5. withRegion 時 sortBy は eventId に強制される', () {
        const allWithMagnitudeSort = EarthquakeHistoryParameterAll(
          sortBy: EarthquakeSortBy.magnitude,
          sortOrder: SortOrder.asc,
        );
        const result = (
          searchType: RegionSearchType.prefecture,
          code: '13',
          name: '東京都',
          intensityGte: null,
          intensityLte: null,
        );
        final param = allWithMagnitudeSort.withRegion(result);
        // sortBy は magnitude だったが、地域指定後は eventId に強制
        expect(param.sortBy, EarthquakeSortBy.eventId);
        // sortOrder は保持される
        expect(param.sortOrder, SortOrder.asc);
      });
    });

    group('regionSelection', () {
      test('All → null', () {
        expect(baseAll.regionSelection, isNull);
      });

      test('Prefecture → (prefecture, code)', () {
        const p = EarthquakeHistoryParameterPrefecture(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          prefectureCode: '32',
        );
        expect(p.regionSelection, (RegionSearchType.prefecture, '32'));
      });

      test('Region → (region, code)', () {
        const p = EarthquakeHistoryParameterRegion(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          regionCode: '010100',
        );
        expect(p.regionSelection, (RegionSearchType.region, '010100'));
      });

      test('City → (city, code)', () {
        const p = EarthquakeHistoryParameterCity(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          cityCode: '01100',
        );
        expect(p.regionSelection, (RegionSearchType.city, '01100'));
      });

      test('Station → (station, code)', () {
        const p = EarthquakeHistoryParameterStation(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          stationCode: '0110100',
        );
        expect(p.regionSelection, (RegionSearchType.station, '0110100'));
      });
    });
  });
}
