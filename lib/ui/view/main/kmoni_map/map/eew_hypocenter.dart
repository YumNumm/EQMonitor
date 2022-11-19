import 'package:eqmonitor/ui/view/main/kmoni_map/map/eew_hypocenter_assuming.dart';
import 'package:eqmonitor/ui/view/main/kmoni_map/map/eew_hypocenter_normal.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../provider/earthquake/eew_controller.dart';
import '../../../../../schema/remote/dmdata/eew-information/earthquake/accuracy/epicCenterAccuracy.dart';

/// 緊急地震速報関連のWidget
class EewHypocentersWidget extends ConsumerWidget {
  const EewHypocentersWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eews =
        ref.watch(eewHistoryProvider.select((value) => value.showEews));

    return Stack(
      children: <Widget>[
        for (final eew in eews)
          if (eew.value.earthQuake?.isAssuming == true ||
              eew.value.earthQuake?.hypoCenter.accuracy.epicCenterAccuracy
                      .epicCenterAccuracy ==
                  EpicCenterAccuracy.f1)
            EewHypoCenterAssumingMapWidget(
              eew: eew,
            )
          else
            EewHypoCenterNormalMapWidget(
              eew: eew,
            ),
      ],
    );
  }
}
