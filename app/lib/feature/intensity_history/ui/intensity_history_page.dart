import 'dart:async';

import 'package:eqmonitor/core/component/error/error_card.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/map/jma_map_provider.dart';
import 'package:eqmonitor/core/provider/map/jma_map_utility.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/highest_intensity_entry.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/intensity_history_state.dart';
import 'package:eqmonitor/feature/intensity_history/data/model/region_code_mapping.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/city_highest_provider.dart';
import 'package:eqmonitor/feature/intensity_history/data/notifier/intensity_history_controller.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/city_detail_modal.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_error_overlay.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_legend.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/intensity_history_navigation_back_button.dart';
import 'package:eqmonitor/feature/intensity_history/ui/components/region_floating_panel.dart';
import 'package:eqmonitor/feature/intensity_history/ui/layer/intensity_fill_layer.dart';
import 'package:eqmonitor/feature/map/data/notifier/map_configuration_notifier.dart';
import 'package:eqmonitor/feature/map/utils/map_zoom_calculator.dart';
import 'package:eqmonitor/feature/parameter/data/model/earthquake/earthquake_parameter.dart';
import 'package:eqmonitor/feature/parameter/data/notifier/parameter_set_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jma_map/jma_map.dart';
import 'package:maplibre/maplibre.dart';

/// 地域別最大震度マップのページ。
///
/// - [initialPrefectureCode]: 指定時は起動直後に当該都道府県にフォーカスする(Lv2)。
/// - [initialCityCode]: 指定時はさらに市区町村詳細モーダルを自動表示する。
class IntensityHistoryPage extends HookConsumerWidget {
  const IntensityHistoryPage({
    this.initialPrefectureCode,
    this.initialCityCode,
    super.key,
  });

  final String? initialPrefectureCode;
  final String? initialCityCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapConfiguration = ref.watch(mapConfigurationProvider);

    return switch (mapConfiguration) {
      AsyncData(:final value) when value.styleString != null => _MapContent(
        styleString: value.styleString!,
        initialPrefectureCode: initialPrefectureCode,
        initialCityCode: initialCityCode,
      ),
      AsyncError(:final error) => Scaffold(
        appBar: AppBar(title: const Text('都道府県別 最大震度')),
        body: Center(child: ErrorCard(error: error)),
      ),
      _ => const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      ),
    };
  }
}

class _MapContent extends HookConsumerWidget {
  const _MapContent({
    required this.styleString,
    required this.initialPrefectureCode,
    required this.initialCityCode,
  });

  final String styleString;
  final String? initialPrefectureCode;
  final String? initialCityCode;

  static const _regionSourceLayerId = 'areaForecastLocalE';
  static const _citySourceLayerId = 'areaInformationCityQuake';

  // 日本全国の LngLatBounds
  static const _japanBounds = LngLatBounds(
    longitudeWest: JapanBounds.minLng,
    longitudeEast: JapanBounds.maxLng,
    latitudeSouth: JapanBounds.minLat,
    latitudeNorth: JapanBounds.maxLat,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intensityHistoryControllerProvider);
    final notifier = ref.read(intensityHistoryControllerProvider.notifier);
    final isCityState = state is IntensityHistoryStateCity;
    final canNavigateBack = Navigator.canPop(context);

