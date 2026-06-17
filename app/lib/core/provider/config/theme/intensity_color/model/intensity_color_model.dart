import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/core/model/intensity/jma_lpgm_intensity.dart';
import 'package:eqmonitor/core/util/converter/color_converter.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'intensity_color_model.freezed.dart';
part 'intensity_color_model.g.dart';

@freezed
abstract class IntensityColorModel with _$IntensityColorModel {
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

  factory IntensityColorModel.fromBaseColors({
    required Color unknwon,
    required Color zero,
    required Color one,
    required Color two,
    required Color three,
    required Color four,
    required Color fiveLower,
    required Color fiveUpper,
    required Color sixLower,
    required Color sixUpper,
    required Color seven,
  }) => IntensityColorModel(
    unknown: TextColorModel.fromBackground(unknwon),
    zero: TextColorModel.fromBackground(zero),
    one: TextColorModel.fromBackground(one),
    two: TextColorModel.fromBackground(two),
    three: TextColorModel.fromBackground(three),
    four: TextColorModel.fromBackground(four),
    fiveLower: TextColorModel.fromBackground(fiveLower),
    fiveUpper: TextColorModel.fromBackground(fiveUpper),
    sixLower: TextColorModel.fromBackground(sixLower),
    sixUpper: TextColorModel.fromBackground(sixUpper),
    seven: TextColorModel.fromBackground(seven),
  );

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
    unknown: TextColorModel(foreground: Colors.white, background: Colors.black),
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
abstract class TextColorModel with _$TextColorModel {
  const factory TextColorModel({
    @ColorJsonConverter() required Color foreground,
    @ColorJsonConverter() required Color background,
  }) = _TextColorModel;

  factory TextColorModel.fromJson(Map<String, dynamic> json) =>
      _$TextColorModelFromJson(json);

  factory TextColorModel.fromBackground(Color background) => TextColorModel(
    foreground: background.computeLuminance() > 0.5
        ? Colors.black
        : Colors.white,
    background: background,
  );
}

enum IntensityColorTarget {
  unknown('不明'),
  zero('0'),
  one('1'),
  two('2'),
  three('3'),
  four('4'),
  fiveLower('5弱'),
  fiveUpper('5強'),
  sixLower('6弱'),
  sixUpper('6強'),
  seven('7');

  const IntensityColorTarget(this.label);
  final String label;
}

extension IntensityColorModelExt on IntensityColorModel {
  TextColorModel fromTarget(IntensityColorTarget target) => switch (target) {
    IntensityColorTarget.unknown => unknown,
    IntensityColorTarget.zero => zero,
    IntensityColorTarget.one => one,
    IntensityColorTarget.two => two,
    IntensityColorTarget.three => three,
    IntensityColorTarget.four => four,
    IntensityColorTarget.fiveLower => fiveLower,
    IntensityColorTarget.fiveUpper => fiveUpper,
    IntensityColorTarget.sixLower => sixLower,
    IntensityColorTarget.sixUpper => sixUpper,
    IntensityColorTarget.seven => seven,
  };

  IntensityColorModel copyWithTargetBackground(
    IntensityColorTarget target,
    Color background,
  ) {
    final color = TextColorModel.fromBackground(background);
    return switch (target) {
      IntensityColorTarget.unknown => copyWith(unknown: color),
      IntensityColorTarget.zero => copyWith(zero: color),
      IntensityColorTarget.one => copyWith(one: color),
      IntensityColorTarget.two => copyWith(two: color),
      IntensityColorTarget.three => copyWith(three: color),
      IntensityColorTarget.four => copyWith(four: color),
      IntensityColorTarget.fiveLower => copyWith(fiveLower: color),
      IntensityColorTarget.fiveUpper => copyWith(fiveUpper: color),
      IntensityColorTarget.sixLower => copyWith(sixLower: color),
      IntensityColorTarget.sixUpper => copyWith(sixUpper: color),
      IntensityColorTarget.seven => copyWith(seven: color),
    };
  }

  TextColorModel fromJmaIntensity(JmaIntensity intensity) =>
      switch (intensity) {
        JmaIntensity.unknown => unknown,
        JmaIntensity.zero => zero,
        JmaIntensity.one => one,
        JmaIntensity.two => two,
        JmaIntensity.three => three,
        JmaIntensity.four => four,
        JmaIntensity.fiveUnknown => fiveLower,
        JmaIntensity.fiveLower => fiveLower,
        JmaIntensity.fiveUpper => fiveUpper,
        JmaIntensity.sixLower => sixLower,
        JmaIntensity.sixUpper => sixUpper,
        JmaIntensity.seven => seven,
      };

  TextColorModel fromJmaLpgmIntensity(JmaLpgmIntensity intensity) =>
      switch (intensity) {
        JmaLpgmIntensity.unknown => unknown,
        JmaLpgmIntensity.zero => zero,
        JmaLpgmIntensity.one => three,
        JmaLpgmIntensity.two => four,
        JmaLpgmIntensity.three => fiveLower,
        JmaLpgmIntensity.four => seven,
      };
}
