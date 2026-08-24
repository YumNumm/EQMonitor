import 'dart:ui';

import 'package:eqmonitor_map/eqmonitor_map.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const regionStyle = EarthquakeAreaStyle(
    code: '130',
    color: Color(0xfff44336),
    opacity: 0.6,
  );
  const cityStyle = EarthquakeAreaStyle(
    code: '131016',
    color: Color(0xffff9800),
    opacity: 0.7,
  );
  const station = EarthquakeObservationPoint(
    id: 'jma-44132',
    longitude: 139.6917,
    latitude: 35.6895,
    color: Color(0xffffeb3b),
    radiusLogicalPixels: 6.7,
  );

  EarthquakeMapOverlaySnapshot snapshot({
    String sourceId = 'earthquake-20260823',
    int revision = 42,
    double regionToCityZoom = 6,
    double stationMinZoom = 6,
    List<EarthquakeAreaStyle> regionStyles = const [regionStyle],
    List<EarthquakeAreaStyle> cityStyles = const [cityStyle],
    List<EarthquakeObservationPoint> stations = const [station],
  }) => createEarthquakeMapOverlaySnapshot(
    sourceId: sourceId,
    revision: revision,
    regionToCityZoom: regionToCityZoom,
    stationMinZoom: stationMinZoom,
    regionStyles: regionStyles,
    cityStyles: cityStyles,
    stations: stations,
  );

  test('rejects blank source ID after trimming', () {
    expect(() => snapshot(sourceId: '  '), throwsArgumentError);
  });

  test('rejects negative revision', () {
    expect(() => snapshot(revision: -1), throwsArgumentError);
  });

  test('rejects non-finite zoom values', () {
    expect(() => snapshot(regionToCityZoom: double.nan), throwsArgumentError);
    expect(
      () => snapshot(stationMinZoom: double.infinity),
      throwsArgumentError,
    );
  });

  test('rejects blank area codes and opacity outside the unit interval', () {
    expect(
      () => snapshot(
        regionStyles: const [
          EarthquakeAreaStyle(
            code: ' ',
            color: Color(0xfff44336),
            opacity: 0.6,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        cityStyles: const [
          EarthquakeAreaStyle(
            code: '131016',
            color: Color(0xffff9800),
            opacity: 1.01,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        cityStyles: const [
          EarthquakeAreaStyle(
            code: '131016',
            color: Color(0xffff9800),
            opacity: double.nan,
          ),
        ],
      ),
      throwsArgumentError,
    );
  });

  test('rejects duplicate codes within either area layer', () {
    expect(
      () => snapshot(regionStyles: const [regionStyle, regionStyle]),
      throwsArgumentError,
    );
    expect(
      () => snapshot(cityStyles: const [cityStyle, cityStyle]),
      throwsArgumentError,
    );
  });

  test('allows a region and city to use the same code', () {
    final result = snapshot(
      cityStyles: const [
        EarthquakeAreaStyle(
          code: '130',
          color: Color(0xffff9800),
          opacity: 0.7,
        ),
      ],
    );

    expect(result.regionStyles.single.code, '130');
    expect(result.cityStyles.single.code, '130');
  });

  test('rejects invalid station identity, coordinates, and radius', () {
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: ' ',
            longitude: 139.6917,
            latitude: 35.6895,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: 6.7,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: 'invalid-longitude',
            longitude: 180.1,
            latitude: 35.6895,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: 6.7,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: 'invalid-latitude',
            longitude: 139.6917,
            latitude: double.nan,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: 6.7,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: 'invalid-radius',
            longitude: 139.6917,
            latitude: 35.6895,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: 0,
          ),
        ],
      ),
      throwsArgumentError,
    );
    expect(
      () => snapshot(
        stations: const [
          EarthquakeObservationPoint(
            id: 'infinite-radius',
            longitude: 139.6917,
            latitude: 35.6895,
            color: Color(0xffffeb3b),
            radiusLogicalPixels: double.infinity,
          ),
        ],
      ),
      throwsArgumentError,
    );
  });

  test('rejects duplicate station IDs', () {
    expect(
      () => snapshot(stations: const [station, station]),
      throwsArgumentError,
    );
  });

  test('takes unmodifiable copies of every input collection', () {
    final regionStyles = <EarthquakeAreaStyle>[regionStyle];
    final cityStyles = <EarthquakeAreaStyle>[cityStyle];
    final stations = <EarthquakeObservationPoint>[station];
    final result = snapshot(
      regionStyles: regionStyles,
      cityStyles: cityStyles,
      stations: stations,
    );

    regionStyles.clear();
    cityStyles.clear();
    stations.clear();

    expect(result.regionStyles, const [regionStyle]);
    expect(result.cityStyles, const [cityStyle]);
    expect(result.stations, const [station]);
    expect(() => result.regionStyles.add(regionStyle), throwsUnsupportedError);
    expect(() => result.cityStyles.add(cityStyle), throwsUnsupportedError);
    expect(() => result.stations.add(station), throwsUnsupportedError);
  });
}
