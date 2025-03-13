import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre/maplibre.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_utility.g.dart';

@riverpod
MapUtility mapUtility(Ref ref) => MapUtility();

class MapUtility {
  Future<void> addHypocenterImages(MapController controller) async {
    final style = controller.style;
    if (style == null) {
      throw Exception('style is null');
    }

    final normalHypocenterBytes = await rootBundle.load(
      Assets.images.map.normalHypocenter.path,
    );
    final lowPreciseHypocenterBytes = await rootBundle.load(
      Assets.images.map.lowPreciseHypocenter.path,
    );

    await (
      style.addImage(
        normalHypocenterImage,
        normalHypocenterBytes.buffer.asUint8List(),
      ),
      style.addImage(
        lowPreciseHypocenterImage,
        lowPreciseHypocenterBytes.buffer.asUint8List(),
      ),
    ).wait;
  }

  static const normalHypocenterImage = 'normal_hypocenter';
  static const lowPreciseHypocenterImage = 'low_precise_hypocenter';
}
