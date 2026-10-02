import 'package:eqmonitor/feature/parameter/data/model/common/parameter_common.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_metadata.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_catalog_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('観測点コード表を使わず細分区域と市区町村の親子関係を保持する', () {
    const earthquake = EarthquakeParameter(
      metadata: ParameterMetadata(
        type: ParameterType.earthquakeStations,
        schemaVersion: 1,
        sourceVersion: 'test',
        sourceUpdatedAt: null,
        sourceUrls: [],
        sha256: 'test',
      ),
      prefectures: [
        EarthquakeParameterPrefectureItem(
          code: '14',
          name: LocalizedName(ja: '神奈川県'),
          regions: [
            EarthquakeParameterRegionItem(
              code: '360',
              name: LocalizedName(ja: '神奈川県東部'),
              kana: 'かながわけんとうぶ',
              cities: [
                EarthquakeParameterCityItem(
                  code: '1410400',
                  name: LocalizedName(ja: '横浜中区'),
                  kana: 'よこはまなかく',
                  stations: [],
                ),
              ],
            ),
            EarthquakeParameterRegionItem(
              code: '361',
              name: LocalizedName(ja: '神奈川県西部'),
              kana: 'かながわけんせいぶ',
              cities: [
                EarthquakeParameterCityItem(
                  code: '1420600',
                  name: LocalizedName(ja: '小田原市'),
                  kana: 'おだわらし',
                  stations: [],
                ),
              ],
            ),
          ],
        ),
      ],
    );

    final catalog = const NotificationRegionCatalogBuilder().build(
      earthquake: earthquake,
    );

    expect(catalog.regions.map((region) => region.code), ['360', '361']);
    expect(catalog.regions.map((region) => region.name), ['神奈川県東部', '神奈川県西部']);
    expect(catalog.regionByCode('9140'), isNull);
    expect(catalog.regionByCode('360')?.cities.map((city) => city.code), [
      '1410400',
    ]);
    expect(catalog.regionByCode('361')?.cities.map((city) => city.code), [
      '1420600',
    ]);
    expect(catalog.regionByCode('360')?.cityByCode('1410400')?.kana, 'よこはまなかく');
    expect(catalog.unmappedCityCodes, isEmpty);
  });
}
