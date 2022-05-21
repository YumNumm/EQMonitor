import 'package:eqmonitor/utils/earthquake.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

MapMarker markerBuilder(
  BuildContext context,
  int index,
  EarthQuake earthQuake,
) {
  final iconSize = earthQuake.iconSize.value;
  final point = earthQuake.analyzedPoint[index];
  final showShindo = earthQuake.showShindo.value;
  print(showShindo);
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
                      : '${point.name}\n震度: ${point.shindo!}\n${(point.pga == null) ? 'PGA:不明' : 'PGA: ${point.pga}'}',
                  textScaleFactor: 0.8,
                ),
              )
            ],
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
