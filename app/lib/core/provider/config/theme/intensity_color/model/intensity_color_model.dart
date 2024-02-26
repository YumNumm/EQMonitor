// ignore_for_file: invalid_annotation_target

import 'package:eqapi_types/eqapi_types.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_color_model.freezed.dart';
part 'intensity_color_model.g.dart';

@freezed
class IntensityColorModel with _$IntensityColorModel {
  const factory IntensityColorModel({
    required TextColorModel unknown,
    required TextColorModel zero,
    required TextColorModel one,
    required TextColorModel two,
    required TextColorModel three,
    required TextColorModel four,
    required TextColorModel fiveLower,
    required TextColorModel fiveUpper,
    required TextColorModel sixLower,
    required TextColorModel sixUpper,
    required TextColorModel seven,
  }) = _IntensityColorModel;

  factory IntensityColorModel.fromJson(Map<String, dynamic> json) =>
      _$IntensityColorModelFromJson(json);

  factory IntensityColorModel.jma() => const IntensityColorModel(
        zero: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 255, 255, 255),
        ),
        one: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 242, 242, 242),
        ),
        two: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 0, 170, 255),
        ),
        three: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 0, 65, 255),
        ),
        four: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 250, 230, 160),
        ),
        fiveLower: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 255, 230, 0),
        ),
        fiveUpper: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 255, 153, 0),
        ),
        sixLower: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 255, 40, 0),
        ),
        sixUpper: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 165, 0, 33),
        ),
        seven: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 180, 0, 104),
        ),
        unknown: TextColorModel(
          foreground: Colors.white,
          background: Colors.black,
        ),
      );
  factory IntensityColorModel.eqmonitor() => IntensityColorModel(
        zero: const TextColorModel(
          foreground: Colors.black,
          background: Colors.white,
        ),
        one: const TextColorModel(
          foreground: Colors.black,
          background: Colors.lightBlueAccent,
        ),
        two: TextColorModel(
          foreground: Colors.black,
          background: Colors.greenAccent.shade100,
        ),
        three: TextColorModel(
          foreground: Colors.black,
          background: Colors.greenAccent.shade700,
        ),
        four: TextColorModel(
          foreground: Colors.black,
          background: Colors.yellow.shade400,
        ),
        fiveLower: const TextColorModel(
          foreground: Colors.black,
          background: Colors.amber,
        ),
        fiveUpper: TextColorModel(
          foreground: Colors.black,
          background: Colors.orange.shade800,
        ),
        sixLower: const TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 255, 40, 0),
        ),
        sixUpper: const TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 165, 0, 33),
        ),
        seven: const TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 200, 0, 255),
        ),
        unknown: const TextColorModel(
          foreground: Colors.white,
          background: Colors.black,
        ),
      );

  factory IntensityColorModel.earthQuickly() => const IntensityColorModel(
        zero: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 48, 48, 48),
        ),
        one: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 32, 80, 112),
        ),
        two: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 48, 143, 191),
        ),
        three: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 132, 211, 132),
        ),
        four: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 255, 231, 48),
        ),
        fiveLower: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 255, 160, 48),
        ),
        fiveUpper: TextColorModel(
          foreground: Colors.black,
          background: Color.fromARGB(255, 239, 100, 0),
        ),
        sixLower: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 207, 16, 16),
        ),
        sixUpper: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 112, 16, 16),
        ),
        seven: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 171, 32, 178),
        ),
        unknown: TextColorModel(
          foreground: Colors.white,
          background: Color.fromARGB(255, 47, 79, 79),
        ),
      );
}

@freezed
class TextColorModel with _$TextColorModel {
  const factory TextColorModel({
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color foreground,
    @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
    required Color background,
  }) = _TextColorModel;

  factory TextColorModel.fromJson(Map<String, dynamic> json) =>
      _$TextColorModelFromJson(json);
}

extension IntensityColorModelExt on IntensityColorModel {
  TextColorModel fromJmaIntensity(JmaIntensity intensity) {
    switch (intensity) {
      case JmaIntensity.one:
        return one;
      case JmaIntensity.two:
        return two;
      case JmaIntensity.three:
        return three;
      case JmaIntensity.four:
        return four;
      case JmaIntensity.fiveUpperNoInput:
      case JmaIntensity.fiveLower:
        return fiveLower;
      case JmaIntensity.fiveUpper:
        return fiveUpper;
      case JmaIntensity.sixLower:
        return sixLower;
      case JmaIntensity.sixUpper:
        return sixUpper;
      case JmaIntensity.seven:
        return seven;
    }
  }

  TextColorModel fromJmaLgIntensity(
    JmaLgIntensity intensity,
  ) =>
      switch (intensity) {
        JmaLgIntensity.zero => zero,
        JmaLgIntensity.one => three,
        JmaLgIntensity.two => four,
        JmaLgIntensity.three => fiveLower,
        JmaLgIntensity.four => seven,
      };

  TextColorModel fromJmaForecastIntensity(
    JmaForecastIntensity intensity,
  ) {
    switch (intensity) {
      case JmaForecastIntensity.zero:
        return zero;
      case JmaForecastIntensity.one:
        return one;
      case JmaForecastIntensity.two:
        return two;
      case JmaForecastIntensity.three:
        return three;
      case JmaForecastIntensity.four:
        return four;
      case JmaForecastIntensity.fiveLower:
        return fiveLower;
      case JmaForecastIntensity.fiveUpper:
        return fiveUpper;
      case JmaForecastIntensity.sixLower:
        return sixLower;
      case JmaForecastIntensity.sixUpper:
        return sixUpper;
      case JmaForecastIntensity.seven:
        return seven;
      case JmaForecastIntensity.unknown:
        return unknown;
    }
  }

  TextColorModel fromJmaForecastLgIntensity(
    JmaForecastLgIntensity intensity,
  ) =>
      switch (intensity) {
        JmaForecastLgIntensity.zero => zero,
        JmaForecastLgIntensity.one => three,
        JmaForecastLgIntensity.two => four,
        JmaForecastLgIntensity.three => fiveLower,
        JmaForecastLgIntensity.four => seven,
        JmaForecastLgIntensity.unknown => unknown,
      };
}

Color colorFromJson(String color) => Color(int.parse(color, radix: 16));
String colorToJson(Color color) =>
    color.value.toRadixString(16).padLeft(8, '0');
