import 'package:eqmonitor/core/extension/async_value.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_city_camera.dart';
import 'package:eqmonitor/feature/location/data/model/map_data_item.dart';
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
    IntensityHistoryMapAction();

/// 市区町村別最大震度マップのタップ操作を担う。
class IntensityHistoryMapAction() {
  var _tapSequence = 0;

  /// 地図タップを市区町村の選択として解釈する。
  ///
  /// ズームに依らずポリゴン判定で市区町村を特定する。都道府県・細分区域への
  /// カメラ寄せは行わず、市区町村の選択枠を詳細シートの上に収める。
  /// 陸域外・所属都道府県を解決できない場合は選択を解除する。
  ///
  /// タップ地点の判定は Worker Isolate 上の
  /// [jmaMapAreaInformationCityInsideProvider] に委ね、UI スレッドを塞がない。
  Future<void> handleMapTap({
    required WidgetRef ref,
    required BuildContext context,
    required Geographic point,
    required MapController mapController,
  }) async {
    final prefectures = ref
        .read(parameterSetProvider)
        .valueOrPrevious
        ?.earthquake
        .prefectures;
    if (prefectures == null || prefectures.isEmpty) {
      return;
    }

    final sequence = ++_tapSequence;
    final city = await ref.read(
      jmaMapAreaInformationCityInsideProvider(
        LatLng(point.lat, point.lon),
      ).future,
    );
    if (sequence != _tapSequence || !context.mounted) {
      return;
    }
    final target = cityTapTargetOf(
      cityCode: city?.property?.code,
      cityName: city?.property?.name,
      prefectures: prefectures,
    );
    if (target == null) {
      ref.read(intensityHistoryControllerProvider.notifier).deselectCity();
      return;
    }
    selectCity(
      ref: ref,
      cityCode: target.cityCode,
      cityName: target.cityName,
      prefectureName: target.prefectureName,
    );
    await fitCityAboveSheet(
      context: context,
      mapController: mapController,
      bounds: city?.bounds,
    );
  }

  Future<void> fitCityAboveSheet({
    required BuildContext context,
    required MapController mapController,
    required MapDataBounds? bounds,
  }) async {
    if (bounds == null) {
      return;
    }
    const camera = IntensityHistoryCityCamera();
    final padding = camera.padding(
      viewportSize: MediaQuery.sizeOf(context),
      safePadding: MediaQuery.paddingOf(context),
    );
    final result = await mapController.animateCamera(
      CameraUpdate.bounds(
        GeoBox(
          west: bounds.southWest.lng,
          south: bounds.southWest.lat,
          east: bounds.northEast.lng,
          north: bounds.northEast.lat,
        ),
        padding: padding,
        maxZoom: camera.maxZoomFrom(mapController.camera?.zoom),
      ),
    );
    if (result == .cancelled) {
      talker.debug('IntensityHistoryMapAction: fitBounds ended early');
    }
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

  void selectCity({
    required WidgetRef ref,
    required String cityCode,
    required String cityName,
    required String prefectureName,
  }) {
    ref
        .read(intensityHistoryControllerProvider.notifier)
        .selectCity(
          code: cityCode,
          name: cityName,
          prefectureName: prefectureName,
        );
  }

  /// ディープリンクで市区町村詳細シートを開く。
  ///
  /// 選択枠は初期カメラでシートの上に収めているため、ここではカメラを動かさない。
  /// [cityCode] が無い、または都道府県配下に存在しない場合は何もしない。
  void openFromDeepLink({
    required WidgetRef ref,
    required String prefectureCode,
    required String? cityCode,
  }) {
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
    if (city == null) {
      return;
    }
    selectCity(
      ref: ref,
      cityCode: city.code,
      cityName: city.name.ja,
      prefectureName: prefecture.name.ja,
    );
  }
}
