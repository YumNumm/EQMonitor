import 'package:eqmonitor/core/provider/time_ticker.dart';
import 'package:eqmonitor/feature/eew/data/eew_alive_telegram.dart';
import 'package:eqmonitor/feature/map/data/layer/eew_hypocenter/eew_hypocenter_layer.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'eew_hypocenter_layer_controller.g.dart';

@riverpod
class EewHypocenterLayerController extends _$EewHypocenterLayerController {
  @override
  EewHypocenterLayer build(EewHypocenterIcon icon) {
    ref
      ..listen(
        eewAliveTelegramProvider,
        (_, next) {
          final hypocenters = (next ?? [])
              .where(
                (eew) {
                  final isLowPrecise = eew.isLevelEew ||
                      (eew.isPlum ?? false) ||
                      (eew.isIpfOnePoint);

                  final base = eew.latitude != null &&
                      eew.longitude != null &&
                      !eew.isCanceled;

                  return switch (icon) {
                    EewHypocenterIcon.normal => base && !isLowPrecise,
                    EewHypocenterIcon.lowPrecise => base && isLowPrecise,
                  };
                },
              )
              .map(
                (eew) => EewHypocenter(
                  latitude: eew.latitude!,
                  longitude: eew.longitude!,
                ),
              )
              .toList();

          state = state.copyWith(
            hypocenters: hypocenters,
          );
        },
      )
      ..listen(
        timeTickerProvider(const Duration(milliseconds: 500)),
        (_, __) {
          state = state.copyWith(
            visible: !state.visible,
          );
        },
      );

    return EewHypocenterLayer(
      id: 'eew-hypocenter-${icon.name}',
      sourceId: 'eew-hypocenter-source-${icon.name}',
      visible: true,
      iconImage: icon.asset.name,
      hypocenters: [],
    );
  }
}
