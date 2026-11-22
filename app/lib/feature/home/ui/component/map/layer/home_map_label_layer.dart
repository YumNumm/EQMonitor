import 'dart:async';

import 'package:eqmonitor/core/hook/use_map_operation_queue.dart';
import 'package:eqmonitor/feature/home/data/model/home_map_label_parameter.dart';
import 'package:eqmonitor/feature/home/data/notifier/home_map_label_parameter_notifier.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';

class const HomeMapLabelLayer({super.key}) extends HookConsumerWidget {
  static const _regionLabelLayerId = 'home-map-region-label';
  static const _cityLabelLayerId = 'home-map-city-label';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleController = MapController.maybeOf(context)?.style;
    final paramAsync = ref.watch(homeMapLabelParameterProvider);
    final param = paramAsync.value ?? const HomeMapLabelParameter();

    final isInitialized = useRef(false);
    final latestParam = useRef(param);
    latestParam.value = param;
    final enqueue = useMapOperationQueue();

    useEffect(() {
      if (styleController == null) {
        return null;
      }

      unawaited(
        enqueue(() async {
          await _addLayers(
            styleController: styleController,
            param: latestParam.value,
          );
          isInitialized.value = true;
        }),
      );

      return () {
        unawaited(
          enqueue(() async {
            for (final id in [_regionLabelLayerId, _cityLabelLayerId]) {
              try {
                await styleController.layers.remove(id);
              } on Exception catch (_) {}
            }
          }),
        );
      };
    }, [styleController]);

    useEffect(() {
      if (styleController == null || !isInitialized.value) {
        return null;
      }
      unawaited(
        enqueue(
          () => _updateLayers(styleController: styleController, param: param),
        ),
      );
      return null;
    }, [styleController, param]);

    return const SizedBox.shrink();
  }

  static Future<void> _addLayers({
    required StyleController styleController,
    required HomeMapLabelParameter param,
  }) async {
    if (param.showRegionLabel) {
      await styleController.layers.add(
        SymbolStyleLayer(
          id: _regionLabelLayerId,
          sourceId: 'eqmonitor_map',
          sourceLayerId: 'areaForecastLocalE',
          minZoom: param.regionLabelMinZoom,
          textField: const .raw(['get', 'name']),
          textSize: .literal(param.regionTextSize),
          textFont: const .literal(['Noto Sans CJK JP Bold']),
          textAllowOverlap: const .literal(false),
          textIgnorePlacement: const .literal(false),
          textColor: const .literal(Color(0xFFFFFFFF)),
          textHaloColor: const .literal(Color(0xFF000000)),
          textHaloWidth: .literal(param.textHaloWidth),
        ),
      );
    }

    if (param.showCityLabel) {
      await styleController.layers.add(
        SymbolStyleLayer(
          id: _cityLabelLayerId,
          sourceId: 'eqmonitor_map',
          sourceLayerId: 'areaInformationCityQuake',
          minZoom: param.cityLabelMinZoom,
          textField: const .raw(['get', 'name']),
          textSize: .literal(param.cityTextSize),
          textFont: const .literal(['Noto Sans CJK JP Regular']),
          textAllowOverlap: const .literal(false),
          textIgnorePlacement: const .literal(false),
          textColor: const .literal(Color(0xFFFFFFFF)),
          textHaloColor: const .literal(Color(0xFF000000)),
          textHaloWidth: .literal(param.textHaloWidth),
        ),
      );
    }
  }

  static Future<void> _updateLayers({
    required StyleController styleController,
    required HomeMapLabelParameter param,
  }) async {
    for (final id in [_regionLabelLayerId, _cityLabelLayerId]) {
      try {
        await styleController.layers.remove(id);
      } on Exception catch (_) {}
    }
    await _addLayers(styleController: styleController, param: param);
  }
}
