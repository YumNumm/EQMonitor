import 'package:eqmonitor/utils/map/customZoomPanBehavior.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../utils/map.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);
  final CustomZoomPanBehavior zoomPanBehavior =
      Get.find<CustomZoomPanBehavior>();
  final MapData mapData = Get.find<MapData>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfMaps(
        layers: <MapLayer>[
          MapShapeLayer(
            source: MapData.dataSource,
            zoomPanBehavior: CustomZoomPanBehavior(),
            loadingBuilder: (context) => const Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
