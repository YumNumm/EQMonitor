// ignore_for_file: invalid_annotation_target

import 'package:eqmonitor/common/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_color_provider.g.dart';

@Riverpod(keepAlive: true)
class IntensityColor extends _$IntensityColor {
  @override
  IntensityColorModel build() => normalScheme();

  IntensityColorModel normalScheme() => const IntensityColorModel(
        intensityUnknownBack: Color.fromARGB(255, 217, 217, 217),
        intensityUnknownFront: Colors.black,
        intensityZeroBack: Color.fromARGB(255, 217, 217, 217),
        intensityZeroFront: Colors.black,
        intensityOneBack: Color.fromARGB(255, 80, 180, 250),
        intensityOneFront: Colors.black,
        intensityTwoBack: Color.fromARGB(255, 155, 250, 120),
        intensityTwoFront: Colors.black,
        intensityThreeBack: Color.fromARGB(255, 255, 210, 65),
        intensityThreeFront: Colors.black,
        intensityFourBack: Color.fromARGB(255, 255, 124, 0),
        intensityFourFront: Colors.black,
        intensityFiveLowerBack: Color.fromARGB(255, 171, 21, 0),
        intensityFiveLowerFront: Colors.white,
        intensityFiveUpperBack: Color.fromARGB(255, 171, 21, 0),
        intensityFiveUpperFront: Colors.white,
        intensitySixLowerBack: Color.fromARGB(255, 255, 215, 215),
        intensitySixLowerFront: Color.fromARGB(255, 171, 21, 0),
        intensitySixUpperBack: Color.fromARGB(255, 255, 215, 215),
        intensitySixUpperFront: Color.fromARGB(255, 171, 21, 0),
        intensitySevenBack: Color.fromARGB(255, 171, 24, 66),
        intensitySevenFront: Colors.white,
      );
}
