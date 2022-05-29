import 'package:bordered_text/bordered_text.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/JmaIntensity.dart';
import 'package:eqmonitor/utils/KyoshinMonitorlib/kyoshinMonitorlibTime.dart';
import 'package:eqmonitor/utils/analyzedpoints.dart';
import 'package:eqmonitor/utils/earthquake.dart';
import 'package:eqmonitor/utils/image_cache/image_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../svir/svir.dart';

MapMarker markerBuilder(
  BuildContext context,
  int index,
  EarthQuake earthQuake,
  AssetImageCache aic,
  Svir svir,
  KyoshinMonitorlibTime kmoniTime,
) {
  final iconSize = earthQuake.iconSize.value;
  final AnalyzedPoint point;
  if (earthQuake.analyzedPoint.length > index) {
    point = earthQuake.analyzedPoint[index];
  } else {
    point =
        earthQuake.eewAnalyzedPoint[index - earthQuake.analyzedPoint.length];
  }

  if (point.pointType.name == PointType.Observer.name) {
    // 観測点
    final showShindo = earthQuake.showShindo.value;
    return MapMarker(
      latitude: point.lat,
      longitude: point.lon,
      child: (earthQuake.zoomLevel.value > 20)
          ? Stack(
              children: [
                Align(
                  child: Container(
                    width: earthQuake.iconSize.value,
                    height: earthQuake.iconSize.value,
                    decoration: (point.shindo == null)
                        ? const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          )
                        : BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                showShindo ? point.shindoColor : point.pgaColor,
                          ),
                  ),
                ),
                Align(
                  child: Text(
                    (point.shindo == null)
                        ? point.name
                        : '${point.name}\n震度: ${point.shindo!.toStringAsFixed(1)}\n${(point.pga == null) ? 'PGA:不明' : 'PGA: ${point.pga!.toStringAsFixed(1)}'}',
                    textScaleFactor: 0.8,
                  ),
                ),
              ],
            )
          : (point.intensity != JmaIntensity.Int0 &&
                  point.intensity != JmaIntensity.Unknown)
              ? Align(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.memory(
                      aic.assets[point.intensity]!,
                      height: iconSize * 3,
                      width: iconSize * 3,
                    ),
                  ),
                )
              : Container(
                  width: earthQuake.iconSize.value,
                  height: earthQuake.iconSize.value,
                  decoration: (point.shindo == null)
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        )
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              showShindo ? point.shindoColor : point.pgaColor,
                        ),
                ),
    );
  }

  //? Get EEW Information
  final eew = svir.svirResponse.value;

  if ((kmoniTime.now.value
                  .difference(
                    svir.svirResponse.value.head.dateTime,
                  )
                  .inSeconds <=
              180 &&
          kmoniTime.now.value
                  .difference(
                    svir.svirResponse.value.head.dateTime,
                  )
                  .inSeconds >=
              0) ||
      !kDebugMode) {
    return const MapMarker(
      latitude: 0,
      longitude: 0,
      child: SizedBox.shrink(),
    );
  }
  if (point.pointType.name == PointType.HypoCenter.name) {
    return MapMarker(
      latitude: eew.body.earthquake.hypocenter.lat,
      longitude: eew.body.earthquake.hypocenter.lon,
      child: BorderedText(
        strokeWidth: iconSize * 2,
        strokeColor: (Get.isDarkMode) ? Colors.white : Colors.black,
        child: Text(
          '×',
          style: TextStyle(
            fontSize: iconSize * 10,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 17, 0),
          ),
        ),
      ),
    );
  }
  return const MapMarker(
    latitude: 0,
    longitude: 0,
    child: Text('A'),
  );
}
