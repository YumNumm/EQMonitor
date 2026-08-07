import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/data/repository/prefecture_bounds_resolver.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:eqmonitor/feature/location/data/nearest_jma_feature.dart';
import 'package:eqmonitor/feature/map/data/model/base_map_tile_spec.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lat_lng/lat_lng.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_history_map_action.g.dart';

@Riverpod(keepAlive: true)
IntensityHistoryMapAction intensityHistoryMapAction(Ref ref) =>
    const IntensityHistoryMapAction();

/// 地域別最大震度マップのタップ操作・カメラ操作をまとめて担う。
class IntensityHistoryMapAction {
  const IntensityHistoryMapAction();

  /// 日本全国の表示範囲。
  static const japanBounds = LngLatBounds(
    longitudeWest: JapanBounds.minLng,
    longitudeEast: JapanBounds.maxLng,
    latitudeSouth: JapanBounds.minLat,
    latitudeNorth: JapanBounds.maxLat,
  );

  /// 都道府県フォーカス時の余白。
  ///
  /// 上部のフローティングパネル・下部の凡例に地域が隠れないよう、
  /// 上下に厚めの余白を確保する。
  static const focusPadding = EdgeInsets.fromLTRB(24, 96, 24, 88);

  static const japanPadding = EdgeInsets.all(24);

  /// 地図タップを解釈して、都道府県フォーカス / 市区町村選択を行う。
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

    final state = ref.read(intensityHistoryControllerProvider);
    final latLng = LatLng(point.lat, point.lon);
    final zoom = controller.camera?.zoom ?? 0;

    // 市区町村ポリゴンが描画されないズームでは、市区町村としては解釈しない。
    if (state is IntensityHistoryStateCity &&
        zoom >= BaseMapTileSpec.cityMinZoom) {
      final city = await ref.read(
        jmaMapAreaInformationCityInsideProvider(latLng).future,
      );
      final property = city?.property;
      if (property != null && context.mounted) {
        await handleCityTap(
          ref: ref,
          context: context,
          controller: controller,
          prefectures: prefectures,
          focusedPrefectureCode: state.prefectureCode,
          cityCode: property.code,
          cityName: property.name,
        );
        return;
      }
    }

    final region = await ref.read(
      jmaMapAreaForecastLocalEInsideProvider(latLng).future,
    );
    final regionCode = region?.property?.code;
    if (regionCode == null) {
      // 日本の陸域外。選択中の市区町村があれば解除するだけに留める。
      if (state is IntensityHistoryStateCity &&
          state.selectedCityCode != null) {
        ref.read(intensityHistoryControllerProvider.notifier).deselectCity();
      }
      return;
    }

    if (!context.mounted) {
      return;
    }
    await handleRegionTap(
      ref: ref,
      context: context,
      controller: controller,
      prefectures: prefectures,
      regionCode: regionCode,
    );
  }

  Future<void> handleCityTap({
    required WidgetRef ref,
    required BuildContext context,
    required MapController controller,
    required List<EarthquakeParameterPrefectureItem> prefectures,
    required String focusedPrefectureCode,
    required String cityCode,
    required String cityName,
  }) async {
    final prefectureCode = prefectureCodeOfCity(cityCode, prefectures);
    if (prefectureCode == null) {
      return;
    }

    final prefecture = prefectures
        .where((prefecture) => prefecture.code == prefectureCode)
        .firstOrNull;
    if (prefecture == null) {
      return;
    }

    if (prefectureCode != focusedPrefectureCode) {
      // 別の都道府県の市区町村 → まずその都道府県へフォーカスを移す。
      await focusPrefecture(
        ref: ref,
        context: context,
        controller: controller,
        prefectureCode: prefectureCode,
        prefectureName: prefecture.name.ja,
        selectedCityCode: cityCode,
        selectedCityName: cityName,
      );
      return;
    }

    ref
        .read(intensityHistoryControllerProvider.notifier)
        .selectCity(code: cityCode, name: cityName);

    if (!context.mounted) {
      return;
    }
    await showCityDetailModal(
      context,
      cityCode: cityCode,
      cityName: cityName,
      regionName: prefecture.name.ja,
      summary: cityHighestEntry(
        ref: ref,
        prefectureCode: prefectureCode,
        cityCode: cityCode,
      ),
    );
  }

  Future<void> handleRegionTap({
    required WidgetRef ref,
    required BuildContext context,
    required MapController controller,
    required List<EarthquakeParameterPrefectureItem> prefectures,
    required String regionCode,
  }) async {
    final prefecture = prefectureOfRegionCode(regionCode, prefectures);
    if (prefecture == null) {
      return;
    }

    final state = ref.read(intensityHistoryControllerProvider);
    if (state is IntensityHistoryStateCity &&
        state.prefectureCode == prefecture.code) {
      // フォーカス中の都道府県内。市区町村として解釈できなかったので、
      // 選択中の市区町村の解除だけを行う。
      ref.read(intensityHistoryControllerProvider.notifier).deselectCity();
      return;
    }

    await focusPrefecture(
      ref: ref,
      context: context,
      controller: controller,
      prefectureCode: prefecture.code,
      prefectureName: prefecture.name,
      seedRegionCode: regionCode,
    );
  }

  /// ディープリンク（他画面からの直接遷移）で都道府県・市区町村へフォーカスする。
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

    await focusPrefecture(
      ref: ref,
      context: context,
      controller: controller,
      prefectureCode: prefecture.code,
      prefectureName: prefecture.name.ja,
      selectedCityCode: city?.code,
      selectedCityName: city?.name.ja,
    );

    if (city == null || !context.mounted) {
      return;
    }
    await showCityDetailModal(
      context,
      cityCode: city.code,
      cityName: city.name.ja,
      regionName: prefecture.name.ja,
      summary: cityHighestEntry(
        ref: ref,
        prefectureCode: prefecture.code,
        cityCode: city.code,
      ),
    );
  }

  Future<void> focusPrefecture({
    required WidgetRef ref,
    required BuildContext context,
    required MapController controller,
    required String prefectureCode,
    required String prefectureName,
    String? selectedCityCode,
    String? selectedCityName,
    String? seedRegionCode,
  }) async {
    ref
        .read(intensityHistoryControllerProvider.notifier)
        .focusPrefecture(
          code: prefectureCode,
          name: prefectureName,
          selectedCityCode: selectedCityCode,
          selectedCityName: selectedCityName,
        );

    final prefectures = ref
        .read(parameterSetProvider)
        .valueOrPrevious
        ?.earthquake
        .prefectures;
    if (prefectures == null) {
      return;
    }

    final jmaMap = await ref.read(jmaMapProvider.future);
    if (!context.mounted) {
      return;
    }
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

  /// 全国表示（Lv1）に戻す。
  Future<void> backToJapan({
    required WidgetRef ref,
    required MapController controller,
  }) async {
    ref.read(intensityHistoryControllerProvider.notifier).backToPrefecture();
    await controller.fitBounds(bounds: japanBounds, padding: japanPadding);
  }

  HighestIntensityEntry? cityHighestEntry({
    required WidgetRef ref,
    required String prefectureCode,
    required String cityCode,
  }) => ref
      .read(cityHighestProvider(prefectureCode))
      .valueOrPrevious
      ?.where((entry) => entry.code == cityCode)
      .firstOrNull;
}
