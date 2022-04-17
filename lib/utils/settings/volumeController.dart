import 'dart:developer' as dev;

import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

class VolumeController extends GetxController {
  final _logger = Get.find<Logger>();
  final stream = PerfectVolumeControl.stream;
  final RxDouble volume = (-1.0).obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    PerfectVolumeControl.stream.listen((event) {
      volume.value = event;
      dev.log('changed: ${volume * 100}', name: 'VolumeController');
    });
  }
}