    // ディープリンク初期化: 初回レンダリング後に実行
    useEffect(
      () {
        final prefCode = initialPrefectureCode;
        if (prefCode == null) {
          return null;
        }

        final paramAsync = ref.read(parameterSetProvider);
        final prefectures = paramAsync.whenOrNull(
          data: (p) => p.earthquake.prefectures,
        );
        var prefName = prefCode;
        if (prefectures != null) {
          final pref = prefectures.where((p) => p.code == prefCode).firstOrNull;
          if (pref != null) {
            prefName = pref.name.ja;
          }
        }
        notifier.focusPrefecture(code: prefCode, name: prefName);

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!context.mounted) {
            return;
          }
          final mapController = MapController.maybeOf(context);
          if (mapController == null) {
            return;
          }

          try {
            final jmaMap = await ref.read(jmaMapProvider.future);
            if (!context.mounted) {
              return;
            }

            final bounds = _buildPrefectureBounds(
              prefCode: prefCode,
              jmaMap: jmaMap,
              prefectures: prefectures ?? [],
            );
            if (bounds != null) {
              await mapController.fitBounds(
                bounds: bounds,
                padding: const EdgeInsets.all(48),
              );
            }
          } on Exception catch (e) {
            talker.log(e);
          }

          // cityCode の自動モーダル表示
          final cityCode = initialCityCode;
          if (cityCode != null && context.mounted) {
            await showCityDetailModal(
              context,
              cityCode: cityCode,
              cityName: cityCode,
            );
          }
        });

        return null;
      },
      const [],
    );

    final mapOptions = calculateJapanViewMapOptions(
      context: context,
      styleString: styleString,
    );

    return Scaffold(
      body: Stack(
        children: [
          MapLibreMap(
            options: mapOptions,
            onEvent: (event) async {
              if (event is MapEventClick) {
                final jmaMap = await ref.read(jmaMapProvider.future);
                if (!context.mounted) {
                  return;
                }
                await _handleTap(
                  context: context,
                  ref: ref,
                  event: event,
                  jmaMap: jmaMap,
                  state: state,
                );
              }
            },
            children: const [IntensityFillLayer()],
          ),

          // フローティングパネル（上部中央）
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: RegionFloatingPanel(),
                ),
              ),
            ),
          ),

          // 凡例（右下）
          const Positioned(
            bottom: 8,
            right: 8,
            child: SafeArea(child: IntensityHistoryLegend()),
          ),

          const Positioned(
            top: 0,
            left: 0,
            child: IntensityHistoryNavigationBackButton(),
          ),

          const IntensityHistoryErrorOverlay(),

          // 全国表示へ戻るボタン（左上、Lv2のときのみ表示）
          if (isCityState)
            Positioned(
              top: canNavigateBack ? 56 : 0,
              left: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Card(
                    elevation: 2,
                    clipBehavior: Clip.hardEdge,
                    child: InkWell(
                      onTap: () {
                        notifier.backToPrefecture();
                        _zoomToJapan(context);
                      },
                      child: const Tooltip(
                        message: '全国表示に戻る',
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.public_rounded),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _handleTap({
    required BuildContext context,
    required WidgetRef ref,
    required MapEventClick event,
    required Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
    required IntensityHistoryState state,
  }) async {
    final mapController = MapController.maybeOf(context);
    if (mapController == null) {
      return;
    }

    final hits = mapController.queryLayers(event.screenPoint);
    if (hits.isEmpty) {
      return;
    }

    final hitCity = hits.any((h) => h.sourceLayer == _citySourceLayerId);
    final hitRegion = hits.any((h) => h.sourceLayer == _regionSourceLayerId);

    if (!hitCity && !hitRegion) {
      return;
    }

    final latLng = JmaMap_LatLng(lat: event.point.lat, lng: event.point.lon);

    if (hitCity && state is IntensityHistoryStateCity) {
      // Lv2: 市区町村タップ → 詳細モーダル
      final mapData = jmaMap.areaInformationCity;
      final result = JmaMapUtility().findNearestItem(latLng, mapData);
      final item = result.item;
      if (item == null) {
        return;
      }

      final cityCode = item.property.code;
      final cityName = item.property.name;

      final prefCode = state.prefectureCode;
      final cityHighest = ref
          .read(cityHighestProvider(prefCode))
          .whenOrNull(data: (v) => v);
      HighestIntensityEntry? summary;
      if (cityHighest != null) {
        summary = cityHighest.where((e) => e.code == cityCode).firstOrNull;
      }

      if (!context.mounted) {
        return;
      }
      await showCityDetailModal(
        context,
        cityCode: cityCode,
        cityName: cityName,
        summary: summary,
      );
    } else if (hitRegion && state is IntensityHistoryStatePrefecture) {
      // Lv1: 細分区域タップ → 都道府県フォーカス
      final mapData = jmaMap.areaForecastLocalE;
      final result = JmaMapUtility().findNearestItem(latLng, mapData);
      final item = result.item;
      if (item == null) {
        return;
      }

      final regionCode = item.property.code;

      final paramAsync = ref.read(parameterSetProvider);
      final prefectures =
          paramAsync.whenOrNull(data: (p) => p.earthquake.prefectures) ?? [];

      final prefInfo = prefectureOfRegionCode(regionCode, prefectures);
      if (prefInfo == null) {
        return;
      }

      ref
          .read(intensityHistoryControllerProvider.notifier)
          .focusPrefecture(code: prefInfo.code, name: prefInfo.name);

      // 都道府県の bounds へズーム
      final bounds = _buildPrefectureBounds(
        prefCode: prefInfo.code,
        jmaMap: jmaMap,
        prefectures: prefectures,
      );
      if (bounds != null && context.mounted) {
        final c = MapController.maybeOf(context);
        if (c != null) {
          await c.fitBounds(
            bounds: bounds,
            padding: const EdgeInsets.all(48),
          );
        }
      }
    }
  }

  LngLatBounds? _buildPrefectureBounds({
    required String prefCode,
    required Map<JmaMapType, JmaMap_JmaMapData> jmaMap,
    required List<EarthquakeParameterPrefectureItem> prefectures,
  }) {
    final regionCodes = regionCodesOfPrefecture(prefCode, prefectures);
    if (regionCodes.isEmpty) {
      return null;
    }

    final regionSet = Set<String>.from(regionCodes);
    final items = jmaMap.areaForecastLocalE.data
        .where(
          (item) => regionSet.contains(item.property.code) && item.hasBounds(),
        )
        .toList();

    if (items.isEmpty) {
      return null;
    }

    // 1件目で初期化
    final firstBounds = items.first.bounds;
    var minLat = firstBounds.southWest.lat;
    var minLng = firstBounds.southWest.lng;
    var maxLat = firstBounds.northEast.lat;
    var maxLng = firstBounds.northEast.lng;

    for (final item in items.skip(1)) {
      final b = item.bounds;
      final swLat = b.southWest.lat;
      final swLng = b.southWest.lng;
      final neLat = b.northEast.lat;
      final neLng = b.northEast.lng;

      if (swLat < minLat) {
        minLat = swLat;
      }
      if (swLng < minLng) {
        minLng = swLng;
      }
      if (neLat > maxLat) {
        maxLat = neLat;
      }
      if (neLng > maxLng) {
        maxLng = neLng;
      }
    }

    return LngLatBounds(
      longitudeWest: minLng,
      longitudeEast: maxLng,
      latitudeSouth: minLat,
      latitudeNorth: maxLat,
    );
  }

  void _zoomToJapan(BuildContext context) {
    final c = MapController.maybeOf(context);
    if (c == null) {
      return;
    }
    unawaited(
      c.fitBounds(
        bounds: _japanBounds,
        padding: const EdgeInsets.all(32),
      ),
    );
  }
}
