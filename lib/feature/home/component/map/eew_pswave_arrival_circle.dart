import 'package:eqapi_schema/extension/telegram_v3.dart';
import 'package:eqapi_schema/model/telegram_v3.dart';
import 'package:eqmonitor/common/component/map/model/map_state.dart';
import 'package:eqmonitor/common/component/map/view_model/map_viewmodel.dart';
import 'package:eqmonitor/common/feature/map/provider/map_data_provider.dart';
import 'package:eqmonitor/common/feature/map/utils/web_mercator_projection.dart';
import 'package:eqmonitor/feature/home/features/eew/eew_provider.dart';
import 'package:eqmonitor/gen/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class EewHypocenterWidget extends HookConsumerWidget {
  const EewHypocenterWidget({required this.mapKey, super.key});

  final Key mapKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(MapViewModelProvider(mapKey));
    final eewTelegrams = ref.watch(eewTelegramProvider);
    final hypocenters = useMemoized(
      () => eewTelegrams
          .where(
            (e) => e.latestEew != null && e.latestEew is TelegramVxse45Body,
          )
          .map((e) => e.latestEew! as TelegramVxse45Body)
          .map(
            (e) => _HypoModel(
              type: (e.isPlum || e.isIpfOnePoint || e.isLevelEew)
                  ? _HypocenterType.lowPrecise
                  : _HypocenterType.normal,
              globalPoint: e.hypocenter?.coordinate != null
                  ? WebMercatorProjection().project(e.hypocenter!.coordinate!)
                  : null,
              magnitude: e.magnitude,
              depth: e.depth,
            ),
          )
          .toList(),
      [eewTelegrams],
    );
    final hypoWidget = RepaintBoundary(
      child: CustomPaint(
        painter: _HypocenterPainter(
          state: state,
          hypocenters: hypocenters,
        ),
        size: Size.infinite,
      ),
    );
    return Opacity(
      opacity: opacityAnimation,
      child: hypoWidget,
    );
  }
}

class _HypocenterPainter extends CustomPainter {
  _HypocenterPainter({
    required this.state,
    required this.hypocenters,
  });

  final MapState state;
  final List<_HypoModel> hypocenters;

  @override
  void paint(Canvas canvas, Size size) {
  }

  @override
  bool shouldRepaint(covariant _HypocenterPainter oldDelegate) =>
      oldDelegate.hypocenters != hypocenters || oldDelegate.state != state;
}

enum _HypocenterType {
  normal,
  lowPrecise,
  ;
}

class _HypoModel {
  _HypoModel({
    required this.type,
    required this.globalPoint,
    required this.magnitude,
    required this.depth,
  });

  final _HypocenterType type;
  final GlobalPoint? globalPoint;
  final double? magnitude;
  final int? depth;
}
