import 'package:collection/collection.dart';
import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/map/data/layer/eew_estimated_intensity/eew_estimated_intensity_layer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_estimated_intensity_controller.g.dart';

@Riverpod(keepAlive: true)
class EewEstimatedIntensityLayerController
    extends _$EewEstimatedIntensityLayerController {
  @override
  EewEstimatedIntensityLayer build(JmaForecastIntensity intensity) {
    final intensityColorMap = ref
        .watch(intensityColorProvider)
        .fromJmaForecastIntensity(intensity);
    final backgroundColor = intensityColorMap.background;

    final aliveEews = ref.watch(eewAliveTelegramProvider);
    final regionCodes =
        (aliveEews ?? [])
            .map((eew) => eew.regions)
            .nonNulls
            .flattened
            .where(
              (eew) => eew.forecastMaxInt.toDisplayMaxInt().maxInt == intensity,
            )
            .map((eew) => eew.code)
            .toList();
    return EewEstimatedIntensityLayer.fromJmaForecastIntensity(
      color: backgroundColor,
      intensity: intensity,
      regionCodes: regionCodes,
    );
  }
}
