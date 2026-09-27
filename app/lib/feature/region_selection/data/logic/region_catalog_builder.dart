import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_catalog_builder.dart';

final class const RegionCatalogBuilder() {
  List<RegionOption> build({
    required EarthquakeParameter earthquake,
    required JmaCodeTableParameter codeTable,
    required bool notification,
  }) {
    if (notification) {
      final catalog = const NotificationRegionCatalogBuilder().build(
        codeTable: codeTable,
        earthquake: earthquake,
      );
      return [
        for (final region in catalog.regions) ...[
          RegionOption(
            kind: .eewRegion,
            code: region.code,
            name: region.name,
            kana: region.kana,
          ),
          for (final city in region.cities)
            RegionOption(
              kind: .city,
              code: city.code,
              name: city.name,
              kana: city.kana,
              parentKind: .eewRegion,
              parentCode: region.code,
              parentName: region.name,
            ),
        ],
      ];
    }
    final prefectureNames = {
      for (final item
          in codeTable.codeTables.areaInformationPrefectureEarthquake)
        item.code: item,
    };
    return [
      for (final prefecture in earthquake.prefectures) ...[
        RegionOption(
          kind: .prefecture,
          code: prefecture.code,
          name: prefecture.name.ja,
          kana: prefectureNames[prefecture.code]?.kana,
          englishName: prefecture.name.en,
        ),
        for (final region in prefecture.regions) ...[
          RegionOption(
            kind: .region,
            code: region.code,
            name: region.name.ja,
            kana: region.kana,
            englishName: region.name.en,
            parentKind: .prefecture,
            parentCode: prefecture.code,
            parentName: prefecture.name.ja,
            prefectureCode: prefecture.code,
          ),
          for (final city in region.cities) ...[
            RegionOption(
              kind: .city,
              code: city.code,
              name: city.name.ja,
              kana: city.kana,
              englishName: city.name.en,
              parentKind: .region,
              parentCode: region.code,
              parentName: '${prefecture.name.ja}・${region.name.ja}',
              prefectureCode: prefecture.code,
            ),
            for (final station in city.stations)
              RegionOption(
                kind: .station,
                code: station.code,
                name: station.name.ja,
                parentKind: .city,
                parentCode: city.code,
                parentName: city.name.ja,
                prefectureCode: prefecture.code,
              ),
          ],
        ],
      ],
      for (final epicenter in codeTable.codeTables.areaEpicenter)
        RegionOption(
          kind: .epicenter,
          code: epicenter.code,
          name: epicenter.name.ja,
          kana: epicenter.kana,
          englishName: epicenter.name.en,
        ),
    ];
  }
}
