import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_history_map_action.g.dart';

@Riverpod(keepAlive: true)
IntensityHistoryMapAction intensityHistoryMapAction(Ref ref) =>
    const IntensityHistoryMapAction();

/// 市区町村別最大震度マップのタップ操作を担う。
class IntensityHistoryMapAction {
  const new();

  /// 地図タップを市区町村の選択として解釈する。
  ///
  /// ズームに依らずポリゴン判定で市区町村を特定する。都道府県・細分区域への
  /// カメラ寄せは行わない。陸域外・所属都道府県を解決できない場合は選択を
  /// 解除する。
  ///
  /// タップ地点の判定は Worker Isolate 上の
  /// [jmaMapAreaInformationCityInsideProvider] に委ね、UI スレッドを塞がない。
  Future<void> handleMapTap({
    required WidgetRef ref,
    required BuildContext context,
    required Geographic point,
  }) async {
    final prefectures = ref
        .read(parameterSetProvider)
        .valueOrPrevious
        ?.earthquake
        .prefectures;
    if (prefectures == null || prefectures.isEmpty) {
      return;
    }

    final city = await ref.read(
      jmaMapAreaInformationCityInsideProvider(
        LatLng(point.lat, point.lon),
      ).future,
    );
    final target = cityTapTargetOf(
      cityCode: city?.property?.code,
      cityName: city?.property?.name,
      prefectures: prefectures,
    );
    if (target == null) {
      ref.read(intensityHistoryControllerProvider.notifier).deselectCity();
      return;
    }
    if (!context.mounted) {
      return;
    }
    await handleCityTap(
      ref: ref,
      context: context,
      cityCode: target.cityCode,
      cityName: target.cityName,
      prefectureName: target.prefectureName,
    );
  }

  /// ヒットした市区町村と所属都道府県を組にする。解決できない場合は `null`。
  ({String cityCode, String cityName, String prefectureName})? cityTapTargetOf({
    required String? cityCode,
    required String? cityName,
    required List<EarthquakeParameterPrefectureItem> prefectures,
  }) {
    if (cityCode == null || cityName == null) {
      return null;
    }
    final cityPrefecture = prefectureOf(
      cityCode: cityCode,
      prefectures: prefectures,
    );
    if (cityPrefecture == null) {
      return null;
    }
    return (
      cityCode: cityCode,
      cityName: cityName,
      prefectureName: cityPrefecture.name.ja,
    );
  }

  /// 市区町村コードから所属都道府県を解決する。
  EarthquakeParameterPrefectureItem? prefectureOf({
    required String cityCode,
    required List<EarthquakeParameterPrefectureItem> prefectures,
  }) {
    final prefectureCode = RegionCodeMapping.prefectureCodeOfCity(
      cityCode,
      prefectures,
    );
    if (prefectureCode == null) {
      return null;
    }
    return prefectures
        .where((prefecture) => prefecture.code == prefectureCode)
        .firstOrNull;
  }

  Future<void> handleCityTap({
    required WidgetRef ref,
    required BuildContext context,
    required String cityCode,
    required String cityName,
    required String prefectureName,
  }) async {
    ref
        .read(intensityHistoryControllerProvider.notifier)
        .selectCity(
          code: cityCode,
          name: cityName,
          prefectureName: prefectureName,
        );

    await CityDetailModalAction().show(
      context,
      cityCode: cityCode,
      cityName: cityName,
      prefectureName: prefectureName,
      maxIntensity: cityMaxIntensityOf(ref: ref, cityCode: cityCode),
    );
  }

  /// ディープリンクで市区町村詳細モーダルを開く。
  ///
  /// カメラは動かさない。[cityCode] が無い、または都道府県配下に存在しない
  /// 場合は何もしない。
  Future<void> openFromDeepLink({
    required WidgetRef ref,
    required BuildContext context,
    required String prefectureCode,
    required String? cityCode,
  }) async {
    if (cityCode == null) {
      return;
    }
    final prefectures = ref
        .read(parameterSetProvider)
        .valueOrPrevious
        ?.earthquake
        .prefectures;
    if (prefectures == null || prefectures.isEmpty) {
      return;
    }
    final prefecture = prefectures
        .where((prefecture) => prefecture.code == prefectureCode)
        .firstOrNull;
    if (prefecture == null) {
      return;
    }

    final city = prefecture.regions
        .expand((region) => region.cities)
        .where((city) => city.code == cityCode)
        .firstOrNull;
    if (city == null || !context.mounted) {
      return;
    }
    await handleCityTap(
      ref: ref,
      context: context,
      cityCode: city.code,
      cityName: city.name.ja,
      prefectureName: prefecture.name.ja,
    );
  }

  JmaIntensity? cityMaxIntensityOf({
    required WidgetRef ref,
    required String cityCode,
  }) => ref
      .read(cityMaxIntensityProvider)
      .valueOrPrevious
      ?.intensityOfCity(cityCode);
}
