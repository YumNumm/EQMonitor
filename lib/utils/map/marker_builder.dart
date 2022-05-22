import 'package:eqmonitor/utils/KyoshinMonitorlib/JmaIntensity.dart';
import 'package:eqmonitor/utils/earthquake.dart';
import 'package:eqmonitor/utils/image_cache/image_cache.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

MapMarker markerBuilder(
  BuildContext context,
  int index,
  EarthQuake earthQuake,
  AssetImageCache aic,
) {
  final iconSize = earthQuake.iconSize.value;
  final point = earthQuake.analyzedPoint[index];
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
                        color: showShindo ? point.shindoColor : point.pgaColor,
                      ),
              ),
  );
}
