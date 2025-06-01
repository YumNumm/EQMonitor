import 'package:eqmonitor/core/gen/assets.gen.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_utility.g.dart';

@riverpod
MapUtility mapUtility(Ref ref) => MapUtility();

class MapUtility {
  Future<void> addHypocenterImages(MapLibreMapController controller) async {

    final normalHypocenterBytes = await rootBundle.load(
      Assets.images.map.normalHypocenter.path,
    );
    final lowPreciseHypocenterBytes = await rootBundle.load(
      Assets.images.map.lowPreciseHypocenter.path,
    );

    await (
      controller.addImage(
        normalHypocenterImage,
        normalHypocenterBytes.buffer.asUint8List(),
      ),
      controller.addImage(
        lowPreciseHypocenterImage,
        lowPreciseHypocenterBytes.buffer.asUint8List(),
      ),
    ).wait;
  }

  static const normalHypocenterImage = 'normal_hypocenter';
  static const lowPreciseHypocenterImage = 'low_precise_hypocenter';
}
