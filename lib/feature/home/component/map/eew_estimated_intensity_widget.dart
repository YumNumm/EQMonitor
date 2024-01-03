import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:eqapi_types/model/components/eew_intensity.dart';
import 'package:eqapi_types/model/telegram_v3.dart';
import 'package:eqmonitor/core/component/map/data/model/mutable_projected_feature_layer.dart';
import 'package:eqmonitor/core/component/map/model/map_config.dart';
import 'package:eqmonitor/core/component/map/model/map_state.dart';
import 'package:eqmonitor/core/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/topology_map/provider/topology_maps.dart';
import 'package:eqmonitor/feature/earthquake_history/model/state/earthquake_history_item.dart';
import 'package:eqmonitor/feature/home/features/eew/provider/eew_alive_telegram.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:topo_map/topo_map.dart';

part 'eew_estimated_intensity_widget.g.dart';

/// EEWの予想震度のリスト
@Riverpod(dependencies: [EewAliveTelegram, EewAliveTelegram])
class EewEstimatedIntensityList extends _$EewEstimatedIntensityList {
  @override
  List<(int code, JmaForecastIntensity intensity)> build() {
    ref.listen(
      eewAliveTelegramProvider,
      (_, next) => state = _build(next ?? []),
    );
    return _build(ref.read(eewAliveTelegramProvider) ?? []);
  }

  List<(int code, JmaForecastIntensity intensity)> _build(
    List<EarthquakeHistoryItem> eews,
  ) {
    final normalEews = eews.where((e) => e.latestEew is TelegramVxse45Body);

    final regions = normalEews
        .map((e) => (e.latestEew! as TelegramVxse45Body).regions ?? [])
        .flattened;
    final result = <(int, JmaForecastIntensity)>[];
    regions
        .groupListsBy((e) => int.tryParse(e.code) ?? 0)
        .forEach((key, value) {
      final maxIntensity = value
          .map((e) => e.forecastMaxInt.toDisplayMaxInt())
          .sorted((a, b) => b.maxInt.compareTo(a.maxInt))
          .firstOrNull;
      if (maxIntensity != null) {
        result.add((key, maxIntensity.maxInt));
      }
    });
    return result;
  }
}

class EewEstimatedIntensityWidget extends HookConsumerWidget {
  const EewEstimatedIntensityWidget({
    super.key,
    required this.mapKey,
    this.onlyBorder = false,
  });
  final Key mapKey;
  final bool onlyBorder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(MapViewModelProvider(mapKey));
    final zoomCachedProjectedFeatureLayer =
        ref.watch(zoomCachedProjectedFeatureLayerProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;

    final eews = ref.watch(eewEstimatedIntensityListProvider);
    final intensityColorScheme = ref.watch(intensityColorProvider);

    return switch (zoomCachedProjectedFeatureLayer.value) {
      null => const SizedBox.shrink(),
      final data => CustomPaint(
          size: Size.infinite,
          willChange: true,
          isComplex: true,
          painter: _EewEstimatedIntensityPainter(
            state: state,
            onlyBorder: onlyBorder,
            colorScheme:
                isDark ? MapColorScheme.dark() : MapColorScheme.light(),
            maps: data,
            areas: eews
                .map(
                  (e) => (
                    e.$1,
                    intensityColorScheme
                        .fromJmaForecastIntensity(e.$2)
                        .background
                  ),
                )
                .toList(),
          ),
        ),
    };
  }
}

class _EewEstimatedIntensityPainter extends CustomPainter {
  _EewEstimatedIntensityPainter({
    required this.state,
    required this.onlyBorder,
    required this.colorScheme,
    required this.maps,
    required this.areas,
  });

  final MapState state;
  final bool onlyBorder;
  final MapColorScheme colorScheme;
  final Map<LandLayerType, ZoomCachedProjectedFeatureLayer> maps;
  final List<(int, Color)> areas;

  @override
  void paint(Canvas canvas, Size size) {
    for (final e in areas) {
      drawAreaPolygon(
        canvas,
        size,
        e.$1,
        e.$2,
      );
    }
    return;
  }

  void drawAreaPolygon(
    Canvas canvas,
    Size size,
    int id,
    Color color,
  ) {
    for (final e in maps[LandLayerType.earthquakeInformationSubdivisionArea]!
        .projectedPolygonFeatures
        .where(
          (element) => (element.code ?? 1) == id,
        )) {
      final points = e.getPoints(state.zoomLevel.truncate());
      final offsets = points.map(state.globalPointToOffset).toList();
      if (!offsets.any(
        (e) => e.dx > 0 && e.dy > 0 && e.dx < size.width && e.dy < size.height,
      )) {
        continue;
      }

      final path = Path()
        ..addPolygon(
          offsets,
          true,
        );

      try {
        canvas.drawPath(
          path,
          Paint()
            ..style = PaintingStyle.fill
            ..color = color
            ..isAntiAlias = true,
        );
      } on Exception catch (e) {
        log(e.toString());
      }
    }
  }

  @override
  bool shouldRepaint(covariant _EewEstimatedIntensityPainter oldDelegate) =>
      oldDelegate.state != state ||
      oldDelegate.colorScheme != colorScheme ||
      oldDelegate.onlyBorder != onlyBorder ||
      oldDelegate.maps != maps ||
      oldDelegate.areas != areas;
}
