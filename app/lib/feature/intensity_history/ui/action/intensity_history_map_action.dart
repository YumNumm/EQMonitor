import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_max_intensity_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/prefecture_bounds_resolver.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
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

/// 市区町村別最大震度マップのタップ操作・カメラ操作をまとめて担う。
class IntensityHistoryMapAction {
  const new();

  /// 日本全国の表示範囲。
  static const japanBounds = LngLatBounds(
    longitudeWest: JapanBounds.minLng,
    longitudeEast: JapanBounds.maxLng,
    latitudeSouth: JapanBounds.minLat,
    latitudeNorth: JapanBounds.maxLat,
  );

  /// 都道府県へ寄せるときの余白。
  ///
  /// 上部のフローティングパネル・下部の凡例に地域が隠れないよう、
  /// 上下に厚めの余白を確保する。
  static const focusPadding = EdgeInsets.fromLTRB(24, 96, 24, 88);

  /// タップを市区町村の選択として解釈する最小ズーム。
  ///
  /// 市区町村ポリゴンは全ズームのタイルに存在し塗りも全国表示で出るが、その
  /// ズームでは 1 市区町村が数 px しかなく、タップ位置から狙った市区町村を
  /// 取り出せない。これ未満では選択せず、市区町村を選べるズームまでカメラを
  /// 寄せる。
  ///
  /// タイル側の制約 (`BaseMapTileSpec.cityMinZoom`) とは別の判断なので、
  /// そちらを参照しない。
  static const cityTapMinZoom = 6.0;

  /// 地図タップを解釈する。
  ///
  /// - [cityTapMinZoom] 以上: 市区町村を選択して詳細モーダルを開く。
  /// - それ未満のズーム: 市区町村を選べるズームまでカメラを寄せる。
  ///
  /// タップ地点を含む地域の判定は Worker Isolate 上のポリゴン判定
  /// ([jmaMapAreaInformationCityInsideProvider] /
  /// [jmaMapAreaForecastLocalEInsideProvider]) に委ね、UI スレッドを塞がない。
  Future<void> handleMapTap({
    required WidgetRef ref,
    required BuildContext context,
    required MapController controller,
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

    final latLng = LatLng(point.lat, point.lon);
    final zoom = controller.camera?.zoom ?? 0;

    // 市区町村を狙って選べないズームでは、市区町村としては解釈しない。
    if (zoom >= cityTapMinZoom) {
      final city = await ref.read(
        jmaMapAreaInformationCityInsideProvider(latLng).future,
      );
      final property = city?.property;
      // 所属都道府県を解決できない市区町村は選択解除に留める。
      final cityPrefecture = property == null
          ? null
          : prefectureOf(cityCode: property.code, prefectures: prefectures);
      if (property != null && cityPrefecture != null) {
        if (context.mounted) {
          await handleCityTap(
            ref: ref,
            context: context,
            cityCode: property.code,
            cityName: property.name,
            prefectureName: cityPrefecture.name.ja,
          );
        }
        return;
      }
      // 陸域外・解決不能。選択中の市区町村があれば解除するだけに留める。
      ref.read(intensityHistoryControllerProvider.notifier).deselectCity();
      return;
    }

    final region = await ref.read(
      jmaMapAreaForecastLocalEInsideProvider(latLng).future,
    );
    final regionCode = region?.property?.code;
    if (regionCode == null) {
      return;
    }

    await handleRegionTap(
      ref: ref,
      controller: controller,
      prefectures: prefectures,
      regionCode: regionCode,
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

  /// 低ズームで細分区域をタップしたときに、市区町村を選べるズームまで寄せる。
  Future<void> handleRegionTap({
    required WidgetRef ref,
    required MapController controller,
    required List<EarthquakeParameterPrefectureItem> prefectures,
    required String regionCode,
  }) async {
    final prefecture = RegionCodeMapping.prefectureOfRegionCode(
      regionCode,
      prefectures,
    );
    if (prefecture == null) {
      return;
    }

    ref.read(intensityHistoryControllerProvider.notifier).deselectCity();
    await moveCameraToPrefecture(
      ref: ref,
      controller: controller,
      prefectureCode: prefecture.code,
      seedRegionCode: regionCode,
    );
  }

  /// ディープリンク（他画面からの直接遷移）で都道府県・市区町村へ寄せる。
  Future<void> openFromDeepLink({
    required WidgetRef ref,
    required BuildContext context,
    required MapController controller,
    required String prefectureCode,
    required String? cityCode,
  }) async {
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

    final city = cityCode == null
        ? null
        : prefecture.regions
              .expand((region) => region.cities)
              .where((city) => city.code == cityCode)
              .firstOrNull;

    await moveCameraToPrefecture(
      ref: ref,
      controller: controller,
      prefectureCode: prefecture.code,
    );

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

  /// 指定都道府県が収まる範囲までカメラを移動する。
  ///
  /// 状態は持たない（都道府県フォーカスという概念は無い）。市区町村を選べる
  /// ズームまで寄せるためのカメラ操作のみ。
  Future<void> moveCameraToPrefecture({
    required WidgetRef ref,
    required MapController controller,
    required String prefectureCode,
    String? seedRegionCode,
  }) async {
    final prefectures = ref
        .read(parameterSetProvider)
        .valueOrPrevious
        ?.earthquake
        .prefectures;
    if (prefectures == null) {
      return;
    }

    final jmaMap = await ref.read(jmaMapProvider.future);
    final bounds = ref
        .read(prefectureBoundsResolverProvider)
        .resolve(
          prefectureCode: prefectureCode,
          prefectures: prefectures,
          jmaMap: jmaMap,
          seedRegionCode: seedRegionCode,
        );
    if (bounds == null) {
      return;
    }
    await controller.fitBounds(bounds: bounds, padding: focusPadding);
  }

  JmaIntensity? cityMaxIntensityOf({
    required WidgetRef ref,
    required String cityCode,
  }) => ref
      .read(cityMaxIntensityProvider)
      .valueOrPrevious
      ?.intensityOfCity(cityCode);
}
