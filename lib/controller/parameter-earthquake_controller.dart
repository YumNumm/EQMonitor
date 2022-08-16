import 'dart:convert';

import 'package:eqmonitor/model/parameter-earthquake_model.dart';
import 'package:eqmonitor/schema/dmdata/parameter-earthquake/parameter-earthquake.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ParameterEarthquakeProvider
    extends StateNotifier<ParameterEarthquakeModel> {
  ParameterEarthquakeProvider()
      : super(
          const ParameterEarthquakeModel(
            parameterEarthquake: null,
            isMapLoaded: false,
            loadDuration: null,
          ),
        ) {
    onInit();
  }
  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      printTime: true,
    ),
  );

  void onInit() {
    _loadParameter();
  }

  Future<void> _loadParameter() async {
    final stopwatch = Stopwatch()..start();
    final body =
        await rootBundle.loadString('assets/parameter-earthquake.json');
    final json = jsonDecode(body) as Map<String, dynamic>;
    final parameter = ParameterEarthquake.fromJson(json);
    final duration = (stopwatch..stop()).elapsed;
    if (mounted) {
      state = state.copyWith(
        parameterEarthquake: parameter,
        isMapLoaded: true,
        loadDuration: duration,
      );
    }
  }
}
