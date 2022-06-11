import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapData extends GetxController {
  final Logger logger = Get.find<Logger>();
  final RxBool isInited = false.obs;
  final RxBool isViewLoaded = false.obs;
  final List<MapLatLng> circles = <MapLatLng>[
    //const MapLatLng(35, 139),
  ];
  @override
  Future<void> onInit() async {
    super.onInit();
    isInited.value = true;
  }

  static MapShapeSource japanSource =
      const MapShapeSource.asset('assets/maps/japan.json');

  static MapShapeSource tsunamiSource =
      const MapShapeSource.asset('assets/maps/tsunami.json');

  static MapShapeSource areasSource =
      const MapShapeSource.asset('assets/maps/areas.json');
}

class ObservePoint {
  const ObservePoint({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.color,
  });
  final String name;
  final double latitude;
  final double longitude;
  final Color color;
}
