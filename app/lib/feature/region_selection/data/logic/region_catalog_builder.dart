import 'package:eqmonitor/feature/parameter/data/model/parameter.dart';
import 'package:eqmonitor/feature/region_selection/data/model/region_option.dart';
import 'package:eqmonitor/feature/settings/features/notification_settings/data/logic/notification_region_catalog_builder.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

final class const RegionCatalogBuilder() {
  List<RegionOption> build({
    required EarthquakeParameter earthquake,
    required JmaCodeTableParameter codeTable,
    required bool notification,
  }) {
    if (notification) {
      final catalog = const NotificationRegionCatalogBuilder().build(
        earthquake: earthquake,
      );
      final prefectureByRegion = {
        for (final prefecture in earthquake.prefectures)
          for (final region in prefecture.regions) region.code: prefecture,
      };
      return [
        for (final region in catalog.regions) ...[
          RegionOption(
            kind: .region,
            code: region.code,
            name: unorm.nfkc(region.name),
            kana: region.kana,
            prefectureCode: prefectureByRegion[region.code]?.code,
            prefectureName: prefectureByRegion[region.code]?.name.ja,
          ),
          for (final city in region.cities)
            RegionOption(
              kind: .city,
              code: city.code,
              name: unorm.nfkc(city.name),
              kana: city.kana,
              parentKind: .region,
              parentCode: region.code,
              parentName: unorm.nfkc(region.name),
              prefectureCode: prefectureByRegion[region.code]?.code,
              prefectureName: prefectureByRegion[region.code]?.name.ja,
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
            name: unorm.nfkc(region.name.ja),
            kana: region.kana,
            englishName: region.name.en,
            parentKind: .prefecture,
            parentCode: prefecture.code,
            parentName: prefecture.name.ja,
            prefectureCode: prefecture.code,
            prefectureName: prefecture.name.ja,
          ),
          for (final city in region.cities) ...[
            RegionOption(
              kind: .city,
              code: city.code,
              name: unorm.nfkc(city.name.ja),
              kana: city.kana,
              englishName: city.name.en,
              parentKind: .region,
              parentCode: region.code,
              parentName: unorm.nfkc(region.name.ja),
              prefectureCode: prefecture.code,
              prefectureName: prefecture.name.ja,
            ),
            for (final station in city.stations)
              RegionOption(
                kind: .station,
                code: station.code,
                name: unorm.nfkc(station.name.ja),
                parentKind: .city,
                parentCode: city.code,
                parentName: unorm.nfkc(city.name.ja),
                prefectureCode: prefecture.code,
                prefectureName: prefecture.name.ja,
              ),
          ],
        ],
      ],
      for (final epicenter in codeTable.codeTables.areaEpicenter)
        // 100 未満は PLUM 法の仮定震源で使う広域区分で、地震情報には現れない。
        if ((int.tryParse(epicenter.code) ?? 0) >= 100)
          RegionOption(
            kind: .epicenter,
            code: epicenter.code,
            name: unorm.nfkc(epicenter.name.ja),
            kana: epicenter.kana,
            englishName: epicenter.name.en,
          ),
    ];
  }
}
