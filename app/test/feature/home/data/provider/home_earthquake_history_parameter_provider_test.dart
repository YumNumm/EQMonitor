import 'dart:async';

import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_sort_by.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/sort_order.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_configuration_notifier.dart';
import 'package:eqmonitor/feature/home/data/provider/home_earthquake_history_parameter_provider.dart';
import 'package:eqmonitor/feature/location/data/location.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// `homeConfigurationProvider` を任意の状態で固定するためのスタブ。
class _StubHomeConfiguration extends HomeConfigurationNotifier {
  _StubHomeConfiguration(this._value);

  final HomeConfigurationModel _value;

  @override
  Future<HomeConfigurationModel> build() async => _value;
}

Position _position({double lat = 35.681, double lng = 139.767}) => Position(
  latitude: lat,
  longitude: lng,
  timestamp: DateTime.utc(2026),
  accuracy: 0,
  altitude: 0,
  altitudeAccuracy: 0,
  heading: 0,
  headingAccuracy: 0,
  speed: 0,
  speedAccuracy: 0,
);

ProviderContainer _container({
  required HomeConfigurationModel home,
  Position? position,
  MapDataItem? city,
}) {
  final container = ProviderContainer(
    overrides: [
      homeConfigurationProvider.overrideWith(
        () => _StubHomeConfiguration(home),
      ),
      if (position != null)
        locationStreamProvider.overrideWith((ref) => Stream.value(position))
      else
        locationStreamProvider.overrideWith((ref) => const Stream.empty()),
      jmaMapAreaInformationCityInsideProvider.overrideWith(
        (ref, latLng) async => city,
      ),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('homeEarthquakeHistoryParameterProvider', () {
    test('nationwide スコープでは all パラメータを返す', () async {
      final container = _container(
        home: const HomeConfigurationModel(),
      );

      final result = await container.read(
        homeEarthquakeHistoryParameterProvider.future,
      );

      expect(
        result,
        equals(
          const EarthquakeHistoryParameter.all(
            sortBy: EarthquakeSortBy.eventId,
            sortOrder: SortOrder.desc,
          ),
        ),
      );
    });

    test('currentLocation スコープで現在地と市区町村が解決できれば city パラメータを返す', () async {
      final container = _container(
        home: const HomeConfigurationModel(
          common: HomeCommonSettings(
            earthquakeHistoryScope: HomeEarthquakeHistoryScope.currentLocation,
          ),
        ),
        position: _position(),
        city: const MapDataItem(
          property: MapDataProperty(
            code: '13101',
            name: '東京都千代田区',
            nameKana: 'トウキョウトチヨダク',
          ),
        ),
      );

      EarthquakeHistoryParameter? result;
      final completer = Completer<EarthquakeHistoryParameter?>();
      final subscription = container.listen(
        homeEarthquakeHistoryParameterProvider,
        (_, next) {
          if (next case AsyncData(:final value) when value != null) {
            if (!completer.isCompleted) {
              completer.complete(value);
            }
          }
        },
        fireImmediately: true,
      );
      result = await completer.future;
      subscription.close();

      expect(result, isNotNull);
      expect(
        result,
        const EarthquakeHistoryParameter.city(
          sortBy: EarthquakeSortBy.eventId,
          sortOrder: SortOrder.desc,
          cityCode: '13101',
        ),
      );
    });

    test('currentLocation スコープで位置情報が取れないと null を返す', () async {
      final container = _container(
        home: const HomeConfigurationModel(
          common: HomeCommonSettings(
            earthquakeHistoryScope: HomeEarthquakeHistoryScope.currentLocation,
          ),
        ),
      );

      final result = await container.read(
        homeEarthquakeHistoryParameterProvider.future,
      );

      expect(result, isNull);
    });

    test('currentLocation スコープで市区町村に解決できない場合は null を返す', () async {
      final container = _container(
        home: const HomeConfigurationModel(
          common: HomeCommonSettings(
            earthquakeHistoryScope: HomeEarthquakeHistoryScope.currentLocation,
          ),
        ),
        position: _position(),
      );

      final result = await container.read(
        homeEarthquakeHistoryParameterProvider.future,
      );

      expect(result, isNull);
    });

    test('custom スコープで parameter が未設定なら null を返す', () async {
      final container = _container(
        home: const HomeConfigurationModel(
          common: HomeCommonSettings(
            earthquakeHistoryScope: HomeEarthquakeHistoryScope.custom,
          ),
        ),
      );

      final result = await container.read(
        homeEarthquakeHistoryParameterProvider.future,
      );

      expect(result, isNull);
    });

    test('custom スコープで parameter が設定済みならそれをそのまま返す', () async {
      const saved = EarthquakeHistoryParameter.prefecture(
        sortBy: EarthquakeSortBy.eventId,
        sortOrder: SortOrder.asc,
        prefectureCode: '13',
      );
      final container = _container(
        home: const HomeConfigurationModel(
          common: HomeCommonSettings(
            earthquakeHistoryScope: HomeEarthquakeHistoryScope.custom,
            parameter: saved,
          ),
        ),
      );

      final result = await container.read(
        homeEarthquakeHistoryParameterProvider.future,
      );

      expect(result, equals(saved));
    });
  });
}
