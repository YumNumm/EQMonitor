import 'dart:async';
import 'dart:convert';

import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/core/util/map/remove_map_style_resources.dart';
import 'package:eqmonitor/core/util/nullable_value_requirement.dart';
import 'package:eqmonitor/feature/eew/data/model/eew_telegram_item.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class EewHypocenterLayer extends HookConsumerWidget {
  const new({
    required this.eews,
    this.enableBlink = false,
    super.key,
  });

  final List<EewTelegramItem> eews;
  final bool enableBlink;

  static const ({String lowPrecise, String normal}) sourceId = (
    normal: 'eew-hypocenter-normal',
    lowPrecise: 'eew-hypocenter-low-precise',
  );
  static const ({String lowPrecise, String normal}) layerId = (
    normal: 'eew-hypocenter-normal',
    lowPrecise: 'eew-hypocenter-low-precise',
  );

  static Map<String, dynamic> _convertEew(EewTelegramItem eew, double opacity) {
    final hypo = eew.hypocenter.orFailBecause(
      '呼び出し元でhypocenter/latitude/longitudeがnullでないことをフィルタ済み',
    );
    return {
      'type': 'Feature',
      'geometry': {
        'type': 'Point',
        'coordinates': [hypo.longitude, hypo.latitude],
      },
      'properties': {
        'magnitude': hypo.magnitude,
        'depth': hypo.depth,
        'opacity': opacity,
      },
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;

    final hypocenterEews = useMemoized(() {
      final normal = <EewTelegramItem>[];
      final lowPrecise = <EewTelegramItem>[];
      for (final eew in eews) {
        if (eew.hypocenter?.latitude == null ||
            eew.hypocenter?.longitude == null ||
            eew.isCanceled) {
          continue;
        }
        if (eew.isLowPreciseHypocenter) {
          lowPrecise.add(eew);
        } else {
          normal.add(eew);
        }
      }
      return (normal: normal, lowPrecise: lowPrecise);
    }, [eews]);
    final normalEews = hypocenterEews.normal;
    final lowPreciseEews = hypocenterEews.lowPrecise;

    final isInitialized = useRef(false);
    final enqueue = useMapOperationQueue();

    // 点滅制御
    final isVisible = useState(true);
    useEffect(() {
      if (!enableBlink) {
        isVisible.value = true;
        return null;
      }
      final timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
        isVisible.value = !isVisible.value;
      });
      return timer.cancel;
      // isVisible はこのTimer自身がトグルする値。keysに入れると500msごとに
      // Timerが破棄・再生成され点滅が破綻するため、意図的に含めない。
      // ignore_keys: isVisible.value
    }, [enableBlink]);

    final iconOpacity = isVisible.value ? 1.0 : 0.75;

    // init操作の実行時点で最新のデータを使えるよう、Refに退避しておく。
    final latestNormalEews = useRef(normalEews);
    final latestLowPreciseEews = useRef(lowPreciseEews);
    final latestIconOpacity = useRef(iconOpacity);
    latestNormalEews.value = normalEews;
    latestLowPreciseEews.value = lowPreciseEews;
    latestIconOpacity.value = iconOpacity;

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          await (
            styleController.addImageFromAssets(
              id: 'normal-hypocenter',
              asset: Assets.images.map.normalHypocenter.path,
            ),
            styleController.addImageFromAssets(
              id: 'low-precise-hypocenter',
              asset: Assets.images.map.lowPreciseHypocenter.path,
            ),
          ).wait;

          await (
            styleController.addSource(
              GeoJsonSource(
                id: sourceId.normal,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': <Map<String, dynamic>>[],
                }),
              ),
            ),
            styleController.addSource(
              GeoJsonSource(
                id: sourceId.lowPrecise,
                data: jsonEncode({
                  'type': 'FeatureCollection',
                  'features': <Map<String, dynamic>>[],
                }),
              ),
            ),
          ).wait;

          await (
            styleController.addLayer(
              SymbolStyleLayer(
                id: layerId.normal,
                sourceId: sourceId.normal,
                layout: {
                  'icon-allow-overlap': true,
                  'icon-ignore-placement': true,
                  'icon-image': 'normal-hypocenter',
                  'icon-size': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    3,
                    0.15,
                    20,
                    0.4,
                  ],
                },
                paint: const {
                  'icon-opacity': ['get', 'opacity'],
                },
              ),
            ),
            styleController.addLayer(
              SymbolStyleLayer(
                id: layerId.lowPrecise,
                sourceId: sourceId.lowPrecise,
                layout: {
                  'icon-allow-overlap': true,
                  'icon-ignore-placement': true,
                  'icon-image': 'low-precise-hypocenter',
                  'icon-size': [
                    'interpolate',
                    ['linear'],
                    ['zoom'],
                    3,
                    0.15,
                    20,
                    0.4,
                  ],
                },
                paint: const {
                  'icon-opacity': ['get', 'opacity'],
                },
              ),
            ),
          ).wait;
          isInitialized.value = true;
          await (
            styleController.updateGeoJsonSource(
              id: sourceId.normal,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': latestNormalEews.value
                    .map((eew) => _convertEew(eew, latestIconOpacity.value))
                    .toList(),
              }),
            ),
            styleController.updateGeoJsonSource(
              id: sourceId.lowPrecise,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': latestLowPreciseEews.value
                    .map((eew) => _convertEew(eew, latestIconOpacity.value))
                    .toList(),
              }),
            ),
          ).wait;
        }),
      );

      return () {
        unawaited(
          enqueue(() {
            isInitialized.value = false;
            return MapStyleResourceRemover.remove(
              styleController: styleController,
              layerIds: [layerId.normal, layerId.lowPrecise],
              sourceIds: [sourceId.normal, sourceId.lowPrecise],
              imageIds: const ['normal-hypocenter', 'low-precise-hypocenter'],
            );
          }),
        );
      };
      // Assets は flutter_gen の静的クラス、latestIconOpacity は useRef。
      // どちらもビルド間で変化しない。
      // ignore_keys: Assets, latestIconOpacity
    }, [styleController]);

    useEffect(() {
      if (styleController == null || !isInitialized.value) {
        return null;
      }

      unawaited(
        enqueue(() async {
          await (
            styleController.updateGeoJsonSource(
              id: sourceId.normal,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': normalEews
                    .map((eew) => _convertEew(eew, iconOpacity))
                    .toList(),
              }),
            ),
            styleController.updateGeoJsonSource(
              id: sourceId.lowPrecise,
              data: jsonEncode({
                'type': 'FeatureCollection',
                'features': lowPreciseEews
                    .map((eew) => _convertEew(eew, iconOpacity))
                    .toList(),
              }),
            ),
          ).wait;
        }),
      );

      return null;
      // 3つとも enqueue に渡すクロージャ内で実際に参照している
      // (updateGeoJsonSource の features 生成)。keys から外すと
      // EEWの更新でソースが再描画されなくなるため残す。
      // ignore_keys: normalEews, lowPreciseEews, iconOpacity
    }, [styleController, normalEews, lowPreciseEews, iconOpacity]);

    return const SizedBox.shrink();
  }
}
