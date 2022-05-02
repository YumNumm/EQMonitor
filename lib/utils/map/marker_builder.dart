import 'package:eqmonitor/utils/earthquake.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

MapMarker markerBuilder(
    BuildContext context, int index, EarthQuake earthQuake) {
  final iconSize = earthQuake.iconSize.value;
  return MapMarker(
    latitude: earthQuake.analyzedPoint[index].lat,
    longitude: earthQuake.analyzedPoint[index].lon,
    child: (earthQuake.zoomLevel.value > 20)
        ? Stack(
            children: [
              Align(
                child: Container(
                  width: earthQuake.iconSize.value,
                  height: earthQuake.iconSize.value,
                  decoration: (earthQuake.analyzedPoint[index].shindo == null)
                      ? const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                        )
                      : BoxDecoration(
                          shape: BoxShape.circle,
                          color: earthQuake.analyzedPoint[index].color,
                        ),
                ),
              ),
              Align(
                child: Text(
                  (earthQuake.analyzedPoint[index].shindo == null)
                      ? earthQuake.analyzedPoint[index].name
                      : '${earthQuake.analyzedPoint[index].name}\n震度: ${earthQuake.analyzedPoint[index].shindo}',
                ),
              )
            ],
          )
        : Container(
            width: earthQuake.iconSize.value,
            height: earthQuake.iconSize.value,
            decoration: (earthQuake.analyzedPoint[index].shindo == null)
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  )
                : BoxDecoration(
                    shape: BoxShape.circle,
                    color: earthQuake.analyzedPoint[index].color,
                  ),
          ),
  );
}
