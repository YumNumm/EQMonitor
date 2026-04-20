import 'dart:async';
import 'dart:typed_data';

import 'package:eqmonitor/core/component/intenisty/intensity_icon_type.dart';
import 'package:eqmonitor/core/component/intenisty/intensity_value_icon.dart';
import 'package:eqmonitor/core/component/intenisty/lpgm_intensity_icon.dart';
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/intensity_color_provider.dart';
import 'package:eqmonitor/core/util/widget_to_image.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/station_intensity_icon_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/ui/layer/earthquake_history_station_intensity_layer.dart'
    show EarthquakeHistoryStationIntensityLayer;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// アプリ起動時（ホーム画面）に観測点震度アイコンをまとめてレンダリングし、
/// [StationIntensityIconBytes] プロバイダに格納する。
///
/// [EarthquakeHistoryStationIntensityLayer] はここで生成されたバイト列を
/// `StyleController.addImage` で直接登録するため、マップ初期化が高速になる。
class EarthquakeHistoryStationIconPreloader extends HookConsumerWidget {
  const EarthquakeHistoryStationIconPreloader({super.key});

  static const _iconLogicalSize = Size(40, 40);
  static const _iconSmallPrefix = 'eq-station-sm-';
  static const _iconSmallNoTextPrefix = 'eq-station-sm-nt-';
  static const _lpgmIconSmallPrefix = 'eq-station-lpgm-sm-';
  static const _lpgmIconSmallNoTextPrefix = 'eq-station-lpgm-sm-nt-';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final container = ref.container;
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);

    useEffect(
      () {
        unawaited(_prerender(container, pixelRatio, ref));
        return null;
      },
      // intensityColorProvider の変化でアイコンを再生成する
      [container, pixelRatio, ref.watch(intensityColorProvider)],
    );

    return const SizedBox.shrink();
  }

  Future<void> _prerender(
    ProviderContainer container,
    double pixelRatio,
    WidgetRef ref,
  ) async {
    final rendered = <String, Uint8List>{};

    for (final jma in JmaIntensity.values) {
      for (final (prefix, type) in [
        (_iconSmallPrefix, IntensityIconType.small),
        (_iconSmallNoTextPrefix, IntensityIconType.smallWithoutText),
      ]) {
        final id = '$prefix${jma.name}';
        final bytes = await renderWidgetToImageBytes(
          widget: UncontrolledProviderScope(
            container: container,
            child: IntensityValueIcon(intensity: jma, type: type),
          ),
          logicalSize: _iconLogicalSize,
          pixelRatio: pixelRatio,
        );
        if (bytes != null) {
          rendered[id] = bytes;
        }
      }
    }

    for (final lpgm in JmaLpgmIntensity.values) {
      for (final (prefix, type) in [
        (_lpgmIconSmallPrefix, IntensityIconType.small),
        (_lpgmIconSmallNoTextPrefix, IntensityIconType.smallWithoutText),
      ]) {
        final id = '$prefix${lpgm.name}';
        final bytes = await renderWidgetToImageBytes(
          widget: UncontrolledProviderScope(
            container: container,
            child: LpgmIntensityIcon(intensity: lpgm, type: type),
          ),
          logicalSize: _iconLogicalSize,
          pixelRatio: pixelRatio,
        );
        if (bytes != null) {
          rendered[id] = bytes;
        }
      }
    }

    ref.read(stationIntensityIconBytesProvider.notifier).storeAll(rendered);
  }
}
