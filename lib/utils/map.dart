import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapData extends GetxController {
  final Logger logger = Get.find<Logger>();
  final RxBool isInited = false.obs;
  final RxBool isViewLoaded = false.obs;
  static MapShapeSource dataSource = const MapShapeSource.asset(
    'assets/japan.geojson',
    dataCount: 1903,
    shapeDataField: '',
  );
  final List<MapLatLng> circles = <MapLatLng>[
    //const MapLatLng(35, 139),
  ];
  @override
  Future<void> onInit() async {
    super.onInit();
    isInited.value = true;
  }
}

class ObservePoint {
  final String name;
  final double latitude;
  final double longitude;
  final Color color;
  const ObservePoint({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.color,
  });
}
