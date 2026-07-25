import 'dart:convert';

import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/theme/model/app_theme.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_station.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/lpgm_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart';
import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lat_lng/lat_lng.dart';

StationIntensityNode _station(
  String code, {
  JmaIntensity? maxIntensity,
  JmaLpgmIntensity? maxLpgmIntensity,
}) {
  final item = EarthquakeParameterStationItem(
    code: code,
    noCode: code,
    name: LocalizedName(ja: '観測点$code'),
    kana: null,
    status: EarthquakeStationStatus.operating,
    sourceStatus: 'test',
    owner: 'test',
    location: const LatLng(35, 139),
  );
  return StationIntensityNode(
    station: item,
    intensity: IntensityStation(
      code: item.code,
      name: item.name.ja,
      sva: null,
      prePeriods: null,
      maxIntensity: maxIntensity,
      maxLpgmIntensity: maxLpgmIntensity,
    ),
  );
}

EarthquakeIntensity _intensity() {
  const prefecture = IntensityPrefecture(
    prefecture: EarthquakeParameterPrefectureItem(
      code: '001',
      name: LocalizedName(ja: 'テスト都道府県'),
      regions: [],
    ),
    maxIntensity: JmaIntensity.four,
  );
  const city = EarthquakeParameterCityItem(
    code: '001001',
    name: LocalizedName(ja: 'テスト市区町村'),
    kana: null,
    stations: [],
  );
  const region = EarthquakeParameterRegionItem(
    code: '001',
    name: LocalizedName(ja: 'テスト地域'),
    kana: null,
    cities: [],
  );
  final maxStation = _station(
    '001001001',
    maxIntensity: JmaIntensity.four,
    maxLpgmIntensity: JmaLpgmIntensity.two,
  );
  final subStation = _station(
    '001001002',
    maxIntensity: JmaIntensity.three,
    maxLpgmIntensity: JmaLpgmIntensity.one,
  );
  return EarthquakeIntensity(
    maxIntensity: JmaIntensity.four,
    maxLpgmIntensity: JmaLpgmIntensity.two,
    regions: const {},
    intensityTree: {
      JmaIntensity.four: [
        PrefectureIntensityNode(
          prefecture: prefecture,
          cities: [
            CityIntensityNode(
              city: city,
              maxIntensity: JmaIntensity.four,
              stations: [maxStation, subStation],
            ),
          ],
        ),
      ],
    },
    lpgmIntensityTree: {
      JmaLpgmIntensity.two: [
        PrefectureLpgmIntensityNode(
          region: region,
          maxLpgmIntensity: JmaLpgmIntensity.two,
          cities: [
            CityLpgmIntensityNode(
              city: city,
              maxLpgmIntensity: JmaLpgmIntensity.two,
              stations: [
                StationLpgmIntensityNode(
                  station: maxStation.station,
                  intensity: maxStation.intensity,
                ),
                StationLpgmIntensityNode(
                  station: subStation.station,
                  intensity: subStation.intensity,
                ),
              ],
            ),
          ],
        ),
      ],
    },
  );
}

List<Map<String, dynamic>> _properties(String geoJson) {
  final decoded = jsonDecode(geoJson) as Map<String, dynamic>;
  return (decoded['features'] as List)
      .cast<Map<String, dynamic>>()
      .map((f) => f['properties']! as Map<String, dynamic>)
      .toList();
}

void main() {
  final colorModel = AppTheme.eqmonitorDefault().light!.intensity;
  const builder = EarthquakeHistoryStationGeoJsonBuilder();

  test('JMA: 全観測点に iconIdFull/iconIdPlain/isMax が付与される', () {
    final geoJson = builder.build(
      intensity: _intensity(),
      colorModel: colorModel,
      showingLpgmIntensity: false,
    );
    final props = _properties(geoJson);

    expect(props, hasLength(2));
    final max = props.singleWhere((p) => p['isMax'] == true);
    expect(max['iconIdFull'], 'JmaIntensity.small.four');
    expect(max['iconIdPlain'], 'JmaIntensity.smallWithoutText.four');
    final sub = props.singleWhere((p) => p['isMax'] == false);
    expect(sub['iconIdFull'], 'JmaIntensity.small.three');
    expect(sub['iconIdPlain'], 'JmaIntensity.smallWithoutText.three');
  });

  test('LPGM: maxLpgmIntensity 基準で isMax が付与される', () {
    final geoJson = builder.build(
      intensity: _intensity(),
      colorModel: colorModel,
      showingLpgmIntensity: true,
    );
    final props = _properties(geoJson);

    expect(props, hasLength(2));
    final max = props.singleWhere((p) => p['isMax'] == true);
    expect(max['iconIdFull'], 'JmaLpgmIntensity.small.two');
    expect(max['iconIdPlain'], 'JmaLpgmIntensity.smallWithoutText.two');
    final sub = props.singleWhere((p) => p['isMax'] == false);
    expect(sub['iconIdFull'], 'JmaLpgmIntensity.small.one');
  });
}
